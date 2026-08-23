<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyMood - 会員管理</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<div class="header">
	<span class="logo-small">MyMood 管理画面</span>
	<div class="header-right">
		<a href="logout-servlet">ログアウト</a>
	</div>
</div>

<%
	List<User> listUser = (List<User>) request.getAttribute("listUser");
%>

<div class="container">

	<h2>会員一覧</h2>

	<table class="admin-table">
		<tr>
			<th>ユーザID</th>
			<th>ニックネーム</th>
			<th>状態</th>
			<th>登録日</th>
			<th>操作</th>
		</tr>
	<%
		if (listUser != null) {
			for (User u : listUser) {
	%>
		<tr>
			<td><%= u.getUserid() %></td>
			<td><%= u.getNickname() %></td>
			<td>
			<%
				if (u.isAdmin()) {
			%>
				<span class="badge-admin">管理者</span>
			<%
				} else if ("active".equals(u.getStatus())) {
			%>
				<span class="badge-active">有効</span>
			<%
				} else if ("suspended".equals(u.getStatus())) {
			%>
				<span class="badge-suspended">停止中</span>
			<%
				} else {
			%>
				<span class="badge-withdrawn">退会済</span>
			<%
				}
			%>
			</td>
			<td><%= u.getCreatedAt() %></td>
			<td>
			<%
				if (!u.isAdmin()) {
					if ("active".equals(u.getStatus())) {
			%>
				<form action="admin-user-servlet" method="post" class="inline-form">
					<input type="hidden" name="targetId" value="<%= u.getUserid() %>">
					<input type="hidden" name="action" value="suspend">
					<button type="submit" class="btn-warn">停止</button>
				</form>
			<%
					} else if ("suspended".equals(u.getStatus())) {
			%>
				<form action="admin-user-servlet" method="post" class="inline-form">
					<input type="hidden" name="targetId" value="<%= u.getUserid() %>">
					<input type="hidden" name="action" value="activate">
					<button type="submit" class="btn-sub">解除</button>
				</form>
			<%
					}
					if (!"withdrawn".equals(u.getStatus())) {
			%>
				<form action="admin-user-servlet" method="post" class="inline-form">
					<input type="hidden" name="targetId" value="<%= u.getUserid() %>">
					<input type="hidden" name="action" value="withdraw">
					<button type="submit" class="btn-danger">退会</button>
				</form>
			<%
					}
				}
			%>
			</td>
		</tr>
	<%
			}
		}
	%>
	</table>

</div>

</body>
</html>