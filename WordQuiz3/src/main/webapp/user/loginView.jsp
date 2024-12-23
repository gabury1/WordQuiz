<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <!-- Pretendard 폰트 불러오기 -->
    <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Belanosima:wght@700&display=swap" rel="stylesheet">
    <style>
        /* 기본 스타일 초기화 */
        body {
            font-family: 'Pretendard', Arial, sans-serif;
            display: flex;
            align-items: center;
            /* 세로 중앙 정렬 */
            justify-content: center;
            /* 가로 왼쪽 정렬 */
            height: 100vh;
            /* 화면 전체 높이 */
            margin: 0;
            background-color: #1E1E20;
            padding-left: 114px;
            /* 화면 왼쪽에서 114px 여백 유지 */
        }

        /* 로그인 컨테이너 스타일 */
        .login-wrapper {
            background: rgba(38, 38, 38, 0.95);
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 74px 76.5px;
            flex-shrink: 0;
            /* 크기 고정 */
        }

        /* 환영합니다 텍스트 스타일 */
        .welcome-text {
            color: #F3F3F3;
            font-size: 40px;
            font-weight: 400;
            line-height: normal;
            margin-bottom: 55.4px;
            text-align: left;
        }

        /* 입력 그룹 스타일 */
        .input-group {
            margin-bottom: 34.4px;
            width: 404px;
        }

        .input-label {
            color: #4A4C4E;
            font-size: 19px;
            font-weight: 400;
            line-height: normal;
            display: block;
            margin-bottom: 8px;
        }

        .input-field {
            width: 385px;
            height: 53px;
            border-radius: 8.776px;
            background: #2E2E30;
            border: none;
            padding: 0 15px;
            font-size: 16px;
            color: #F3F3F3;
        }

        .input-field:focus {
            outline: none;
            border: 1.596px solid #5470FF;
        }

        /* 버튼 그룹 스타일 */
        .button-group {
            margin-top: 71px;
            display: flex;
            flex-direction: column;
            gap: 21px;
        }

        .login-button,
        .signup-button {
            width: 404px;
            height: 53px;
            border-radius: 8.776px;
            font-size: 20px;
            font-weight: 500;
            letter-spacing: 0.4px;
            border: none;
            cursor: pointer;
            font-family: 'Pretendard', Arial, sans-serif;
        }

        .login-button {
            background: #5470FF;
            color: #3C3D3E;
        }

        .signup-button {
            background: #F3F3F3;
            color: #3C3D3E;
        }

        /* level-up-wrapper 스타일 */
        .level-up-wrapper {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-left: 195px;
            /* 로그인 박스와 간격 */
        }

        .c-main {
            width: 246px;
            height: 254px;
        }

        .text-container {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 129px;
            /* 이미지와 텍스트 간 간격 */
        }

        .text {
            color: #5470FF;
            font-family: 'Belanosima', Arial, sans-serif;
            font-size: 95px;
            font-weight: 700;
            line-height: 60.02px;
            transition: transform 20s ease; /* 부드러운 애니메이션 */
            /* 크기와 투명도 애니메이션 */
        }

        .text.level {
            opacity: 1;
            transform: scale(1);
            transition: all 1s ease;
        }

        .text-container.centered .text.level {
            opacity: 0;
            /* 점점 투명해짐 */
            transform: scale(0
            5);
            /* 점점 작아짐 */
            width: 0;
            /* 완전히 사라질 때 공간 제거 */
        }

        .text-container {
            gap: 20px;
            /* 초기 간격 */
            transition: gap 3s ease;
            /* 간격도 부드럽게 줄어듦 */
        }

        .text-container.centered {
            gap: 0;
            /* Read와 Up 사이를 완전히 붙임 */
        }
    </style>
</head>

<body>
    <div class="login-wrapper">
        <h1 class="welcome-text">환영합니다!</h1>
        <form class="login-form" action="/WordQuiz3/quiz.nhn?action=login" method="post">
            <div class="input-group">
                <label for="id" class="input-label">ID</label>
                <input id="id" name="id" type="text" class="input-field" required>
            </div>
            <div class="input-group">
                <label for="password" class="input-label">Password</label>
                <input id="password" name="password" type="password" class="input-field" required>
            </div>
            <div class="button-group">
                <!-- 로그인 버튼 -->
                <button type="submit" class="login-button">로그인</button>
                <button type="button" class="signup-button" onclick="window.location.href='/WordQuiz3/quiz.nhn?action=registerPage'">
            회원가입
        </button>
            </div>
        </form>
    </div>

    <!-- Level Up Wrapper -->
    <div class="level-up-wrapper">
        <img src="static/image/c-main.png" alt="Thumbs Up" class="c-main">
        <div class="text-container">
            <span class="text read">Read</span>
            <span class="text level">Level</span>
            <span class="text up">Up</span>
        </div>
    </div>

    <script>
        // DOMContentLoaded 이벤트로 JavaScript 실행
        document.addEventListener("DOMContentLoaded", () => {
            const textContainer = document.querySelector(".text-container");

            // 1초 후에 애니메이션 시작
            setTimeout(() => {
                textContainer.classList.add("centered");
            }, 1000);
        });
    </script>
</body>

</html>