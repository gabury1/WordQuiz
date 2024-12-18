package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {

	final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	final String JDBC_URL = "jdbc:mysql://localhost:3306/wordquiz";

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
	public UserDto getUser(int user_no)throws SQLException { //유저 정보 출력
		Connection conn = open();
		UserDto users = new UserDto();
		String sql = "select user_no, nickname, img ,age, STR_TO_DATE(created_at,'%Y-%m-%d %H:%i:%s') as cdate ,content, id, password from Users where user_no = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, user_no);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		try(conn; pstmt; rs){
			users.setUser_no(rs.getInt("user_no"));
			users.setImg(rs.getString("img"));
			users.setNickname(rs.getString("nickname"));
			users.setAge(rs.getInt("age"));
			users.setCreate_at(rs.getString("cdate"));
			users.setContent(rs.getString("content"));
			users.setId(rs.getString("id"));
			users.setPassword(rs.getString("password"));
			return users;
		}
	}
	
	//우진 만든거
	public void insertUser(UserDto user) throws Exception {
	    String sql = "INSERT INTO member (id, password, nickname, age) VALUES (?, ?, ?, ?)";
	    System.out.println("[DEBUG] SQL 준비: " + sql);
	    
	    try (Connection conn = open(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        System.out.println("[DEBUG] DB 연결 성공");	        
	        System.out.println("[DEBUG] 입력값 확인: " + user.getId() + ", " + user.getPassword() + ", " + user.getNickname() + ", " + user.getAge());
	        pstmt.setString(1, user.getId());
	        pstmt.setString(2, user.getPassword());
	        pstmt.setString(3, user.getNickname());
	        pstmt.setInt(4, user.getAge());
	        
	        int result = pstmt.executeUpdate();
	        System.out.println("[DEBUG] SQL 실행 완료, 반영된 행 수: " + result);
	    } catch (Exception e) {
	        System.out.println("[ERROR] SQL 실행 중 오류 발생");
	        e.printStackTrace();
	        throw e; // 상위 메서드에 예외 전달
	    }
	}
//우진 만든거
	
	
	
	public void delUser(int user_no)throws SQLException { // 유저 삭제
		Connection conn = open();

		String sql = "delete from Users where user_no = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		try(pstmt;conn){
			pstmt.setInt(1, user_no);
			if(pstmt.executeUpdate() == 0) {
				throw new SQLException("DB에러");
			}
		}
	}
	public void updateUsers(UserDto u) throws Exception { //유저 수정
		Connection conn = open();
		String sql = "update Users set password = ?, nickname = ?, age = ?, content=?,img=? where user_no = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		try(conn; pstmt) {
			pstmt.setString(1, u.getPassword());
			pstmt.setString(2, u.getNickname());
			pstmt.setInt(3, u.getAge());
			pstmt.setString(4,u.getContent());
			pstmt.setString(5,u.getImg());
			pstmt.setInt(6, u.getUser_no());
			pstmt.executeUpdate();
		}
	}

}
