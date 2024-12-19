package quiz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import user.RankingDto;

public class GameLogDao 
{

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
	
	public void saveLog(int score, int playerNo)
	{
		var conn = open();
		
		try {
				String insertSQL = "INSERT INTO Game_logs (score, player_no) VALUES (?, ?);";
				System.out.println(insertSQL);

				// PreparedStatement 생성
				PreparedStatement pstmt = conn.prepareStatement(insertSQL);
			try (conn; pstmt;) {
				// 데이터 설정
				pstmt.setInt(1, score);
				pstmt.setInt(2, playerNo);
				
				// 데이터베이스에 삽입
				pstmt.executeUpdate();
				
			} catch(Exception e)
			{
				System.out.println(e.getMessage());
			}
		
		} catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	// 랭킹 불러오기
	public List<RankingDto> getRanking()
	{
		var list = new ArrayList<RankingDto>();
		var conn = open();
		
		try {
			// 유저 정보와 게임로그를 inner join 하여 값을 받아옴.
			String sql = "select player_no, nickname, img, sum(score) as total_score from game_logs "
					+ "inner join users on game_logs.player_no = users.user_no "
					+ "group by player_no order by total_score desc;";
			
			var pstmt = conn.prepareStatement(sql);
			var rs = pstmt.executeQuery();
			try(rs; pstmt; conn){
				int rank = 0;
				while (rs.next()) {
					rank++;
					RankingDto r = new RankingDto();
					r.setPlayerNo(rs.getInt("player_no"));
					r.setNickName(rs.getString("nickname"));
					r.setScore(rs.getInt("total_score"));
					r.setImg(rs.getString("img"));
					r.setRank(rank);
					
					list.add(r);
					
				}
				
				
			} catch(Exception e) {
				
				System.out.println(e.getMessage());
				
			}
			
		} catch(Exception e){

			System.out.println(e.getMessage());
			
		}
		
		return list;
	}

}
