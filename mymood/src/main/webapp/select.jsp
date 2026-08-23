<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.Product"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyMood - 商品選択</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

	<jsp:include page="header-navi.jsp" />

	<%
	List<Product> listProd = (List<Product>) request.getAttribute("listProd");
	String selectedCategory = (String) request.getAttribute("selectedCategory");
	%>

	<div class="container">

		<h2>商品選択</h2>

		<div class="product-grid">
			<%
			if (listProd != null) {
				for (Product p : listProd) {
			%>
			<div class="product-card">
				<a href="detail-servlet?id=<%=p.getId()%>"> <img
					src="images/<%=p.getImageFile()%>" alt="<%=p.getName()%>"
					class="product-img">
				</a>
				<div class="product-name">
					<a href="detail-servlet?id=<%=p.getId()%>"><%=p.getName()%></a>
				</div>
				<div class="product-price"><%=p.getPriceString()%></div>
				<form action="add-prod-servlet" method="post">
					<input type="hidden" name="prodId" value="<%=p.getId()%>">
					<input type="hidden" name="category" value="<%=selectedCategory%>">
					<button type="submit" class="btn-add">カートに追加</button>
				</form>
			</div>
			<%
			}
			}
			%>
		</div>

	</div>

</body>
</html>