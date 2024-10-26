<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="follow.*"%>
<%@page import="java.util.List" %>
<%
	String userID = request.getParameter("userID");

	if (userID == null) {
		userID = (String) session.getAttribute("userID");
	}

	FollowDAO followDao = new FollowDAO();
	List<Follow> followingList = followDao.readAllFollowings(userID);
%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/main_content.css">
    <link rel="stylesheet" href="css/sidebar.css">
    <link rel="stylesheet" href="css/mypage.css">
    <link rel="stylesheet" href="css/follow.css">

    <!-- google web font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="js/content_detail.js"></script>
    <script src="js/image_gallery.js"></script>
    <script src="js/mypage.js"></script>
</head>

<body>

    <aside id="sidebar">
        <a href="index.jsp"><span>All Review 올리</span></a>
        <ul id="sidebarIcon">
            <li><a href="index.jsp"><span>홈</span></a></li>
            <li><a href="search.jsp"><span>검색</span></a></li>
        <% if (userID == null) { %>
            <li><a href="userLogin.jsp"><span>알림</span></a></li> <!-- href 속성 다시 설정 -->
            <li id="settingBtn"><a href="userLogin.jsp"><span>설정</span></a></li>
            <li><a href="userLogin.jsp"><span>프로필</span></a></li>
            <li><a href="userLogin.jsp"><span>게시하기</span></a></li>
         <% } else { %>
        	<li><a href="alert_page.html"><span>알림</span></a></li> <!-- href 속성 다시 설정 -->
            <li id="settingBtn"><a href="#"><span>설정</span></a></li>
            <li><a href="myPage.jsp"><span>프로필</span></a></li>
            <li><a href="writePage.jsp"><span>게시하기</span></a></li>
         <% } %>
        </ul>
        <ul id="sidebarUserIcon">
	        <%
				if(userID == null) {
			%>
            <li id="loginBtn"><a href="userLogin.jsp"><span>로그인</span></a></li>
            <li id="joinBtn"><a href="userJoin.jsp"><span>회원가입</span></a></li>
            <%
				} else {
			%>
			<li id="LogoutBtn"><a href="userLogout.jsp"><span>로그아웃</span></a></li>
			<%
				}
			%>
        </ul>
    </aside>

    <div id="content">
        <div class="profile_box">
            <img src="images/KakaoTalk_20240503_135834006_10.jpg">
            <div>
                <span>농담곰</span>
                <span><%= userID %></span>
                <span>설명 칸입니다. 안녕하세요 농담곰입니다</span>
            </div>

            <ul>
            <% if (userID != null && userID.equals((String) session.getAttribute("userID"))) { %>
                <li class="mypage_button">
                    <span>privacy setting</span>
                    <ul>
                        <li onClick="location.href='#'">탈퇴하기</li>
                        <li onClick="location.href='#'">로그아웃</li>
                    </ul>
                </li>
                <li class="mypage_button">
                    <span>setting</span>
                    <ul>
                        <li onClick="location.href='#'">프로필 수정</li>
                    </ul>
                </li>
            <% } else { %>
            	<li><button>팔로우하기</button></li>
            <% } %>
            </ul>
        </div>

        <div>
            <a href="myPage.jsp">게시물 26</a>
            <a href="follower.jsp">팔로워 312</a>
            <a href="following.jsp" class="check">팔로우 126</a>
        </div>
        
	<% for (Follow follow : followingList) { %>
		<div class="follow_list">
            <img src="images/KakaoTalk_20240503_135834006_12.jpg">
            <div>
                <a href="">테스트 닉네임</a>
                <span><%= follow.getFollower() %></span>
                <span>안녕하세요</span>
            </div>
            <button onClick="location.href='followAction.jsp'">팔로우하기</button>
        </div>
	<% } %>
    <!-- /content -->

    <div id="popular">
        <h3>실시간 검색어</h3>
        <ol>
            <li>
                <a href="">
                    <div>
                        <span>HTML</span>
                        <span>201 게시물</span>
                    </div>
                    <span>평점 3.0</span>
                </a>
            </li>
            <li>
                <a href="">
                    <div>
                        <span>광주 맛집</span>
                        <span>201 게시물</span>
                    </div>
                    <span>평점 3.0</span>
                </a>
            </li>
            <li>
                <a href="">
                    <div>
                        <span>하얀 농담곰</span>
                        <span>201 게시물</span>
                    </div>
                    <span>평점 3.0</span>
                </a>
            </li>
            <li>
                <a href="">
                    <div>
                        <span>컴퓨터</span>
                        <span>201 게시물</span>
                    </div>
                    <span>평점 3.0</span>
                </a>
            </li>
            <li>
                <a href="">
                    <div>
                        <span>데이터베이스</span>
                        <span>201 게시물</span>
                    </div>
                    <span>평점 3.0</span>
                </a>
            </li>
            <li>
                <a href="">
                    <div>
                        <span>커피</span>
                        <span>201 게시물</span>
                    </div>
                    <span>평점 3.0</span>
                </a>
            </li>
            <li>
                <a href="">
                    <div>
                        <span>인기7번</span>
                        <span>201 게시물</span>
                    </div>
                    <span>평점 3.0</span>
                </a>
            </li>
            <li>
                <a href="">
                    <div>
                        <span>인기8번</span>
                        <span>201 게시물</span>
                    </div>
                    <span>평점 3.0</span>
                </a>
            </li>
            <li>
                <a href="">
                    <div>
                        <span>인기9번</span>
                        <span>201 게시물</span>
                    </div>
                    <span>평점 3.0</span>
                </a>
            </li>
            <li>
                <a href="">
                    <div>
                        <span>인기10번</span>
                        <span>201 게시물</span>
                    </div>
                    <span>평점 3.0</span>
                </a>
            </li>
        </ol>
    </div>
    <!-- /#popular -->

</body>

</html>