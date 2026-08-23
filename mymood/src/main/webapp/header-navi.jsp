<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String navCat = (String) request.getAttribute("selectedCategory");
	if (navCat == null) {
		navCat = "";
	}
%>

<div class="site-header">

	<div class="header">
		<a href="select-servlet" class="logo-small">MyMood</a>
		<div class="header-right">
		<%
			if (session.getAttribute("loginUser") == null) {
		%>
			<a href="login.jsp">ログイン</a>
			<a href="signup.jsp">会員登録</a>
		<%
			} else {
		%>
			<a href="mypage-servlet">マイページ</a>
			<a href="cart.jsp">カート</a>
			<a href="logout-servlet">ログアウト</a>
		<%
			}
		%>
		</div>
	</div>

	<div class="category-nav">
		<a href="select-servlet?category=all"       class="<%= "all".equals(navCat)       ? "active" : "" %>">ALL</a>
		<a href="select-servlet?category=outer"     class="<%= "outer".equals(navCat)     ? "active" : "" %>">OUTER</a>
		<a href="select-servlet?category=tops"      class="<%= "tops".equals(navCat)      ? "active" : "" %>">TOPS</a>
		<a href="select-servlet?category=bottoms"   class="<%= "bottoms".equals(navCat)   ? "active" : "" %>">BOTTOMS</a>
		<a href="select-servlet?category=onepiece"  class="<%= "onepiece".equals(navCat)  ? "active" : "" %>">ONE PIECE</a>
		<a href="select-servlet?category=shoes"     class="<%= "shoes".equals(navCat)     ? "active" : "" %>">SHOES</a>
		<a href="select-servlet?category=accessory" class="<%= "accessory".equals(navCat) ? "active" : "" %>">ACCESSORY</a>
	</div>

</div>

<button type="button" id="topBtn" class="top-btn" aria-label="TOP">TOP</button>

<script>
(function () {
	var btn = document.getElementById("topBtn");
	if (!btn) { return; }

	function update() {
		if (window.scrollY > 300) {
			btn.classList.add("show");
		} else {
			btn.classList.remove("show");
		}
	}

	window.addEventListener("scroll", update, { passive: true });
	btn.addEventListener("click", function () {
		window.scrollTo({ top: 0, behavior: "smooth" });
	});
	update();
})();
</script>
