package user;

public class RankingDto 
{
	// 우진이형을 위한 나의 선물. 그냥 이거 갖다 화면에 뿌려주면 됨.
	Integer playerNo;
	String nickName;
	Integer score;
	Integer rank;
	String img;
	
	// Getter 및 Setter 메서드
    public Integer getPlayerNo() {
        return playerNo;
    }

    public void setPlayerNo(Integer playerNo) {
        this.playerNo = playerNo;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
    }
    
    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }
}
	
