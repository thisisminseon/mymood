package model;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Properties;

public class DBManager {

	private static String url;
	private static String user;
	private static String password;

	static {
		try {
			Properties prop = new Properties();
			InputStream in = DBManager.class.getClassLoader()
					.getResourceAsStream("db.properties");
			prop.load(in);
			in.close();

			url = prop.getProperty("db.url");
			user = prop.getProperty("db.user");
			password = prop.getProperty("db.password");

			Class.forName(prop.getProperty("db.driver"));

			// 起動時に一度だけ初期化スクリプトを流す
			String init = prop.getProperty("db.init");
			if (init != null && !init.trim().isEmpty()) {
				try (Connection conn = getConnection();
						Statement stmt = conn.createStatement()) {
					stmt.execute(init);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws Exception {
		return DriverManager.getConnection(url, user, password);
	}
}
