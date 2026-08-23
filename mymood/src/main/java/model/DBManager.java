package model;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
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

			Class.forName("com.mysql.cj.jdbc.Driver");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws Exception {
		return DriverManager.getConnection(url, user, password);
	}
}