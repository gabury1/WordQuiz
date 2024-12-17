package quiz;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class QuizDto {
	
	Integer id;
	String reason;
	String word;
	Integer answer;
	
	List<String> options;
	List<Integer> similarities;
	
    // Getter와 Setter 메서드
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getReason() {
        return reason;
    }
    
    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    public List<String> getOptions() {
        return options;
    }

    public void setOptions(List<String> options) {
        this.options = options;
    }

    public List<Integer> getSimilarities() {
        return similarities;
    }

    public void setSimilarities(List<Integer> similarities) {
        this.similarities = similarities;
    }

    public int getAnswer() {
        return answer;
    }

    public void setAnswer(Integer answer) {
        this.answer = answer;
    }
	
}
