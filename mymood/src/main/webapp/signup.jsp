<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyMood - 会員登録</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<div class="login-box">

	<h1 class="logo">MyMood</h1>
	<h2>会員登録</h2>

	<% if (request.getAttribute("errorMsg") != null) { %>
		<p class="error"><%= request.getAttribute("errorMsg") %></p>
	<% } %>

	<form action="signup-servlet" method="post">
		<div class="field">
			<label>ユーザID</label>
			<input type="text" name="userID" required
				value="<%= request.getAttribute("userID") == null ? "" : request.getAttribute("userID") %>">
		</div>
		<div class="field">
			<label>パスワード</label>
			<input type="password" name="password" required>
		</div>
		<div class="field">
			<label>ニックネーム</label>
			<input type="text" name="nickname" required
				value="<%= request.getAttribute("nickname") == null ? "" : request.getAttribute("nickname") %>">
		</div>
		<button type="submit" class="btn-main">登録する</button>
	</form>

	<p class="link"><a href="login.jsp">ログイン画面へ戻る</a></p>

</div>

</body>
</html>