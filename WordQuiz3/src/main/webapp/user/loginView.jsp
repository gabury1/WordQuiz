<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
</head>
<body>
	
	<a href="/WordQuiz3/quiz.nhn?action=mainPage"> 메인페이지 </a>
	<h1> 로그인 페이지 입니다. </h1>
	<h1>로그인 페이지</h1>
    <form action="/WordQuiz3/quiz.nhn?action=login" method="post">
        <label for="id">아이디:</label>
        <input type="text" id="id" name="id" required><br>
        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required><br>
        <button type="submit">로그인</button>
    </form>
    <c:if test="${not empty error}">
        <p style="color: red">${error}</p>
    </c:if>
    <a href="/WordQuiz3/quiz.nhn?action=registerPage">회원가입</a>
	
</body>
</html>