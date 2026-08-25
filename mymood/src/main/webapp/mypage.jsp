<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="model.Cart" %>
<%@ page import="model.Order" %>
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
	User loginUser = (User) session.getAttribute("loginUser");
	Cart cart = (Cart) session.getAttribute("cart");
	List<Order> listOrder = (List<Order>) request.getAttribute("listOrder");
%>

<div class="container">

	<h2>マイページ</h2>

	<div class="mypage-section">
		<h3>会員情報</h3>
		<table class="info-table">
			<tr><th>ユーザID</th><td><%= loginUser.getUserid() %></td></tr>
			<tr><th>ニックネーム</th><td><%= loginUser.getNickname() %></td></tr>
			<tr><th>登録日</th><td><%= loginUser.getCreatedAt() %></td></tr>
		</table>
	</div>

	<div class="mypage-section">
		<h3>カート</h3>
	<%
		if (cart == null || cart.getListProd().isEmpty()) {
	%>
		<p class="empty">カートは空です。</p>
	<%
		} else {
	%>
		<p>商品 <%= cart.getListProd().size() %> 点 ／ 合計 <%= cart.getTotalPriceString() %></p>
	<%
		}
	%>
		<a href="cart.jsp" class="btn-sub">カートを見る</a>
	</div>

	<div class="mypage-section">
		<h3>注文履歴</h3>
	<%
		if (listOrder == null || listOrder.isEmpty()) {
	%>
		<p class="empty">注文履歴はありません。</p>
	<%
		} else {
			int i = 0;
			while (i < listOrder.size()) {
				String no = listOrder.get(i).getOrderNo();
				int j = i;
				int sum = 0;
				while (j < listOrder.size()
						&& listOrder.get(j).getOrderNo().equals(no)) {
					sum += listOrder.get(j).getPrice();
					j++;
				}
	%>
		<div class="order-block">
			<div class="order-head">
				<span class="order-no">注文番号： <%= no %></span>
				<span class="order-date"><%= listOrder.get(i).getOrderedAt() %></span>
				<form action="mypage-servlet" method="post" class="inline-form">
					<input type="hidden" name="action" value="hide">
					<input type="hidden" name="orderNo" value="<%= no %>">
					<button type="submit" class="btn-hide"
						onclick="return confirm('この注文を非表示にしますか？');">非表示</button>
				</form>
			</div>
			<table class="order-items">
			<%
				for (int k = i; k < j; k++) {
					Order o = listOrder.get(k);
			%>
				<tr>
					<td class="order-img"><img src="images/<%= o.getImageFile() %>" alt=""></td>
					<td><%= o.getProductName() %></td>
					<td><%= o.getPriceString() %></td>
				</tr>
			<%
				}
			%>
			</table>
			<div class="order-total">合計： <%= String.format("¥%,d", sum) %></div>
		</div>
	<%
				i = j;
			}
		}
	%>
	</div>

	<div class="mypage-section withdraw-box">
		<h3>退会</h3>
		<p>退会すると、このアカウントではログインできなくなります。</p>
		<form action="mypage-servlet" method="post">
			<input type="hidden" name="action" value="withdraw">
			<button type="submit" class="btn-danger"
				onclick="return confirm('本当に退会しますか？この操作は取り消せません。');">退会する</button>
		</form>
	</div>

</div>

</body>
</html>
