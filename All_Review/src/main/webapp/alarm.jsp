<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="util.*"%>
<%@page import="java.util.List" %>
<%@page import="post.*"%>
<%@page import="Search.*"%>
<%@page import="alarm.*"%>
<% 
	PostDAO dao = new PostDAO();

	// 실시간 검색어
	SearchHistoryDAO searchDao = new SearchHistoryDAO();
	List<SearchHistoryAll> searchListAll = searchDao.readSearchListsAllDesc();
	
	// 알람
	AlarmDAO alarmDao = new AlarmDAO();
	List<Alarm> alarmList = alarmDao.readAllAlarms("yuns");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>올리 AllReview</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/sidebar.css">
    <link rel="stylesheet" href="css/alarm.css">
</head>
<body>
		<%
			String userID = (String) session.getAttribute("userID");	
		%>
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
        	<li><a href="alarm.jsp"><span>알림</span></a></li> <!-- href 속성 다시 설정 -->
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
        <h3>알림</h3>
        <ul id="toggle">
            <li class="check">
                <a href="searchResult.html">전체</a>
            </li>
            <li>
                <a href="searchResult.html">팔로우</a>
            </li>
        </ul>

	<% for(Alarm alarm : alarmList) { %>
		<div class="alarm_list">
            <img src="images/KakaoTalk_20240503_135834006_12.jpg">
        <% if (alarm.getAlarmType().equals("comment")) { %>
            <p class="alarm_comment"><span><%= alarm.getSenderID() %></span>님이 댓글을 남겼습니다.</p>
        <% } else if (alarm.getAlarmType().equals("like")) { %>
        	<p class="alarm_like"><span><%= alarm.getSenderID() %></span>님이 좋아요를 눌렀습니다.</p>
        <% } else { %>
        	<p class="alarm_follow"><span><%= alarm.getSenderID() %></span>님이 회원님을 팔로우하기 시작했습니다.</p>
        <% } %>
            <span>3시간</span>
        </div>
	<% } %>
    </div>
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
</body>
</html>