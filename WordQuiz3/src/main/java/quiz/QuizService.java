package quiz;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

public class QuizService 
{
	final QuizDao quizDao;
	
	public QuizService(){
		quizDao = new QuizDao();
	}
	
	public List<QuizDto> getRandomQuizList()
	{
		
		return quizDao.getRandomQuizList();
	}
	
	public List<QuizDto> getQuizList(String quizList)
	{
		List<String> idList = List.of(quizList.split(","));
		
		return quizDao.getQuizList(idList);
	}
	
}
