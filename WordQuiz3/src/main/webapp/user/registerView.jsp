<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up Page</title>
    <!-- Pretendard 폰트 불러오기 -->
    <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">
    <style>
        /* 기본 스타일 초기화 */
        body {
            font-family: 'Pretendard', Arial, sans-serif;
            display: flex;
            align-items: center;
            /* 세로 중앙 정렬 */
            justify-content: center;
            /* 가로 중앙 정렬 */
            height: 100vh;
            /* 화면 전체 높이 */
            margin: 0;
            background-color: #1E1E20;
        }

        /* 회원가입 컨테이너 */
        .signup-wrapper {
            border-radius: 15px;
            background: rgba(38, 38, 38, 0.95);
            box-shadow: 8px 8px 8px 0px rgba(0, 0, 0, 0.05);
            padding: 65.75px 84px;
            /* 상, 우, 하, 좌 */
        }

        .signup-title {
            color: #F3F3F3;
            font-family: Pretendard;
            font-size: 37px;
            font-style: normal;
            font-weight: 400;
            line-height: normal;
            margin-bottom: 60px;
        }

        /* 입력 그룹 */
        .input-group {
            display: flex;
            align-items: center;
            margin-bottom: 27px;
        }

        .input-label {
            font-size: 19px;
            width: 120px;
            color: #636363;
            font-family: Pretendard;
            font-weight: 500;
        }

        .input-field {
            width: 391px;
            height: 50px;
            flex-shrink: 0;
            border-radius: 8.25px;
            background: #2E2E30;
            box-shadow: 4px 4px 4px 0px rgba(0, 0, 0, 0.05);
            border: none;
            padding: 0 15px;

            color: #F3F3F3;
            font-family: Pretendard;
            font-size: 19px;
            font-style: normal;
            font-weight: 400;
            line-height: normal;
            margin-left: 18px;
        }

        .input-field:focus {
            outline: none;
            box-shadow: inset 0 0 0 1.5px #5470FF;
            /* 내부 테두리 효과 */
        }

        /* 중복확인 버튼 */
        .check-button {
            width: 155px;
            height: 50px;
            flex-shrink: 0;
            border-radius: 8.25px;
            background: #F3F3F3;
            color: #3C3D3E;
            text-align: center;
            font-family: 'Pretendard', Arial, sans-serif;
            font-size: 19px;
            font-weight: 500;
            line-height: normal;
            letter-spacing: 0.38px;
            border: none;
            margin-left: 18px;
            cursor: pointer;
        }

        /* 버튼 그룹 */
        .button-group {
            display: flex;
            justify-content: center;
            /* 버튼을 왼쪽 정렬 */
            gap: 14px;
            /* 버튼 간 간격 */
            margin-top: 52.5px;
        }

        .button {
            width: 176px;
            /* 버튼 너비 */
            height: 53px;
            /* 버튼 높이 */
            border-radius: 8.535px;
            font-size: 20px;
            font-weight: 500;
            text-align: center;
            line-height: normal;
            letter-spacing: 2.2px;
            cursor: pointer;
            border: none;

            color: #3C3D3E;
            text-align: center;
            font-family: Pretendard;
            font-size: 20px;
            font-style: normal;
            font-weight: 500;
            line-height: normal;
            letter-spacing: 2.2px;
        }

        .submit-button {
            background: #5470FF;
            color: #3C3D3E;
        }

        .cancel-button {
            background: #F3F3F3;
            color: #3C3D3E;
        }

        /* 이미지 스타일 */
    #gradient {
        position: absolute;
        bottom: calc(0px);
        left: 50%;
        transform: translateX(-50%);
        width: 190vh;
        z-index: -1;
    }

    #c-double {
        position: absolute;
        bottom: calc(7%);
        right: calc(5%);
        width: 15vh;
        z-index: -1;
    }

    /* 애니메이션 스타일 */
    @keyframes slideDown {
        from {
            transform: translateY(-100px);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
    }

    .signup-wrapper {
        animation: slideDown 0.8s ease-out;
    }
</style>
    </style>
</head>

<body>
    <div class="signup-wrapper">
        <h1 class="signup-title">회원가입</h1>
        <form action="/WordQuiz3/quiz.nhn?action=register" method="post">
    <!-- 아이디 -->
    <div class="input-group">
        <label class="input-label" for="id">아이디</label>
        <input type="text" id="id" name="id" class="input-field" required>
        <button type="button" class="check-button" onclick="checkField('id')">중복확인</button>
    </div>
    
    <!-- 비밀번호 -->
    <div class="input-group">
        <label class="input-label" for="password">비밀번호</label>
        <input type="password" id="password" name="password" class="input-field" required>
        <input type="password" name="password2" class="input-field" placeholder="비밀번호 재확인" required>
    </div>
    
    <!-- 닉네임 -->
    <div class="input-group">
        <label class="input-label" for="nickname">닉네임</label>
        <input type="text" id="nickname" name="nickname" class="input-field" required>
    </div>
    
    <!-- 나이 -->
    <div class="input-group">
        <label class="input-label" for="age">나이</label>
        <input type="number" id="age" name="age" class="input-field" required>
    </div>
    
    <!-- 버튼 그룹 -->
    <div class="button-group">
        <!-- 가입하기 버튼 -->
        <button type="submit" class="button submit-button">가입하기</button>
        
        <!-- 취소 버튼 -->
        <button type="button" class="button cancel-button" onclick="window.location.href='/WordQuiz3/quiz.nhn?action=login'">
            취소
        </button>
    </div>
</form>

<script>
    // 중복확인 함수
    function checkField(field) {
        const value = document.getElementById(field).value;
        if (!value) {
            alert(`${field}를 입력해주세요.`);
            return;
        }
        // 중복 확인 로직 (예시)
        alert(`${field} 중복 확인 요청: ${value}`);
        // 여기서 서버 요청을 처리할 수 있습니다.
        document.getElementById(`${field}CheckResult`).innerText = "사용 가능"; // 결과 출력 (테스트용)
    }
</script>

    </div>
    <img src="image/gradient.png" id="gradient" alt="Gradient Background">
    <img src="image/c-double.png" id="c-double">
</html>