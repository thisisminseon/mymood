<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.Cart" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyMood - カート</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<jsp:include page="header-navi.jsp" />

<%
	Cart cart = (Cart) session.getAttribute("cart");
%>

<div class="container">

	<h2>カート内一覧</h2>

	<%
		if (cart == null || cart.getListProd().isEmpty()) {
	%>
		<p class="empty">カートは空です。</p>
		<a href="select-servlet" class="btn-main">買い物を続ける</a>
	<%
		} else {
			List<Product> list = cart.getListProd();
	%>
		<table class="cart-table">
			<tr>
				<th>商品名</th>
				<th>価格</th>
				<th></th>
			</tr>
		<%
			for (int i = 0; i < list.size(); i++) {
				Product p = list.get(i);
		%>
			<tr>
				<td><%= p.getName() %></td>
				<td><%= p.getPriceString() %></td>
				<td>
					<form action="remove-prod-servlet" method="post">
						<input type="hidden" name="idx" value="<%= i %>">
						<button type="submit" class="btn-remove">削除</button>
					</form>
				</td>
			</tr>
		<%
			}
		%>
		</table>

		<div class="total">合計： <%= cart.getTotalPriceString() %></div>

		<div class="cart-actions">
			<a href="select-servlet" class="btn-sub">買い物を続ける</a>
			<form action="pay-servlet" method="post">
				<button type="submit" class="btn-main">精算する</button>
			</form>
		</div>
	<%
		}
	%>

</div>

</body>
</html>