package model;

import java.util.ArrayList;
import java.util.List;

// 全体商品リスト
// ユーザー全員に見える商品
public class Store {
	
	private String name;
	private List<Product> listProd;
	
	public Store(String name, List<Product> listProd) {
		this.name = name;
		this.listProd = listProd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Product> getListProd() {
		return listProd;
	}

	public void setListProd(List<Product> listProd) {
		this.listProd = listProd;
	}
	
	public List<Product> getListProdByCategory(String category) {
		if (category == null || category.equals("all")) {
			return listProd;
		}
		
		List<Product> result = new ArrayList<>();
		for (Product p : listProd) {
			if (p.getCategory().equals(category)) {
				result.add(p);
			}
		}
		return result;
	}

	public Product findById(String id) {
		for (Product p : listProd) {
			if (p.getId().equals(id)) {
				return p;
			}
		}
		return null;
	}
}
