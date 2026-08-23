package model;

import java.util.List;

import jakarta.servlet.http.HttpSession;

public class Moperation {

	public boolean loginProc(String userid, String password, HttpSession session) {
		UserDao dao = new UserDao();
		User user = dao.findForLogin(userid, password);

		if (user == null) {
			return false;
		}
		if (!user.isActive()) {
			return false;
		}

		session.setAttribute("loginUser", user);
		session.setAttribute("store", makeStore());
		session.setAttribute("cart", new Cart(userid));
		return true;
	}

	private Store makeStore() {
		ProductDao dao = new ProductDao();
		List<Product> list = dao.selectAll();
		return new Store("MyMood", list);
	}

	public void logoutProc(HttpSession session) {
		session.invalidate();
	}

	public void addProd(String prodId, HttpSession session) {
		Store store = (Store) session.getAttribute("store");
		Cart cart = (Cart) session.getAttribute("cart");
		if (store == null || cart == null) {
			return;
		}
		Product prod = store.findById(prodId);
		if (prod != null) {
			cart.add(prod);
		}
	}

	public void removeProd(int idx, HttpSession session) {
		Cart cart = (Cart) session.getAttribute("cart");
		if (cart == null) {
			return;
		}
		cart.remove(idx);
	}

	public void pay(HttpSession session) {
		Cart cart = (Cart) session.getAttribute("cart");
		if (cart == null) {
			return;
		}
		Cart payCart = new Cart(cart.getUserid());
		for (Product p : cart.getListProd()) {
			payCart.add(p);
		}

		OrderDao odao = new OrderDao();
		odao.insert(cart.getUserid(), payCart.getListProd());

		session.setAttribute("pay", payCart);
		cart.clear();
	}

	public void buyNow(String prodId, HttpSession session) {
		Store store = (Store) session.getAttribute("store");
		Cart cart = (Cart) session.getAttribute("cart");
		if (store == null || cart == null) {
			return;
		}
		Product prod = store.findById(prodId);
		if (prod == null) {
			return;
		}
		Cart payCart = new Cart(cart.getUserid());
		payCart.add(prod);

		OrderDao odao = new OrderDao();
		odao.insert(cart.getUserid(), payCart.getListProd());

		session.setAttribute("pay", payCart);
	}
}