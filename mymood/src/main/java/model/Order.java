package model;

// 注文履歴
public class Order {

	private String orderNo;
	private String productName;
	private String imageFile;
	private int price;
	private String orderedAt;

	public Order(String orderNo, String productName,
			String imageFile, int price, String orderedAt) {
		this.orderNo = orderNo;
		this.productName = productName;
		this.imageFile = imageFile;
		this.price = price;
		this.orderedAt = orderedAt;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public String getProductName() {
		return productName;
	}

	public String getImageFile() {
		return imageFile;
	}

	public int getPrice() {
		return price;
	}

	public String getOrderedAt() {
		return orderedAt;
	}

	public String getPriceString() {
		return String.format("¥%,d", price);
	}
}