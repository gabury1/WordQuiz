<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Belanosima:wght@700&display=swap" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Belanosima:wght@400;700&display=swap');

        body {
            font-family: Pretendard, Arial, sans-serif;
            background: #C3C3FF;
            margin: 0;
            padding: 0;
        }

        header {
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            margin-top: 30px;
            width: 100%;
        }

        .brand-name {
            color: #5470FF;
            text-align: center;
            font-family: Belanosima;
            font-size: 62px;
            font-weight: 700;
        }

        .my-profile {
            display: flex;
            align-items: center;
            gap: 21px;
            position: absolute;
            right: 50px;
        }

        .profile-image {
            width: 50px;
            height: 50px;
            border-radius: 13.5px;
            background: #D9D9D9;
        }

        .nickname {
            color: #716F6F;
            font-size: 21px;
            font-weight: 600;
        }

        nav {
            display: flex;
            align-items: center;
            margin-top: 60px;
            margin-left: 100px;
            gap: 38px;
        }

        nav img {
            width: 120px;
            height: 124px;
        }

        .box {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 117px;
            border-radius: 200px;
            background: #F3F3F3;
            box-shadow: -4px 6px 6px 0px rgba(46, 46, 46, 0.10);
            overflow: hidden;
            /* 텍스트가 박스 크기를 넘어가지 않게 */
            animation: expand-box 1.5s ease-out forwards;
            /* 박스 펼쳐짐 애니메이션 */
            width: 0;
            /* 초기 width */
        }

        @keyframes expand-box {
            from {
                width: 0;
            }

            to {
                width: 520px;
                /* 최종 박스 크기 제한 */
            }
        }


        .explane {
            color: #232323;
            font-family: Pretendard;
            font-size: 16px;
            font-style: normal;
            font-weight: 600;
            line-height: 21px;
            overflow: hidden;
            /* 텍스트 초과 부분 숨김 */
            white-space: nowrap;
            /* 텍스트를 한 줄로 유지 */
            border-right: 2px solid #9e9e9e;
            /* 깜박이는 커서 효과 */
            width: 0px;
            /* 초기 width */
            animation: typing 3s steps(50, end) forwards, blink-caret 1.5s step-end infinite;
        }

        /* 애니메이션 종료 후 overflow를 제거 */
        .explane.end {
            overflow: visible;
            /* 텍스트가 모두 보이도록 */
            white-space: normal;
            /* 줄바꿈을 허용 */
            border-right: none;
            /* 깜박이는 커서 제거 */
            animation: none;
            /* 애니메이션 비활성화 */
        }

        @keyframes typing {
            from {
                width: 50;
            }

            to {
                width: 72%;
            }
        }

        @keyframes blink-caret {
            50% {
                border-color: transparent;
            }
        }

        main {
            display: flex;
            align-items: center;
            margin-top: 75px;
            gap: 38px;
            justify-content: center;
            /* 가로 중앙 정렬 */
        }

        .quiz-box {
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            /*그림자*/
        }

        .quiz-box:hover {
            filter: drop-shadow(-6px 6px 6px #5470FF);
            transform: scale(1.1);
            /* 크기 증가 효과 */
        }

        main img {
            width: 470px;
            height: 265px;
        }

        main p {
            color: #F3F3F3;
            text-align: center;
            text-shadow: 0px 3.372px 0.843px rgba(0, 0, 0, 0.25);
            font-family: Belanosima;
            font-size: 70px;
            font-style: normal;
            font-weight: 700;
            line-height: 92.729px;
            /* 132.471% */
            position: absolute;
        }

        /*주사위 이미지*/
        .dice {
            position: absolute;
            transform: translate(-50%, -50%);
            width: 916px;
            height: auto;
            z-index: -1;
            /* 뒤로 배치 */
            animation: dice-move 5s infinite ease-in-out;
            /* 자연스러운 애니메이션 */
        }

        @keyframes dice-move {
            0% {
                transform: translateY(-50px);
            }

            50% {
                transform: translateY(0);
            }

            100% {
                transform: translateY(-50px);
            }
        }

        /* Footer 컨테이너 */
        footer {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 1117px;
            margin: 0 auto;
            margin-top: 79px;
            margin-bottom: 45px;
            padding-top: 100px;
            padding-bottom: 40px;
            border-radius: 41.25px;
            background: rgba(21, 21, 21, 0.60);
            backdrop-filter: blur(32.662498474121094px);
            flex-direction: column;
            gap: 76px;
            /* Ranking1과 Ranking2 간격 */
        }

        /* Ranking1: 상단 랭킹 */
        .top-ranking {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 146px;
            align-items: flex-start;
            /* 프로필과 이미지 정렬 */
        }

        .ranking1-profile {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            /* 이미지 배치를 위해 필요 */
        }

        .ranking1-profile:nth-child(1) {
            margin-top: 37px;
            /* 두 번째 프로필만 아래로 이동 */
        }

        .ranking1-profile:nth-child(3) {
            margin-top: 37px;
            /* tp 번째 프로필만 아래로 이동 */
        }

        .ranking1-profile-image {
            width: 128px;
            height: 128px;
            border-radius: 34.883px;
            background: #D9D9D9;
        }

        .ranking1-nickname {
            color: #FFF;
            text-align: center;
            font-family: Pretendard;
            font-size: 26px;
            font-style: normal;
            font-weight: 700;
            line-height: normal;
        }

        .profile-medal {
            position: absolute;
            width: 75px;
            height: auto;
            bottom: 180px;
            /* 프로필 하단 기준으로 위치 */
        }

        /*
        .winner-box {
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            width: 822px;
            height: 105px;
        }

        .second-place {
            display: flex;
            align-items: center;
            height: 75px;
            width: auto;
            padding: 12px 146.5px 12px 126.5px;
            border-radius: 12.117px 12.117px 0px 0px;
            background: linear-gradient(180deg, rgba(152, 169, 255, 0.70) 0%, rgba(91, 118, 255, 0.03) 100%);
            position: absolute;
            left: 0;
            bottom: 0;
        }

        .second-place p {
            color: #F3F3F3;
            text-align: center;
            font-family: Belanosima;
            font-size: 46px;
            font-style: normal;
            font-weight: 400;
            line-height: normal;
        }

        .first-place {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            padding: 6px 136px;
            border-radius: 12.117px 12.117px 0px 0px;
            background: linear-gradient(180deg, rgba(152, 169, 255, 0.70) 0%, rgba(91, 118, 255, 0.03) 100%);
            z-index: 1;
            height: 105px;
            width: auto;
        }

        .first-place p {
            color: #F3F3F3;
            text-align: center;
            text-shadow: 0px 2.693px 0.673px rgba(0, 0, 0, 0.25);
            font-family: Belanosima;
            font-size: 85px;
            font-style: normal;
            font-weight: 400;
            line-height: normal;
        }

        .third-place {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            height: 75px;
            width: auto;
            padding: 12px 126px 12px 148px;
            border-radius: 12.117px 12.117px 0px 0px;
            background: linear-gradient(180deg, rgba(152, 169, 255, 0.70) 0%, rgba(91, 118, 255, 0.03) 100%);
            position: absolute;
            right: 0;
        }

        .third-place p {
            color: #F3F3F3;
            text-align: center;
            font-family: Belanosima;
            font-size: 46px;
            font-style: normal;
            font-weight: 400;
            line-height: normal;
        }
/*

        /* Ranking2: 퀴즈 랭킹 리스트 */
        .Ranking2 {
            width: 995px;
            display: flex;
            flex-direction: column;
        }

        p.ranking-title {
            color: #FFF;
            font-family: Pretendard;
            font-size: 30px;
            font-style: normal;
            font-weight: 600;
            line-height: normal;
        }

        .rank-list {
            display: flex;
            flex-direction: column;
        }

        .rank-item-container {
            display: flex;
            align-items: center;
        }

        .rank-item-container:not(:last-child) {
            margin-bottom: 23px;
        }

        .rank-number {
            color: #F3F3F3;
            text-align: center;
            font-family: Pretendard;
            font-size: 27px;
            font-style: normal;
            font-weight: 600;
            line-height: normal;
            margin-right: 37px;
            /* 숫자와 랭크 아이템 간격 */
        }

        .rank-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0px 19px;
            width: 100%;
            border-radius: 18.75px;
            background: rgba(117, 139, 255, 0.2);
        }

        .rank-item .profile {
            display: flex;
            align-items: center;
            gap: 50px;
        }

        .rank-item .profile-image {
            width: 74px;
            height: 74px;
            border-radius: 20.262px;
            background: #D9D9D9;
        }

        .rank-item .nickname {
            color: #FFF;
            font-family: Pretendard;
            font-size: 31px;
            font-style: normal;
            font-weight: 600;
            line-height: normal;
        }

        .rank-item .score-section {
            display: flex;
            align-items: center;
            gap: 20px;
            /* 맞은 개수와 점수 간격 */
        }

        .rank-item .score-text {
            color: #C2C2C2;
            text-align: right;
            font-family: Pretendard;
            font-size: 31.5px;
            font-style: normal;
            font-weight: 500;
            line-height: normal;
        }

        .rank-item .score {
            color: #FFF;
            text-align: right;
            font-family: Pretendard;
            font-size: 31.5px;
            font-style: normal;
            font-weight: 700;
            line-height: normal;
        }

        /* 동적 높이 및 마진 */
        footer {
            transition: height 0.3s ease;
            /* 높이 변화 애니메이션 */
        }

        .Ranking2 .rank-list .rank-item:last-child {
            margin-bottom: 15px;
            /* 바닥과의 간격 */
        }
    </style>
