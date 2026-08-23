package model;

// 商品管理
public class Product {

	private String id;
	private String name;
	private int price;
	private String category;
	private String imageFile;
	private String description;

	public Product(String id, String name, int price,
			String category, String imageFile, String description) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.category = category;
		this.imageFile = imageFile;
		this.description = description;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public int getPrice() {
		return price;
	}

	public String getCategory() {
		return category;
	}

	public String getImageFile() {
		return imageFile;
	}

	public String getDescription() {
		return description;
	}

	public String getPriceString() {
		return String.format("¥%,d", price);
	}
}