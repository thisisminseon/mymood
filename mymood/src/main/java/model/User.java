package model;

public class User {

	private String userid;
	private String password;
	private String nickname;
	private String status;
	private boolean admin;
	private String createdAt;

	public User(String userid, String password, String nickname,
			String status, boolean admin, String createdAt) {
		this.userid = userid;
		this.password = password;
		this.nickname = nickname;
		this.status = status;
		this.admin = admin;
		this.createdAt = createdAt;
	}

	public String getUserid() {
		return userid;
	}

	public String getPassword() {
		return password;
	}

	public String getNickname() {
		return nickname;
	}

	public String getStatus() {
		return status;
	}

	public boolean isAdmin() {
		return admin;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public boolean isActive() {
		return "active".equals(status);
	}
}