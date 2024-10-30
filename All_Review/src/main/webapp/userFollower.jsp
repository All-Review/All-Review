<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="post.*"%>
<%@page import="user.*" %>
<%@page import="Search.*"%>
<%@page import="user.*" %>
<%@page import="follow.*"%>
<%@page import="alarm.*"%>
<%@page import="java.util.List" %>
<%
	String otherUserID = request.getParameter("otherUserID");
	String userID = request.getParameter("userID");
	
	if (userID == null) {
		userID = (String) session.getAttribute("userID");
	}
	
	UserDAO userDAO = new UserDAO();
	
	UserDTO user = userDAO.getUser(userID);
	
	// 유저 정보
	UserDAO userDAO = new UserDAO();
	UserDTO otherUser = userDAO.getUser(otherUserID);
	
	PostDAO dao = new PostDAO();
	List<Post> postList = dao.readAllPostsByUser(otherUserID);

	// 실시간 검색어
	SearchHistoryDAO searchDAO = new SearchHistoryDAO();
	List<SearchHistory> searchList = searchDAO.readSearchLists();
	List<SearchHistoryAll> searchListAll = searchDAO.readSearchListsAllDesc();

	// 팔로우
	FollowDAO followDao = new FollowDAO();
	
	List<Follow> followerList = null;
	if (otherUserID == null) {
		followerList = followDao.readAllFollowers(userID);
	} else {
		followerList = followDao.readAllFollowers(otherUserID);
	}
	
	// 알림
	AlarmDAO alarmDAO = new AlarmDAO();
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
            <li><a href="userLogin.jsp"><span>알림</span></a></li>
            <li id="settingBtn"><a href="userLogin.jsp"><span>설정</span></a></li>
            <li><a href="userLogin.jsp"><span>프로필</span></a></li>
            <li><a href="userLogin.jsp"><span>게시하기</span></a></li>
         <% } else { %>
        	<% if (alarmDAO.getAlarmNum(userID) == 0) { %>
         		<li><a href="alarm.jsp"><span>알림</span></a></li>
         	<% } else { %>
         		<li><a href="alarm.jsp"><span>알림</span><span id="alarm_num"><%= alarmDAO.getAlarmNum(userID) %></span></a></li>
         	<% } %>
            <li id="settingBtn"><a href="#"><span>설정</span></a></li>
            <li><a href="#"><span>프로필</span></a></li>
            <li><a href="writePage.jsp"><span>게시하기</span></a></li>
        </ul>
        <ul id="sidebarUserIcon">

        <%
            if (userID == null) {
        %>
            <li id="loginBtn"><a href="userLogin.jsp"><span>로그인</span></a></li>
            <li id="joinBtn"><a href="userJoin.jsp"><span>회원가입</span></a></li>
        <%
				} else {
			%>
			<li>
				<div id="sidebarUserProfile">
	                <img src="<%= request.getContextPath() + "/uploadsProfileimage/" + user.getUserProfileImage() %>" alt="Profile Image" />
	                <div>
	                    <span><%= user.getUserNickname() %></span>
                		<span><%= user.getUserID() %></span>
	                </div>     
	            </div>
            </li>
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
                <span><%= otherUser.getUserNickname() %></span>
                <span><%= otherUserID %></span>
                <span><%= otherUser.getUserIntroduce() %></span>
            </div>

            <ul>
            	<% if (followDao.isFollowing(userID, otherUserID)) { %>
            		<li><button onClick="location.href='deleteFollowing.jsp?otherUserID=<%= otherUserID %>'" class="following">팔로우 중</button></li>
            	<% } else if (userID == null) { %>
            		<li><button onClick="location.href='userLogin.jsp'">팔로우하기</button></li>
            	<% } else { %>
            		<li><button onClick="location.href='followAction.jsp?otherUserID=<%= otherUserID %>'">팔로우하기</button></li>
            	<% } %>
            </ul>
        </div>

        <div>
            <a href="userMyPage.jsp?otherUserID=<%= otherUserID %>">게시물 26</a>
            <a href="userFollower.jsp?otherUserID=<%= otherUserID %>" class="check">팔로워 <%= followDao.getFollowerNum(otherUserID) %></a>
            <a href="userFollowing.jsp?otherUserID=<%= otherUserID %>">팔로우 <%= followDao.getFollowingNum(otherUserID) %></a>
        </div>
        
	<% for (Follow follow : followerList) {
		// 다른 유저 정보
		UserDTO otherUserFollow = userDAO.getUser(follow.getFollower());%>
		<div class="follow_list">
            <img src=<%= otherUserFollow.getUserProfileImage() %>>
            <div>
            <% if (!follow.getFollower().equals(userID)) { %>
                <a href="userMyPage.jsp?otherUserID=<%= follow.getFollower() %>"><%= otherUserFollow.getUserNickname() %></a>
            <% } else { %>
            	<a href="myPage.jsp"><%= otherUserFollow.getUserNickname() %></a>
            <% } %>
                <span><%= follow.getFollower() %></span>
                <span>안녕하세요</span>
            </div>
            <% if (!follow.getFollower().equals(userID)) { %>
                <% if (followDao.isFollowing(userID, follow.getFollower())) { %>
            		<button onClick="location.href='deleteFollowing.jsp?otherUserID=<%= follow.getFollower() %>'" class="following">팔로우 중</button>
            	<% }  else { %>
            		<button onClick="location.href='followAction.jsp?otherUserID=<%= follow.getFollower() %>'">팔로우하기</button>
            	<% } %>
            <% } %>
        </div>
	<% } %>
    <!-- /content -->

    <div id="popular">
        <h3>실시간 검색어</h3>
        <ol>
        <% for (int i = 0; i < searchListAll.size() && i <= 10; i++) {
        	List<Post> tagList = dao.readSearchedPosts(searchListAll.get(i).getSearchWord());
        	if (tagList.size() == 0) {
        		continue;
        	} else {
        %>
            <li>
                <a href="searchResult.jsp?search=<%= searchListAll.get(i).getSearchWord() %>">
                    <div>
                        <span><%= searchListAll.get(i).getSearchWord() %></span>
                        <span><%= tagList.size() %> 게시물</span>
                    </div>
                    <% if (tagList.size() == 0) { %>
                    <span>평점 0</span>
                    <% } else { %>
                    <span>평점 <%= String.format("%.2f", dao.getAverageRate(tagList)) %></span>
                    <% } %>
                </a>
            </li>
         <% 
         
        		}  // --else
        }  //  --for %>
        </ol>
    </div>
    <!-- /#popular -->

</body>

</html>