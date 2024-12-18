package quiz;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class GameLogDto {
	
	Integer logNo;
	Integer score;
	Integer playerNo;
	
	String createdAt;
	
	public void setLogNo(int logNo)
	{
		this.logNo = logNo;
	}
	
	public void setScore(int score)
	{
		this.score = score;
	}
	
	public void setPlayerNo(int playerNo)
	{
		this.playerNo = playerNo;
	}
	
	public void setCreateAt(String createdAt)
	{
		this.createdAt = createdAt;
	}
	
	public Integer getLogNo()
	{
		return logNo;
	}
	
	public Integer getScore()
	{
		return score;
	}
	
	public Integer getPlayerNo()
	{
		return playerNo;
	}
	
	public String getCreateAt()
	{
		return createdAt;
	}
	
}
