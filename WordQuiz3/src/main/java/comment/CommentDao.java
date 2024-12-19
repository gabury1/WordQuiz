package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDao {
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
	
	public void addComment(CommentDto c) throws SQLException{ // 댓글 입력
		Connection conn = open();
		String sql = "insert into Comments(content,writer_no,target_no,created_at) values(?,?,?,CURRENT_TIMESTAMP())";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		try(conn; pstmt) {
			pstmt.setString(1, c.getContent());
			pstmt.setInt(2, c.getWriter_no());
			pstmt.setInt(3, c.getTarget_no());
			pstmt.executeUpdate();
		}
	}
	
	public List<replyDto> getComment(int target_no)throws SQLException { //댓글 출력
		Connection conn = open();
		List<replyDto> replylist = new ArrayList<>(); 
		String sql = "select Comments.content,STR_TO_DATE(Comments.created_at,'%Y-%m-%d %H:%i:%s') as cdate, users.img, users.nickname from Comments INNER JOIN users on users.user_no = Comments.writer_no where target_no = ?";
		//조인으로 댓글과 댓글의 작성 시간, 작성 유저의 이미지와 닉네임 불러오기
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, target_no);
		ResultSet rs = pstmt.executeQuery();
		try(conn; pstmt; rs){
			while(rs.next()) {
				replyDto re = new replyDto();
				re.setContent(rs.getString("content"));
				re.setCreate_at(rs.getString("cdate"));
				re.setImg(rs.getString("img"));
				re.setNickname(rs.getString("nickname"));
				replylist.add(re);
			}
			return replylist;
		}
	}
	
	public void delComment(int target_no)throws SQLException { //댓글 삭제
		Connection conn = open();
		String sql = "delete from Comments where target_no = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		try(pstmt;conn){
			pstmt.setInt(1, target_no);
			if(pstmt.executeUpdate() == 0) {
				throw new SQLException("DB에러");
			}
		}
	}
}
