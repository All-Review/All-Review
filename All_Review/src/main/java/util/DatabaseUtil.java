package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	
	public static Connection getConnection() {
		try {
			//String dbURL = "jdbc:mysql://121.148.107.112:3306/test"; // 데이터베이스 이름
			//String dbID = "yuns";
			//String dbPassword = "9899";
			String dbURL = "jdbc:mysql://allreview.czslwzgjkozy.ap-northeast-2.rds.amazonaws.com/allreview"; // 데이터베이스 이름
            String dbID = "admin";
            String dbPassword = "allre0000";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
