
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
	    <form id="post_form" action="uploadAction.jsp" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" required>
        </div>
        <div class="form-group">
            <label for="caption">설명</label>
            <textarea id="caption" name="caption" rows="3" required></textarea>
        </div>
        <div class="form-group">
            <label for="rating">별점</label>
            <input type="number" id="rating" name="rating" min="1" max="5" required>
        </div>
        <div class="form-group">
            <label for="images">이미지 업로드</label>
            <input type="file" id="images" name="files" accept="image/*" multiple required>
        </div>
        <div id="image_preview">이미지 미리보기</div>
        <div class="button-group">
            <button type="submit" id="submitButton">업로드</button>
        </div>
    </form>
    </div>
    <!-- /content -->

    <div id="popular">
    </div>
</body>
</html>

