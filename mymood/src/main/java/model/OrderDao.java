package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {

	public boolean insert(String userid, List<Product> listProd) {
		if (listProd == null || listProd.isEmpty()) {
			return false;
		}

		String orderNo = LocalDateTime.now()
				.format(DateTimeFormatter.ofPattern("yyyyMMdd-HHmmss"));

		String sql = "INSERT INTO t_order (order_no, userid, product_id, price) "
				+ "VALUES (?, ?, ?, ?)";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			for (Product p : listProd) {
				pstmt.setString(1, orderNo);
				pstmt.setString(2, userid);
				pstmt.setString(3, p.getId());
				pstmt.setInt(4, p.getPrice());
				pstmt.executeUpdate();
			}
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<Order> selectByUser(String userid) {
		List<Order> list = new ArrayList<>();

		String sql = "SELECT o.order_no, p.name, p.image_file, o.price, "
				+ "DATE_FORMAT(o.ordered_at, '%Y-%m-%d %H:%i') AS ordered_at "
				+ "FROM t_order o JOIN m_product p ON o.product_id = p.id "
				+ "WHERE o.userid = ? AND o.hidden = 0 "
				+ "ORDER BY o.ordered_at DESC, o.order_id";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, userid);

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					list.add(new Order(
							rs.getString("order_no"),
							rs.getString("name"),
							rs.getString("image_file"),
							rs.getInt("price"),
							rs.getString("ordered_at")));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean hideOrder(String orderNo, String userid) {
		String sql = "UPDATE t_order SET hidden = 1 "
				+ "WHERE order_no = ? AND userid = ?";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, orderNo);
			pstmt.setString(2, userid);

			return pstmt.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}