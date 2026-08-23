package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

	public boolean exists(String userid) {
		String sql = "SELECT userid FROM m_user WHERE userid = ?";

		try (Connection conn = DBManager.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, userid);

			try (ResultSet rs = pstmt.executeQuery()) {
				return rs.next();
			}

		} catch (Exception e) {
			e.printStackTrace();
			return true;
		}
	}

	public boolean insert(String userid, String password, String nickname) {
		String sql = "INSERT INTO m_user (userid, password, nickname, status, is_admin) "
				+ "VALUES (?, ?, ?, 'active', 0)";

		try (Connection conn = DBManager.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, userid);
			pstmt.setString(2, password);
			pstmt.setString(3, nickname);

			return pstmt.executeUpdate() == 1;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public User findForLogin(String userid, String password) {
		String sql = "SELECT userid, password, nickname, status, is_admin, created_at "
				+ "FROM m_user WHERE userid = ? AND password = ?";

		try (Connection conn = DBManager.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, userid);
			pstmt.setString(2, password);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return new User(rs.getString("userid"), rs.getString("password"), rs.getString("nickname"),
							rs.getString("status"), rs.getInt("is_admin") == 1, rs.getString("created_at"));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public List<User> selectAll() {
		List<User> list = new ArrayList<>();

		String sql = "SELECT userid, password, nickname, status, is_admin, created_at "
				+ "FROM m_user ORDER BY is_admin DESC, created_at";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				list.add(new User(rs.getString("userid"), rs.getString("password"), rs.getString("nickname"),
						rs.getString("status"), rs.getInt("is_admin") == 1, rs.getString("created_at")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean updateStatus(String userid, String status) {
		String sql = "UPDATE m_user SET status = ? WHERE userid = ? AND is_admin = 0";

		try (Connection conn = DBManager.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, status);
			pstmt.setString(2, userid);

			return pstmt.executeUpdate() == 1;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}