package quiz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

public class QuizDao {

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

	public void saveQuiz(JsonObject json) throws Exception {

		var conn = open();
		List<String> choiceWord = new ArrayList<String>();
		List<Integer> similarities = new ArrayList<Integer>();

		// "word" 값 추출
		String word = json.get("word").getAsString();
		String reason = json.get("reason").getAsString();
		int answer = json.get("answer").getAsInt();
		System.out.println("Word: " + word);

		try {
			// "choices" 배열 추출
			JsonArray choicesArray = json.getAsJsonArray("choices");

			// 각 선택지 추출 및 출력
			for (JsonElement element : choicesArray) {
				JsonObject choice = element.getAsJsonObject();
				String option = choice.get("option").getAsString();
				int similarity = choice.get("similarity").getAsInt();

				choiceWord.add(option);
				similarities.add(similarity);

				System.out.println("Option: " + option + ", Similarity: " + similarity);
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		// SQL Insert 문
		String insertSQL = "INSERT INTO quiz (word, reason, answer, choice1, choice2, choice3, choice4, similarity1, similarity2, similarity3, similarity4) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		System.out.println(insertSQL);
		// PreparedStatement 생성
		PreparedStatement pstmt = conn.prepareStatement(insertSQL);
		try (conn; pstmt;) {
			// 데이터 설정
			pstmt.setString(1, word);
			pstmt.setString(2, reason);
			pstmt.setInt(3, answer);
			pstmt.setString(4, choiceWord.get(0));
			pstmt.setString(5, choiceWord.get(1));
			pstmt.setString(6, choiceWord.get(2));
			pstmt.setString(7, choiceWord.get(3));
			pstmt.setInt(8, similarities.get(0));
			pstmt.setInt(9, similarities.get(1));
			pstmt.setInt(10, similarities.get(2));
			pstmt.setInt(11, similarities.get(3));

			// 데이터베이스에 삽입
			int rowsInserted = pstmt.executeUpdate();
			if (rowsInserted > 0) {
				System.out.println("A new quiz record was inserted successfully!");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<QuizDto> getRandomQuizList() {
		var quizList = new ArrayList<QuizDto>();
		Connection conn = open();
		try {
			String sql = "select * from quiz ORDER BY RAND() LIMIT 10;";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			try (conn; pstmt; rs) {
				while (rs.next()) {
					QuizDto q = new QuizDto();
					q.setId(rs.getInt("id"));
					q.setReason(rs.getString("reason"));
					q.setWord(rs.getString("word"));
					q.setAnswer(rs.getInt("answer"));

					List<String> optionList = new ArrayList<String>();
					List<Integer> similarityList = new ArrayList<Integer>();

					for (int i = 1; i < 5; i++) {
						optionList.add(rs.getString("choice" + Integer.toString(i)));
						similarityList.add(rs.getInt("similarity" + Integer.toString(i)));
					}

					q.setOptions(optionList);
					q.setSimilarities(similarityList);

					quizList.add(q);

				}
				return quizList;
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return quizList;

	}

	public List<QuizDto> getQuizList(List<String> idList) {
		var quizList = new ArrayList<QuizDto>();

		Connection conn = open();
		try {
			for (var id : idList) {
				String sql = "select * from quiz where id=" + id + ";";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery();
				try(rs; pstmt){
						rs.next();
						QuizDto q = new QuizDto();
						q.setId(rs.getInt("id"));
						q.setReason(rs.getString("reason"));
						q.setWord(rs.getString("word"));
						q.setAnswer(rs.getInt("answer"));

						List<String> optionList = new ArrayList<String>();
						List<Integer> similarityList = new ArrayList<Integer>();

						for (int i = 1; i < 5; i++) {
							optionList.add(rs.getString("choice" + Integer.toString(i)));
							similarityList.add(rs.getInt("similarity" + Integer.toString(i)));
						}

						q.setOptions(optionList);
						q.setSimilarities(similarityList);

						quizList.add(q);
					
				} 
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
		} catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
		return quizList;
		
	}

}
