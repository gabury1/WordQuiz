<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <!-- jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        // 중복 확인 함수
        function checkField(field) {
            const value = $("#" + field).val(); // 입력된 값 가져오기
            const resultSpan = $("#" + field + "CheckResult"); // 결과를 표시할 요소

            if (!value) {
                resultSpan.text("값을 입력해주세요.").css("color", "red");
                return;
            }

            // AJAX 요청
            $.ajax({
                url: '/WordQuiz3/quiz.nhn', // 요청할 URL
                type: 'GET',
                dataType: 'json', // 반환되는 데이터 형식
                data: {
                    action: 'checkField',
                    field: field,
                    value: value
                },
                success: function(response) {
                    if (response.exists) {
                        resultSpan.text("중복입니다. 다시 입력해주세요.").css("color", "red");
                    } else {
                        resultSpan.text("사용 가능합니다.").css("color", "green");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error: " + error);
                    resultSpan.text("오류가 발생했습니다.").css("color", "red");
                }
            });
        }
    </script>
</head>
<body>
    <!-- 메인 페이지 링크 및 안내문구 -->
    <a href="/WordQuiz3/quiz.nhn?action=mainPage">메인페이지</a>
    <h1>회원가입 페이지입니다.</h1>
    <h2>로그인 상태의 유저가 해당 페이지 진입 시 메인페이지로 리다이렉트 되어야 합니다.</h2>

    <!-- 회원가입 폼 -->
    <form action="/WordQuiz3/quiz.nhn?action=register" method="post">
        아이디: 
        <input type="text" id="id" name="id" placeholder="아이디 입력" required>
        <button type="button" onclick="checkField('id')">중복 확인</button>
        <span id="idCheckResult" style="color: red;"></span>
        <br><br>

        닉네임: 
        <input type="text" id="nickname" name="nickname" placeholder="닉네임 입력" required>
        <button type="button" onclick="checkField('nickname')">중복 확인</button>
        <span id="nicknameCheckResult" style="color: red;"></span>
        <br><br>

        비밀번호:
        <input type="password" name="password" placeholder="비밀번호 입력" required>
        <br><br>

        비밀번호 확인:
        <input type="password" name="password2" placeholder="비밀번호 재입력" required>
        <br><br>

        나이:
        <input type="number" name="age" placeholder="나이 입력" required>
        <br><br>

        <button type="submit">회원가입</button>
    </form>
</body>
</html>
