<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Commentary</title>
    <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Belanosima:wght@400;700&display=swap');

        body {
            font-family: 'Pretendard', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #C3C3FF;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        main {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 36px;
            padding-top: 121px;
            width: 100%;
        }

        /* 아이콘에 애니메이션 적용 */
        .c-yellow {
            width: 117px;
            animation: bounce 1s infinite ease-in-out;
        }

        @keyframes bounce {

            0%,
            100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-10px);
            }
        }

        .main-text {
            color: #3C3D3E;
            text-align: center;
            font-size: 55px;
            font-weight: 700;
            line-height: 83px;
        }

        .main-text p {
            margin: 0;
        }

        .main-text span {
            color: #6C7CFF;
        }

        .button {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 259px;
            height: 72px;
            border-radius: 18.901px;
            background: #5470FF;
            gap: 10px;
            cursor: pointer;
        }

        .button p {
            color: #FFF;
            text-align: center;
            font-size: 20.619px;
            font-weight: 700;
            margin: 0;
        }

        .button img {
            width: 21px;
        }

        footer {
            display: flex;
            flex-direction: column;
            align-items: center;
            /* 푸터 전체 가운데 정렬 */
            gap: 62px;
            /* 박스 간 간격 */
            padding: 67px 0 67px;
            width: 100%;
            max-width: 1117px;
            /* 푸터 최대 너비 */
            border-radius: 36.75px;
            background: linear-gradient(180deg, rgba(84, 112, 255, 0.28) 99.99%, rgba(84, 112, 255, 0.14) 100%);
            backdrop-filter: blur(29.5572px);
            margin: 0 auto;
            margin-top: 132px;
            margin-bottom: 121px;
            position: relative;
            /* 문제 해설 텍스트 배치를 위해 추가 */
        }

        .box {
            display: flex;
            align-items: flex-start;
            gap: 28px;
            /* 아이콘과 텍스트 간격 */
            width: 100%;
            max-width: 950px;
        }

        .glass-icon {
            width: 30px;
        }

        .keyword {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 6px;
            /* 제시어와 정답 간 간격 */
        }

        .keyword p {
            color: #FFF;
            font-size: 24px;
            font-weight: 500;
            margin: 0;
        }

        .keyword p span {
            font-weight: 800;
        }

        .keyword .explanation {
            color: #5470FF;
            /* 색상 강제 적용 */
            font-size: 24px;
            font-weight: 500;
            margin-top: 22px;
            /* 정답과 해설 간 정확한 간격 */
        }
        

        .comment {
            position: absolute;
            right: 20px;
            /* 오른쪽으로부터 20px 간격 */
            color: #888;
            text-align: right;
            font-family: Pretendard;
            font-size: 24px;
            font-style: normal;
            font-weight: 500;
            line-height: normal;
            bottom: 455px;
        }
        
    </style>
</head>

<body>
    <main>
        <img src="static/image/c_yellow.png" alt="노랑 따봉 이미지" class="c-yellow">
        <div class="main-text">
            <p>축하합니다!<br><span><c:out value="${correctCnt}"/></span>개 만큼의 문제를 맞췄습니다!</p>
        </div>
        <div class="button" onclick="window.location.href = '/WordQuiz3/quiz.nhn?action=rankingPage'">
            <p>내 랭킹 보러가기</p>
            <img src="static/image/arrow-right.png" alt="오른쪽 화살표">
        </div>
    </main>

    <footer>
        <!-- 문제 해설 텍스트 -->


		<c:forEach var="q" items="${quizList}" varStatus="status">
        <!-- 박스 1 -->
        	<c:set var="flag" value="${quizFlagList[status.index]==0}"/>
        	<div class="box">
            	<p>🔎</p>
            	<div class="keyword">
                	<p class="nickname"><span>제시어 : </span> ${q.word}</p>
                	<p><span>정답 :</span> ${q.answer} ${q.options[q.answer-1]}</p>
                	<p class="explanation" style="<c:if test='${flag}'>color : red;</c:if>"><span>해설 :</span> ${q.reason} </p>
            	</div>
        	</div>
		</c:forEach>

    </footer>
</body>

</html>