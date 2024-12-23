package quiz;

import java.util.ArrayList;
import java.util.List;

import user.RankingDto;

public class GameLogService 
{
	GameLogDao gameLogDao;
	
	public GameLogService()
	{
		gameLogDao = new GameLogDao();
	}
	
	// 게임 로그를 저장합니다.
	public String saveGameLog(Integer userNo, Integer score)
	{
		gameLogDao.saveLog(score,userNo);
		
		return "success";
	}
	
	// 게임 로그를 불러옵니다. (랭킹 불러오기)
	public List<RankingDto> getRanking()
	{
		var list = gameLogDao.getRanking();
		
		return list;
	}
	
}
