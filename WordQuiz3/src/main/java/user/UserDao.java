package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

public class UserDao {

	final static String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	final static String JDBC_URL = "jdbc:mysql://localhost:3306/wordquiz";

	// DB 연결을 가져오는 메서드, DBCP를 사용하는 것이 좋음
	public Connection open() {
		Connection conn = null;
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL, "root", "1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

}
