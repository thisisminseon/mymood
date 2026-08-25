<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyMood</title>
<link rel="icon" href="favicon.ico">
<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
<link rel="apple-touch-icon" href="apple-touch-icon.png">
<link rel="stylesheet" href="style.css">
</head>
<body>

<jsp:include page="header-navi.jsp" />

<%
	Product prod = (Product) request.getAttribute("detailProd");
%>

<div class="container">

<% if (prod != null) { %>

	<div class="detail-wrap">

		<div class="detail-image">
			<img src="images/<%= prod.getImageFile() %>" alt="<%= prod.getName() %>">
		</div>

		<div class="detail-info">
			<span class="detail-category"><%= prod.getCategory() %></span>
			<h2 class="detail-name"><%= prod.getName() %></h2>
			<p class="detail-price"><%= prod.getPriceString() %></p>

			<div class="detail-buttons">
				<form action="add-prod-servlet" method="post">
					<input type="hidden" name="prodId" value="<%= prod.getId() %>">
					<input type="hidden" name="category" value="<%= prod.getCategory() %>">
					<button type="submit" class="btn-sub">カートに追加</button>
				</form>

				<form action="buy-now-servlet" method="post">
					<input type="hidden" name="prodId" value="<%= prod.getId() %>">
					<button type="submit" class="btn-main">今すぐ購入</button>
				</form>
			</div>
		</div>

	</div>

	<div class="detail-desc">
		<h3>商品説明</h3>
		<p><%= prod.getDescription() %></p>
	</div>

<% } %>

	<a href="select-servlet" class="btn-sub">商品一覧に戻る</a>

</div>

</body>
</html>