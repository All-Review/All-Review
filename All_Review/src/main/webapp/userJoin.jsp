<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>title</title>
        <link rel="stylesheet" href="css/reset.css">
        <link rel="stylesheet" href="css/joinPage.css"> <!-- 회원가입 박스 css -->

        <script src="https://code.jquery.com/jquery.min.js"></script>

        <script src="js/1234.js"></script> <!-- 임시용 -->
        <script src="js/pwmatch.js"></script>

    </head>

    <body>
        <div id="join_container">
            <div id="join_mainBox">
                <a href="index.jsp"><span>user join</span></a>

                <form method="post" action="./userRegisterAction.jsp" id="joinBox">
                    <input type="text" name="userID" id="id" class="account" placeholder="아이디">
                    <input type="text" name="userName" id="name" class="account" placeholder="이름">
                    <input type="text" name="userNickname" id="nickname" class="account" placeholder="닉네임">
                    <input type="password" name="userPassword" id="password" class="account" placeholder="비밀번호">
                    <input type="password" id="confirm_password" class="account" placeholder="비밀번호 재확인">
                    <input type="text" name="userEmail" id="email" class="account" placeholder="이메일">
                    <span id="passwordMatchMessage" style="color:red;"></span>
                    <button type="submit" id="userJoin" class="account">회원가입</button>
                </form>

                <div id="link_account">
                    <ul>
                        <li><a href="#"><span>google</span></a></li>
                        <li><a href="#"><span>naver</span></a></li>
                        <li><a href="#"><span>kakaotalk</span></a></li>
                    </ul>
                </div>
            </div>
        </div>

    </body>
</html>