package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {

	public List<Product> selectAll() {
		List<Product> list = new ArrayList<>();

		String sql = "SELECT id, name, price, category, image_file, description "
				+ "FROM m_product ORDER BY id";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				Product p = new Product(
						rs.getString("id"),
						rs.getString("name"),
						rs.getInt("price"),
						rs.getString("category"),
						rs.getString("image_file"),
						rs.getString("description"));
				list.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}