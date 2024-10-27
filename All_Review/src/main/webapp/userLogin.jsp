
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>ing</title>
        <link rel="stylesheet" href="css/reset.css">
        <link rel="stylesheet" href="css/loginPage.css"> <!-- 로그인 css -->

        <script src="https://code.jquery.com/jquery.min.js"></script>

        <script src="js/1234.js"></script> <!-- 임시용 -->

    </head>

    <body>
        <div id="login_container">
            <div id="mainBox">
                <a href="index.jsp"><span>Log in</span></a>

                <form method="post" action="./userLoginAction.jsp" id="loginBox">
                    <input type="text" name="userID" id="id" class="account" placeholder="아이디">
                    <input type="password" name="userPassword" id="password" class="account" placeholder="비밀번호">
                    <label><input type="checkbox" id="checkbox" class="account"><span>로그인 정보 저장</span></label>
                    <button type="submit" id="LogIn" class="account">로그인</button>
                </form>

                    <div id="accountBox">
                        <h5 id="find_account"><a href="#find">아이디/비밀번호 찾기</a></h5>

                        <h5 id="create_account"><a href="userJoin.jsp">회원가입</a></h5>
                    </div>

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
