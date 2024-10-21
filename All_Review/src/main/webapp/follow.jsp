<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="user.UserDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팔로우 페이지</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/main_content.css">
<link rel="stylesheet" href="css/sidebar.css">
<link rel="stylesheet" href="css/overlay.css">
<link rel="stylesheet" href="css/writeoverlay.css">
<link rel="stylesheet" href="css/login_2.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="js/content_detail.js"></script>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f7f7f7;
        margin: 0;
    }

    #sidebar {
        width: 200px;
        float: left;
        background: #fff;
        padding: 20px;
    }

    #content {
        margin-left: 220px;
        padding: 20px;
    }

    .user_container {
        display: flex;
        align-items: center;
        background: #fff;
        width: 70%;
        border: 1px solid #ddd;
        border-radius: 5px;
        margin-bottom: 25px;
        padding: 15px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }

    .user_container img {
        height: 50px;
        width: 50px;
        border-radius: 50%;
        margin-right: 20px;
    }

    .user_container .text {
        display: flex;
        flex-direction: column;
    }

    .user_container .text h2 {
        margin: 0;
        font-size: 20px;
        color: #333;
    }

    .follow-buttons {
        margin-left: auto;
    }

    .follow-buttons button {
        margin-right: 10px;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        background-color: #3897f0;
        color: white;
        border: none;
        border-radius: 5px;
    }
</style>
<script>
    function followUser(username) {
        $.ajax({
            url: 'followUser.jsp', 
            type: 'POST',
            data: { username: username },
            success: function(response) {
                alert('팔로우했습니다: ' + username);
               
            },
            error: function() {
                alert('팔로우 실패');
            }
        });
    }
</script>
</head>
<body>
    <!-- 왼쪽 네비게이션 바 -->
    <div id="sidebar">
        <a href="index.html"><span>All Review 올리</span></a>
        <ul>
            <li><a href="index.html">홈</a></li>
            <li><a href="search.html">검색</a></li>
            <li><a href="#">알림</a></li>
            <li><a href="#">설정</a></li>
            <li><a href="mypage.html">프로필</a></li>
            <li><a href="uploadForm.jsp">게시하기</a></li>
            <li><a href="LOGIN.html">로그인</a></li>
        </ul>
    </div>

    <div id="content">
        <h1>팔로우 추천</h1>

     
		      <div class="user_container">
		    <img src="images/<%= profileImage %>" alt="Profile Image">
		    <div class="text">
		        <h2><%= username %></h2>
		    </div>
		    <div class="follow-buttons">
		        <button onclick="followUser('<%= username %>')">Follow</button>
		    </div>
		</div>
       
    </div>
</body>
</html>
