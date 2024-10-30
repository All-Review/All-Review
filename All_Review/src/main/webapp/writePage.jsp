<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>upload</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/writePage.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/setting.css">
    <link rel="stylesheet" href="css/sidebar.css">
	<link rel="stylesheet" href="css/displaySize.css">

    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="js/writePage.js"></script>
    <script src="js/setting.js"></script>
    <script>
    </script>
</head>
<body>
    	<%
	    	String userID = request.getParameter("userID");
	    	
	    	if (userID == null) {
	    		userID = (String) session.getAttribute("userID");
	    	}
	    	
	    	UserDAO userDAO = new UserDAO();
	    	
	    	UserDTO user = userDAO.getUser(userID);
		%>
    <!-- 왼쪽 네비게이션 바 -->
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

    <!-- 중앙 컨텐츠 -->
    <div id="content">
	    <form action="uploadAction.jsp" method="post" enctype="multipart/form-data">
	        <div id="post_form">
	            <div id="image_preview">
	                <img id="preview" />
	            </div>
	            <div class="form-group">
	                <label for="title">제목</label>
	                <input type="text" name="title" id="title" placeholder=" 제목" />
	            </div>
	            <div class="form-group">
	                <label for="image">이미지 업로드</label>
	                <input type="file" name="file" id="image" accept="image/*" onchange="handleChange(event)" />
	            </div>
	            <div class="form-group">
	                <label for="caption">설명</label>
	                <textarea name="caption" id="caption" placeholder="설명을 입력"></textarea>
	            </div>
	            <div class="button-group">
	                <input type="submit" value="업로드" id="submitButton">
	                <button id="closeButton" type="button">닫기</button>
	            </div>
	        </div>
	    </form>
    </div>
    <!-- /content -->

    <div id="popular">
    </div>
</body>
</body>
</html>
