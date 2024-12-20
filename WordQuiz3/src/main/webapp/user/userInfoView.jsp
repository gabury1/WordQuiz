<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 페이지</title>

<!--  css  -->
<link rel="stylesheet" href="static/css/basic.css">
<link rel="stylesheet" href="static/css/userInfoPage.css">

</head>
<body>
	<div id = container>
		<div id = "mainDiv">
			<img id = "img" src="${users.img}">
			<p>${users.nickname}</p>
			<p>${users.age}</p>
			<p>${users.content}</p>
			<p>랭킹 순위 ${param.rank}</p>
			<p>맞은 퀴즈 개수 ${param.answer}</p>
		</div>
		<div id = "commentDiv">
			<div id = "windowDiv">
				<ul class="list-group">
					<c:forEach var="reply" items="${replylist}" varStatus="status">
						<li>
							<img src="${reply.img}">
							<a>[${status.count}] ${reply.nickname}: ${reply.content} ${reply.create_at}</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			<form method="post" action="/WordQuiz3/quiz.nhn?action=addComments" enctype="multipart/form-data">
				<div class="textarea-button-container">
        			<textarea cols="50" rows="5" name="content"></textarea>
        			<button type="submit">저장</button>
   				</div>
			</form>
		</div>
	</div>
</body>
</html>