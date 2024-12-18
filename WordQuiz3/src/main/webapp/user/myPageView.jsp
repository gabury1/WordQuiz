<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 설정</title>
<script>
	function btnClick() {
	  const mydiv = document.getElementById('my-div');
	  
	  if(mydiv.style.display === 'none') {
	    mydiv.style.display = 'block';
	  }else {
	    mydiv.style.display = 'none';
	  }
	}
</script>
</head>
<body>
	<div>
		<img src="${users.img}">
		<div>
			<p>자기소개: ${users.content}</p>
			<p>닉네임:${users.nickname}</p>
			<p>ID:${users.id}</p>
			<p>PW:${users.password}</p>
			<p>나이:${users.age}</p>
		</div>
		<hr>
		<div>
			<button type="button" onclick='btnClick()'>수정</button>
			<div id='my-div' style="display:none;">
				<form method="post" action="/WordQuiz3/quiz.nhn?action=updateUser" enctype="multipart/form-data">
					<label class="form-label">이미지</label><br>
					<input type="file" name="file"><br>
					<label class="form-label">닉네임</label><br>
					<input type="text"name="nickname"><br> 
					<label class="form-label">비밀번호</label><br>
					<input type="text"name="password"><br>
					<label class="form-label">나이</label><br> 
					<input type="number"name="age"><br>
					<label class="form-label">자기소개</label><br>
					<textarea cols="50" rows="5" name="content"></textarea><br>
					<button type="submit">저장</button>
					<hr>
				</form>
			</div>
			<button type="button" onclick="location.href='/WordQuiz3/quiz.nhn?action=deleteUser'">삭제</button>
		</div>
		<h2>댓글 목록</h2>
		<hr>
		<ul class="list-group">
			<c:forEach var="reply" items="${replylist}" varStatus="status">
				<li>
					<img src="${reply.img}">
					<a>[${status.count}] ${reply.nickname}, ${reply.content}, ${reply.create_at}</a>
				</li>
			</c:forEach>
		</ul>
		<hr>
	</div>
</body>
</html>