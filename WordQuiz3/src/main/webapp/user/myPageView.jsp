<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>유저 설정</title>
<style>
        body {
            font-family: Pretendard, Arial, sans-serif;
            background: #C3C3FF;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            display: flex;
            gap: 63px;
            align-items: center;
        }

        .mypage-wrapper {
            width: 504px;
            height: 638px;
            border-radius: 20px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            position: relative;
            box-sizing: border-box;
        }

        .profile {
            width: 148px;
            height: 148px;
            border-radius: 40.282px;
            background: #D9D9D9;
            position: relative;
            flex-shrink: 0;
        }

        .profile::after {
            content: '';
            width: 34px;
            height: 34px;
            position: absolute;
            bottom: 10px;
            left: 125px;
            background-color: #FFF;
            border-radius: 50%;
            border: 3px solid #C3C3FF;
            background: url('static/image/camera-icon.png') no-repeat center center;
            background-size: contain;
        }

        .nickname {
            margin-left: 180px;
            margin-top: -128px;
            color: rgba(60, 61, 62, 0.95);
            font-size: 23px;
            font-weight: 600;
        }

        .status-message-background {
            margin-top: 13px;
            margin-left: 180px;
            width: 317px;
            height: 86px;
            border-radius: 8.25px;
            background: #EFEFEF;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .status-message-text {
            width: 281px;
            color: #8A8A8A;
            font-size: 15px;
            font-weight: 500;
            line-height: 22.5px;
            /* 150% */
            text-align: left;
        }

        .info-box {
            margin-top: 92px;
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 51px;
        }

        .info-row {
            display: flex;
            align-items: center;
            position: relative;
        }

        .info-label {
            color: #636363;
            font-size: 20px;
            font-weight: 600;
            width: 154px;
            text-align: left;
        }

        .info-value {
            color: #F3F3F3;
            font-size: 20px;
            font-weight: 500;
            text-align: left;
            max-width: 320px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .divider {
            width: 325px;
            height: 0;
            border-top: 2px solid rgba(103, 103, 103, 0.20);
            margin-top: 35px;
            position: absolute;
            right: 30px;
        }

        .buttons {
            position: absolute;
            right: 30px;
            display: flex;
            gap: 14px;
            bottom: 8px;
        }

        .edit-btn,
        .delete-btn {
            width: 176px;
            height: 53px;
            border-radius: 8.535px;
            font-size: 20px;
            font-weight: 500;
            text-align: center;
            letter-spacing: 2.2px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
        }

        .edit-btn {
            background: #A4ACFF;
            color: #3C3D3E;
        }

        .delete-btn {
            background: #F3F3F3;
            color: #3C3D3E;
        }

        /*오른쪽 댓글 창*/

        .comments-wrapper {
            width: 629px;
            height: 632px;
            border-radius: 36.75px;
            background: linear-gradient(180deg, rgba(84, 112, 255, 0.28) 99.99%, rgba(84, 112, 255, 0.14) 100%);
            backdrop-filter: blur(29.557px);
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            position: relative;
            box-sizing: border-box;
        }

        .comments-wrapper h3 {
            position: absolute;
            bottom: 33px;
            right: 57px;
            color: #636363;
            font-size: 16px;
            font-weight: 600;
            text-align: right;
            letter-spacing: 0.16px;
        }

        .comment-box {
            width: 517px;
            height: 506px;
            margin: 0 auto;
            margin-bottom: 81px;
            display: flex;
            flex-direction: column;
            gap: 25px;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .comment-box::-webkit-scrollbar {
            width: 20px;
        }

        .comment-box::-webkit-scrollbar-thumb {
            background: rgba(21, 21, 21, 0.60);

            backdrop-filter: blur(32.662498474121094px);
            border-radius: 10px;
        }

        .comment-box::-webkit-scrollbar-track {
            background-color: rgba(0, 0, 0, 0.3);
            border-radius: 10px;
        }

        .comment {
            background-color: transparent;
            display: flex;
            flex-direction: column;
        }

        .comment-header {
            display: flex;
            align-items: center;
            margin-bottom: 13px;
        }

        .comment-profile {
            width: 50px;
            height: 50px;
            border-radius: 13.5px;
            background: #D9D9D9;
            margin-right: 12px;
        }

        .comment-name {
            color: #FFF;
            font-size: 21px;
            font-weight: 700;
            margin-right: 21px;
        }

        .comment-date {
            color: #8A8A8A;
            font-size: 15px;
            font-weight: 500;
        }

        .comment-content {
            color: #FFF;
            font-size: 21px;
            font-weight: 600;
            line-height: 33.75px;
            /* 160.714% */
            width: 455px;
            margin-left: 62px;
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
	<div  class="container">
		<div class="mypage-wrapper">
			<div class="profile"><img src="${users.img}" class="profile" onerror="this.src='static/image/profile1.png'"></div>
			<p class="nickname">${users.nickname}</p>
			<div class="status-message-background">
                <div class="status-message-text">
                    <p>${users.content}</p>
                </div>
            </div>
            <div class="info-box">
				<div class="info-row">
                    <span class="info-label">🧩 아이디</span>
                    <span class="info-value">${users.id}</span>
                    <div class="divider"></div>
                </div>
				<div class="info-row">
                    <span class="info-label">🧩 비밀번호</span>
                    <span class="info-value">${users.password}</span>
                    <div class="divider"></div>
                </div>
                <div class="info-row">
                    <span class="info-label">🧩 닉네임</span>
                    <span class="info-value">${users.nickname}</span>
                    <div class="divider"></div>
                </div>
                <div class="info-row">
                    <span class="info-label">🧩 나이</span>
                    <span class="info-value">${users.age}</span>
                    <div class="divider"></div>
                </div>
			</div>
			<div>
				<div class="buttons">
					<button type="button" onclick='btnClick()' class="edit-btn">수정</button>
					<button type="button" onclick="location.href='/WordQuiz3/quiz.nhn?action=deleteUser'" class="delete-btn">회원 탈퇴</button>
				</div>
			</div>
		</div>
		<div id='my-div' style="display:none;">
			<form method="post" action="/WordQuiz3/quiz.nhn?action=updateUser" enctype="multipart/form-data">
				<label class="info-label">이미지</label><br>
				<input type="file" name="file" class="info-value" style="color:#080808"><br>
				<label class="info-label">닉네임</label><br>
				<input type="text"name="nickname"  class="info-value" style="color:#080808"><br> 
				<label class="info-label">비밀번호</label><br>
				<input type="text"name="password"  class="info-value" style="color:#080808"><br>
				<label class="info-label">나이</label><br> 
				<input type="number"name="age"  class="info-value" style="color:#080808"><br>
				<label class="info-label">자기소개</label><br>
				<textarea cols="50" rows="5" name="content"  class="info-value" style="color:#080808"></textarea><br>
				<button type="submit" class="edit-btn">저장</button>
			</form>
		</div>
		<div class="comments-wrapper">
		<h3>💬 나에게 달린 댓글</h3>
			<div class="comment-box">
				<ul>
					<c:forEach var="reply" items="${replylist}" varStatus="status">
						<li class="comment">
							<div class="comment-header">
								<img  class="comment-profile" src="${reply.img}" onerror="this.src='static/image/profile1.png'">
								<div class="comment-name">${reply.nickname}</div>
								<div class="comment-date">${reply.create_at}</div>
							</div>
							<div class="comment-content">
                        		${reply.content}
                    		</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>