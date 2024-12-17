<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<H1>해설 페이지</H1>
	<h2>축하합니다 ! <c:out value="${correctCnt}"/> 개 만큼의 문제를 맞췄습니다 ! </h2>
	
	<c:forEach var="q" items="${quizList}" varStatus="status">	
			<c:set var="flag" value="${quizFlagList[status.index]==0}"/>
		    <div style="
		    	<c:if test='${flag}'> background-color : #F3BFD3; </c:if>
		    ">
		    	<div>제시어 : ${q.word} </div> <div> 정답 : ${q.answer} ${q.options[q.answer-1]} </div> <div>해설 : ${q.reason} </div>
		    </div>
		    <br><br>
	</c:forEach>
	
	<a href="/WordQuiz3/quiz.nhn?action=rankingPage">랭킹</a>
		
	<script>
		
		
	</script>

</body>
</html>