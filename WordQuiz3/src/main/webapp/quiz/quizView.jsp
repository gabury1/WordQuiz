<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!--  css  -->
<link rel="stylesheet" href="static/css/basic.css">
<link rel="stylesheet" href="static/css/quizPage.css">

<style>
	
	img.infinite_rotating_logo{
    animation: rotate_image 10s linear infinite;
    transform-origin: 50% 50%;
	}
 
	@keyframes rotate_image{
		100% {
    	transform: rotate(360deg);
    	}
	}

</style>

</head>
<body>

	<%
	Integer userNo = 1;
	session.setAttribute("userNo", userNo);
	%>

	<h1 id="count" class="hidden">(타임 카운터)5</h1>
	<h1 id="round" class="hidden">(라운드)3</h1>
	<h1 id="solved" class="hidden">(맞춘 문제)2</h1>

	<div class="game-container">
	
		<div class="timer">
			<img class="timer-img" src="static/image/Group.png">
			<div class="progress-bar"></div>
		</div>
		
		<div class="thumbys"> 
			<img class="thumby" src="static/image/thumby1.svg">
			<img class="thumby" src="static/image/thumby1.svg">
			<img class="thumby" src="static/image/thumby1.svg">
			<img class="thumby" src="static/image/thumby1.svg">
			<img class="thumby" src="static/image/thumby1.svg">
			<img class="thumby" src="static/image/thumby1.svg">
			<img class="thumby" src="static/image/thumby1.svg">
			<img class="thumby" src="static/image/thumby1.svg">
			<img class="thumby" src="static/image/thumby1.svg">
			<img class="thumby" src="static/image/thumby1.svg">
		</div>
		
		<div class="quiz-container">
			<div id="word" class="quiz-header">
				Q. [강하다] 와 가장 유사한 단어는?
			</div>
			<div class="quiz-options">
				<button id="btnFirst" onClick="solve(0)">든든하다</button>
				<button id="btnSecond" onClick="solve(1)">깨끗하다</button>
				<button id="btnThird" onClick="solve(2)">가볍다</button>
				<button id="btnForth" onClick="solve(3)">늦다</button>
			</div>
		</div>
		
	</div>

	<div id="loading" >
		<img class="infinite_rotating_logo" src="static/image/c_green.png"> now Loading . . .
	</div>
	
	<div>
		
	</div>
	 
	<!-- 문제 리스트를 넘기기 위한 폼, 보이지 않음. 디자인에 반영 X -->
	<form id="submitForm"
		action="/WordQuiz3/quiz.nhn?action=commentaryPage" method="POST"
		style="display: none;">
		<input name="quizIdList" id="quizList" value="">
		<input name="quizFlagList" id="quizFlagList" value="">
	</form>

	<script>
		
		class Quiz // 그냥 퀴즈 정보 저장하는 클래스.
		{
			constructor(id, word, reason, answer, options, similarities)
			{
				this.id = id;						// id 값
				this.word = word;					// 문제로 제시된 단어
				this.reason = reason;				// 해설
				this.answer = answer;				// 정답 번호
			
				this.options = options;				// 제시어 리스트
				this.similarities = similarities;	// 유사도 리스트
			}
		}
	
		var quizList = []; 		// 퀴즈 클래스가 저장될 배열
		var btnList = [];		// 0~3번 버튼 객체를 담을 배열
		var round = 0;			// 문재를 푼 갯수
		var quizIdList = [];	// 문제들의 ID 값. 				(문제를 풀 때마다 값이 들어감.)
		var quizFlagList = []; 	// 문제들의 맞았는지, 틀렸는 여부. (문제를 풀 때마다 값이 들어감.)
		var solvedCnt = 0; 		// 문제 맞출 때마다 ++
		var characterImg = [];	// 캐릭터 이미지 리스트
		var characterImgUrl = ["c_blue.png", "c_green.png", "c_orange.png", "c_pink.png", "c_purple.png", "c_red.png", "c_yellow.png"];
		
		var time = 5;			// 타이머 전역변수


		
		setTimeout(() => {
			alert("게임을 시작합니다.");
			// 로딩창 삭제해줘야함. 안그러면 클릭이 안됨.
			var loadingDiv = document.querySelector("#loading");
			loadingDiv.remove();
			init(); 					// quizList에 데이터 담기
		}, 8000);
		
		refresh(0);
	
		function refresh(num) 	// 원하는 번호의 문제로 이동.
		{
			// 10번의 문제를 풀면 정보를 넘겨줘야함.
			if(num == 10)
			{
				var quizIdListInput = document.querySelector("#quizList");
				var quizFlagListInput = document.querySelector("#quizFlagList");
				var submitForm = document.querySelector("#submitForm");
				
				quizIdListInput.value = quizIdList.join(",");
				quizFlagListInput.value = quizFlagList.join(",");

				submitForm.submit();
				
				return;
			}
			
			round = num;
			for(let i=0; i<4; i++) btnList[i].textContent = quizList[num].options[i];
			var wordH1 = document.querySelector("#word");
			var solvedH1 = document.querySelector("#solved");
			var roundH1 = document.querySelector("#round");
			var countH1 = document.querySelector("#count");
			
			wordH1.textContent = "Q. [" + quizList[num].word + "] 와 가장 유사한 단어는??" ;
			roundH1.textContent = num+1;
			solvedH1.textContent = "맞춘 문제 : " + solvedCnt;
			countH1.textContent = 5;
			
			time = 6;
			setTimer(round);
			
		}
		
		function solve(num)		// 정답버튼 이벤트 핸들러
		{
			quizIdList.push(quizList[round].id);
			// 정답을 맞춘 경우
			if(num+1 == quizList[round].answer){
				quizFlagList.push(1);
				solvedCnt++;				
			}
			// 오답인 경우
			else{
				quizFlagList.push(0);
			}
			
			round++;			// 맞췄든 틀렸든, 다음문제로 넘어감.
			refresh(round);		// 화면 재구성
		}
		
		function init() // 백엔드에서 불러온 정보 초기화. 특별히 건드릴건 없을 듯.
		{
			// JSTL로 퀴즈리스트 받아옴.
			<c:forEach var="q" items="${quizList}" varStatus="status">
			    quizList.push(new Quiz(${q.id}, '${q.word}', '${q.reason}', ${q.answer}, ['${q.options[0]}', '${q.options[1]}', '${q.options[2]}', '${q.options[3]}'], ${q.similarities}));
			</c:forEach>
		
			// 버튼 객체를 배열에 담아줌.
			btnList.push(document.querySelector("#btnFirst"));
			btnList.push(document.querySelector("#btnSecond"));
			btnList.push(document.querySelector("#btnThird"));
			btnList.push(document.querySelector("#btnForth"));
			
			// 캐릭터 넣어주기.
			imgList = document.querySelectorAll(".thumby");
			imgList.forEach(img => img.setAttribute("src", "static/image/" + characterImgUrl[Math.floor(Math.random() * 7)]));
			
			console.log(quizList);
			console.log(btnList);
		}
		
		// 타이머, 5초의 시간제한
		function setTimer(nowRound)
		{
			
			// 1초마다 재귀반복 0초에서 동작을 멈춤.
			var countH1 = document.querySelector("#count");

			setTimeout(() => {
					
					console.log(nowRound==round);
					time--;
					countH1.textContent=time;
					
					if(nowRound == round)				// 해당 라운드가 아니라면 루프가 돌면 안됨 !!
					{
						if(0 < time) setTimer(nowRound);
						else solve(-1);					// 무조건 틀린 답을 내놓음.
					}
				}, 1000);
			
		}

	</script>

</body>
</html>