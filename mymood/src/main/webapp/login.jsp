<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyMood - ログイン</title>
<link rel="icon" href="favicon.ico">
<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
<link rel="apple-touch-icon" href="apple-touch-icon.png">
<link rel="stylesheet" href="style.css">
</head>
<body>

	<div class="login-box">

		<h1 class="logo">MyMood</h1>

		<%
		if (request.getAttribute("infoMsg") != null) {
		%>
		<p class="info"><%=request.getAttribute("infoMsg")%></p>
		<%
		}
		%>


		<%
		if (request.getAttribute("errorMsg") != null) {
		%>
		<p class="error"><%=request.getAttribute("errorMsg")%></p>
		<%
		}
		%>

		<form action="login-servlet" method="post">
			<div class="field">
				<label>ユーザID</label> <input type="text" name="userID" required>
			</div>
			<div class="field">
				<label>パスワード</label> <input type="password" name="password" required>
			</div>
			<button type="submit" class="btn-main">ログイン</button>
		</form>

		<p class="link">
			<a href="signup.jsp">会員登録はこちら</a>
		</p>

	</div>

</body>
</html>