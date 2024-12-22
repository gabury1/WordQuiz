<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 페이지</title>
</head>
<body>
<<<<<<< HEAD
	
	<a href="/WordQuiz3/quiz.nhn?action=mainPage"> 메인페이지 </a>
<<<<<<< HEAD
	
=======
	<h2>22</h2>
=======
	<div>
		<img src="${users.img}">
		<div>
			<p>닉네임:${users.nickname}</p>
			<p>자기소개: ${users.content}</p>
			<p>나이:${users.age}</p>
		</div>
		<h2>댓글 목록</h2>
		<hr>
		<div>
			<form method="post" action="/WordQuiz3/quiz.nhn?action=addComments" enctype="multipart/form-data">
				<label class="form-label">댓글</label><br>
				<textarea cols="50" rows="5" name="content"></textarea><br>
				<button type="submit" >저장</button>
			</form>
		</div>
		<ul class="list-group">
			<c:forEach var="reply" items="${replylist}" varStatus="status">
				<li>
					<img src="${reply.img}">
					<a>[${status.count}] ${reply.nickname}: ${reply.content} ${reply.create_at}</a>
				</li>
			</c:forEach>
		</ul>
	</div>
>>>>>>> hanjun
>>>>>>> parent of 54b4104 (Ujin)
</body>
</html>