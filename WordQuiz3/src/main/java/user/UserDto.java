package user;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

public class UserDto {
	private int user_no;
	private String nickname;
	private String id;
	private String password;
	private int age;
	private String create_at;
	private String img;
	private String content;
	
	public String getContent() {//소개글
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImg() {//프로필 이미지
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getUser_no() {//유저 고유넘버
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getNickname() {//닉네임
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getId() {//아이디
		return id;
	}
	public void setId(String id) { 
		this.id = id;
	}
	public String getPassword() {// 패스워드
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getAge() { //나이
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getCreate_at() { //스코어 점수
		return create_at;
	}
	public void setCreate_at(String create_at) {
		this.create_at = create_at;
	}
}
