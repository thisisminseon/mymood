package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {

	private String userid;
	private List<Product> listProd;

	public Cart(String userid) {
		this.userid = userid;
		this.listProd = new ArrayList<>();
	}

	public String getUserid() {
		return userid;
	}

	public List<Product> getListProd() {
		return listProd;
	}

	public void add(Product prod) {
		listProd.add(prod);
	}

	public void remove(int index) {
		if (index >= 0 && index < listProd.size()) {
			listProd.remove(index);
		}
	}

	public void clear() {
		listProd.clear();
	}

	public int getTotalPrice() {
		int total = 0;
		for (Product p : listProd) {
			total += p.getPrice();
		}
		return total;
	}

	public String getTotalPriceString() {
		return String.format("¥%,d", getTotalPrice());
	}
}