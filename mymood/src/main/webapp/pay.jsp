<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.Cart" %>
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
	Cart payCart = (Cart) session.getAttribute("pay");
%>

<div class="container">

	<h2>精算完了</h2>
	<p class="thanks">ご購入ありがとうございました。</p>

	<%
		if (payCart != null && !payCart.getListProd().isEmpty()) {
			List<Product> list = payCart.getListProd();
	%>
		<table class="cart-table">
			<tr>
				<th>商品名</th>
				<th>価格</th>
			</tr>
		<%
			for (Product p : list) {
		%>
			<tr>
				<td><%= p.getName() %></td>
				<td><%= p.getPriceString() %></td>
			</tr>
		<%
			}
		%>
		</table>

		<div class="total">お支払い金額： <%= payCart.getTotalPriceString() %></div>
	<%
		}
	%>

	<a href="select-servlet" class="btn-main">買い物を続ける</a>

</div>

</body>
</html>