</head>

<body>
    <header>
        <div class="brand-name">ReadUp</div>
        <div class="my-profile">
            <div class="profile-image"></div>
            <div class="nickname">뷔질순없진</div>
        </div>
    </header>

    <nav>
        <img src="image/mainpage-c-main.png" alt="캐릭터">
        <div class="box">
            <div class="explane">
                <p>“리드업”은 문해력을 향상시키고자 하는 학생들을 위해<br> AI 기반 퀴즈 게임을 제공하는 어플입니다:)</p>
                <p>그럼 저희 누가 더 높은 점수를 달성하나 시합하러 가볼까요?</p>
            </div>
        </div>
    </nav>

    <main>
        <div class="quiz-box">
            <img src="image/quiz-box.png" alt="Quiz Box">
            <p>문해력 퀴즈 <br>Start!</p>
        </div>
        <img src="image/dice.png" class="dice" alt="주사위">
    </main>
    <footer>
        <div class="ranking-container">
            <!-- Ranking1: 상단에 메달과 함께 1~3위 표시 -->
            <div class="top-ranking">
                <!-- 첫 번째 프로필 -->
                <div class="ranking1-profile">
                    <img src="image/medal-second.png" alt="2등" class="profile-medal second">
                    <div class="ranking1-profile-image"></div>
                    <p class="ranking1-nickname">뷔질순없진</p>
                </div>

                <!-- 두 번째 프로필 -->
                <div class="ranking1-profile">
                    <img src="image/medal-second.png" alt="2등" class="profile-medal second">
                    <div class="ranking1-profile-image"></div>
                    <p class="ranking1-nickname">뷔질순없진</p>
                </div>

                <!-- 세 번째 프로필 -->
                <div class="ranking1-profile">
                    <img src="image/medal-second.png" alt="2등" class="profile-medal second">
                    <div class="ranking1-profile-image"></div>
                    <p class="ranking1-nickname">뷔질순없진</p>
                </div>
            </div>
            <img src="image/ranking-box.png" width="822px">
            <!-- 
            <div class="winner-box">
                <div class="second-place">
                    <p>2</p>
                </div>
                <div class="first-place">
                    <p>1</p>
                </div>
                <div class="third-place">
                    <p>3</p>
                </div>
            </div>
           -->
        </div>

        <!-- Ranking2: 퀴즈 랭킹 리스트 -->
        <div class="Ranking2">
            <p class="ranking-title">퀴즈 랭킹 🧩 </p>
            <!-- 첫 번째 랭킹 -->
            <div class="rank-item-container">
                <p class="rank-number">1</p>
                <div class="rank-item">
                    <div class="profile">
                        <div class="profile-image"></div>
                        <p class="nickname">뷔질순없진</p>
                    </div>
                    <div class="score-section">
                        <p class="score-text">맞은 개수:</p>
                        <p class="score">900</p>
                    </div>
                </div>
            </div>
            <!-- 동적으로 랭킹 계속 추가 -->
            <div class="rank-item-container">
                <p class="rank-number">1</p>
                <div class="rank-item">
                    <div class="profile">
                        <div class="profile-image"></div>
                        <p class="nickname">뷔질순없진</p>
                    </div>
                    <div class="score-section">
                        <p class="score-text">맞은 개수:</p>
                        <p class="score">900</p>
                    </div>
                </div>
            </div>
        </div>
    </footer>
</body>

</html>
