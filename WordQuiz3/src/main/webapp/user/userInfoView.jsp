<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 페이지</title>

<!-- Pretendard 폰트 불러오기 -->
<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Belanosima:wght@700&display=swap" rel="stylesheet">
<style>
        body {
            font-family: Pretendard, Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: #C3C3FF;
            overflow: hidden;
        }

        .main {
            position: relative;
            display: flex;
            justify-content: flex-start;
            align-items: center;
            width: 100%;
            max-width: 1600px;
        }

        .profile-box {
            position: relative;
            width: 605px;
            height: 605px;
            border-radius: 37.644px;
            background: linear-gradient(180deg, rgba(84, 112, 255, 0.42) 99.99%, rgba(84, 112, 255, 0.14) 100%);
            backdrop-filter: blur(30.276px);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            box-sizing: border-box;
            z-index: 1;
            margin-left: 10vw;
        }

        #profile-image {
            width: 147px;
            height: 147px;
            margin-bottom: 15px;
            text-align: center;
        }

        .profile-name {
            color: #FFF;
            text-align: center;
            font-size: 25px;
            font-weight: 600;
            margin-bottom: 9px;
            ;
            text-align: center;
        }

        .profile-age {
            color: #676767;
            font-size: 18px;
            font-weight: 500;
            margin: 0;
            text-align: center;
        }

        .status-message {
            color: #525252;
            text-align: center;
            font-size: 23px;
            font-weight: 600;
            line-height: 34.571px;
            width: 423px;
            margin-top: 35.43px;
            margin-bottom: 49.57px;
        }

        .ranking-section,
        .quiz-section {
            display: flex;
            justify-content: space-between;
            width: 423px;
            margin-bottom: 15px;
        }

        .ranking-title,
        .quiz-title {
            color: #FFF;
            font-size: 30px;
            font-weight: 600;
        }

        .ranking-value,
        .quiz-value {
            color: #676767;
            text-align: right;
            font-size: 30px;
            font-weight: 500;
        }

        .divider {
            width: 423px;
            border-top: 2.305px solid rgba(103, 103, 103, 0.20);
            margin-bottom: 15px;
        }

        /*오른쪽 채팅창*/
        .chat-box {
            position: absolute;
            width: 1204px;
            height: 575px;
            border-radius: 37.644px;
            background: linear-gradient(180deg, rgba(84, 112, 255, 0.28) 99.99%, rgba(84, 112, 255, 0.14) 100%);
            backdrop-filter: blur(30.276px);
            display: flex;
            align-items: center;
            justify-content: flex-end;
            overflow: hidden;
            animation: slideIn 1.5s forwards ease-in-out;
        }

        @keyframes slideIn {
            from {
                transform: translateX(-1.5vw);
            }

            to {
                transform: translateX(calc(1vw));
            }
        }


        .chat-container {
            width: 529px;
            height: 493px;
            flex-shrink: 0;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            margin-right: 36px;
        }

        .chat-content {
            width: 529px;
            height: 375px;
            overflow-y: auto;
            padding-bottom: 10px;
        }

        .chat-content::-webkit-scrollbar {
            width: 20px;
        }

        .chat-content::-webkit-scrollbar-thumb {
            background: rgba(21, 21, 21, 0.60);

            backdrop-filter: blur(32.662498474121094px);
            border-radius: 10px;
        }

        .chat-content::-webkit-scrollbar-track {
            background-color: rgba(0, 0, 0, 0.3);
            border-radius: 10px;
        }

        .chat-message {
            margin-bottom: 25px;
            display: flex;
            flex-direction: column;
        }

        .chat-message-header {
            display: flex;
            align-items: center;
            margin-bottom: 13px;
        }

        .profile-pic2 {
            width: 50px;
            height: 50px;
            border-radius: 13.5px;
            background-color: #ccc;
            margin-right: 12px;
        }

        .profile-name2 {
            color: #FFF;
            font-size: 21px;
            font-weight: 700;
            margin-right: 21px;
        }

        .profile-time {
            color: #8A8A8A;
            font-size: 15px;
            font-weight: 500;
        }

        .message-content {
            width: 403x;
            color: #FFF;
            font-size: 21px;
            font-weight: 600;
            line-height: 33.75px;
        }

        .chat-input {
            width: 100%;
            height: 81px;
            border-radius: 19.59px;
            background: #525252;
            display: flex;
            align-items: center;
            padding: 0 21px;
            box-sizing: border-box;
        }

        .chat-input input {
            flex-grow: 1;
            border: none;
            outline: none;
            background: transparent;
            color: white;
            font-size: 18px;
        }

        .chat-input button {
            width: 47px;
            height: 47px;
            background: url('static/image/send-icon.png') no-repeat center center;
            background-size: contain;
            border: none;
            cursor: pointer;
        }

        #top-icon {
            position: fixed;
            width: 6vh;
            left: calc(4%);
            top: calc(7%);
            cursor: pointer;
            z-index: 1;
        }
    </style>
</head>
<body>
	<div class="main">
		<div class="profile-box">
			<img src="${users.img}" id="profile-image" alt="profile-image" onerror="this.src='static/image/profile1.png'">
			<div class="profile-name">${users.nickname} </div>
			<div class="profile-age">${users.age}</div>
			<div class="status-message">${users.content}</div>
			<div class="ranking-section">
				<div class="ranking-title">랭킹 순위🏅</div>
				<div class="ranking-value">${param.rank}</div>
			</div>
			<div class="divider"></div>
            <div class="quiz-section">
                <div class="quiz-title">맞은 퀴즈 개수🧩</div>
                <div class="quiz-value">${param.answer}</div>
            </div>
		</div>
	</div>
	
	<div class="chat-box">
        <div class="chat-container">
            <ul class="chat-content" id="chat-content">
                <c:forEach var="reply" items="${replylist}" varStatus="status">
					<li>
						<div class="chat-message-header">
							<img src="${reply.img}" class="profile-pic2"  onerror="this.src='static/image/profile1.png'">
							<div class="profile-name2">${reply.nickname} </div>
							<div class="profile-time">${reply.create_at}</div>
						</div>	
						 <div class="message-content">${reply.content}</div>
					</li>
				</c:forEach>
            </ul>
            <form method="post" action="/WordQuiz3/quiz.nhn?action=addComments&target_no=${param.target_no}" enctype="multipart/form-data">
            	<div class="chat-input">
        			<input type="text" name="content" placeholder="상대에게 댓글을 달아주세요💭" id="chat-input">
        			<button type="submit" id="send-button"></button>
        		</div>
			</form>
        </div>
    </div>
    <img src="static/image/top-icon.png" alt="Top Icon" id="top-icon">
</body>
</html>