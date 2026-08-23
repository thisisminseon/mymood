package model;

import java.util.List;

public class Uoperation {

	public String signupProc(String userid, String password, String nickname) {

		if (userid == null || userid.trim().isEmpty()) {
			return "ユーザIDを入力してください。";
		}
		if (password == null || password.trim().isEmpty()) {
			return "パスワードを入力してください。";
		}
		if (nickname == null || nickname.trim().isEmpty()) {
			return "ニックネームを入力してください。";
		}

		UserDao dao = new UserDao();

		if (dao.exists(userid)) {
			return "そのユーザIDは既に使われています。";
		}

		if (!dao.insert(userid, password, nickname)) {
			return "登録に失敗しました。もう一度お試しください。";
		}

		return null;
	}

	public List<User> listUsers() {
		UserDao dao = new UserDao();
		return dao.selectAll();
	}

	public boolean suspendUser(String userid) {
		UserDao dao = new UserDao();
		return dao.updateStatus(userid, "suspended");
	}

	public boolean activateUser(String userid) {
		UserDao dao = new UserDao();
		return dao.updateStatus(userid, "active");
	}

	public boolean withdrawUser(String userid) {
		UserDao dao = new UserDao();
		return dao.updateStatus(userid, "withdrawn");
	}
}