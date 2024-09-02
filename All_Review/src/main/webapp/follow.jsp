<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, javax.servlet.http.*, javax.servlet.*" %>

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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="js/content_detail.js"></script>
<style>
 body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #fff;
    margin: 0;
}

/* Sidebar styling */
#sidebar {
    width: 250px;
    background: #f7f7f7;
    height: 100vh;
    padding: 20px 0;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    position: fixed;
    top: 0;
    left: 0;
}

#sidebar a {
    display: block;
    color: #3b3b3b;
    text-decoration: none;
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 30px;
    text-align: center;
}

#sidebar ul {
    list-style-type: none;
    padding: 0;
    text-align: center;
}

#sidebar ul li {
    margin-bottom: 10px;
}

#sidebar ul li a {
    font-size: 16px;
    color: #3b3b3b;
    text-decoration: none;
    display: block;
    padding: 10px 0;
}

#sidebar ul li a:hover {
    color: #3897f0;
}

/* Content area */
#content {
    margin-left: 270px;
    padding: 20px;
    background: #fff;
    display: flex;
    justify-content: space-between;
}

/* User list section */
#user_list {
    width: 60%;
}

#user_list h1 {
    margin-bottom: 20px;
    font-size: 24px;
    font-weight: bold;
    color: #333;
}


#profile_section {
    width: 35%;
    padding-left: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.profile_item {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.profile_item img {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    margin-right: 20px;
}

.profile_item h2 {
    font-size: 18px;
    margin: 5px 0;
}

.profile_item p {
    font-size: 14px;
    color: #777;
    margin: 0;
}


#profile_section .follow-stats {
    display: flex;
    justify-content: space-between;
    width: 100%;
    margin-bottom: 20px;
}

#profile_section .follow-stats div {
    text-align: center;
    flex: 1;
}

#profile_section .follow-stats div h3 {
    margin: 0;
    font-size: 18px;
    font-weight: bold;
}

#profile_section .follow-stats div p {
    margin: 0;
    font-size: 14px;
    color: #888;
}

/* user_container 스타일 */
.user_container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: #f7f7f7;
    border-radius: 8px;
    margin-bottom: 10px;
    padding: 15px;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    transition: background-color 0.3s;
    max-width: 500px; /* 동일한 max-width 적용 */
    margin: 10px auto; /* 중앙 정렬 */
}

.user_container:hover {
    background-color: #f0f0f0;
}

.user_info {
    display: flex;
    align-items: center;
}

.user_info img {
    height: 60px;
    width: 60px;
    border-radius: 50%;
    margin-right: 20px;
}

.user_info .user_text {
    display: flex;
    flex-direction: column;
}

.user_info .user_text h2 {
    margin: 0;
    font-size: 18px;
    color: #333;
}

.user_info .user_text p {
    margin: 5px 0 0 0; /* 위아래 간격 추가 */
    font-size: 14px;
    color: #777;
}

/* follow-buttons 스타일 */
.follow-buttons {
    display: flex;
    align-items: center;
}

.follow-buttons button {
    padding: 8px 12px; /* 버튼 크기 조정 */
    font-size: 14px;
    cursor: pointer;
    background-color: #3897f0;
    color: white;
    border: none;
    border-radius: 4px;
    transition: background-color 0.3s;
}

.follow-buttons button:hover {
    background-color: #287bd1;
}



</style>
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
        <div id="user_list">
            <h1>팔로우 추천</h1>
                    <div id="profile_section">
            <img src="images/img-1.jpg" alt="Profile Picture">
            <h2>농담곰</h2>
            <p>배고픈 농담곰이 우울을 판다</p>
            <div class="follow-stats">
                <div>
                    <h3>120</h3>
                    <p>게시물</p>
                </div>
                <div>
                    <h3>378</h3>
                    <p>팔로워</p>
                </div>
                <div>
                    <h3>320</h3>
                    <p>팔로우</p>
                </div>
            </div>
        
        </div>