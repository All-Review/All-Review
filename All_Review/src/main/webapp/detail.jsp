<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="like.*"%>
<%@page import="java.util.Collections"%>
<%@page import="post.*"%>
<%@page import="Search.*"%>
<%@page import="util.*"%>
<%@page import="user.*" %>
<%@page import="comment.*" %>
<%@page import="java.util.List" %>
<%
    String imageName = request.getParameter("name");
	PostDAO postDAO = new PostDAO();
	List<Post> posts = postDAO.readAllPosts();
	List<String> images;
	String postNumStr = request.getParameter("postNum");
	int postNum = 0; 
	Post post = postDAO.readOnePost(postNum);

   // 세션에서 사용자 ID 가져오기
   String user_id = (String) session.getAttribute("user_id");

   
   // 댓글 
   PostCommentDAO commentDao = new PostCommentDAO();

   SearchHistoryDAO searchDao = new SearchHistoryDAO();
   List<SearchHistoryAll> searchListAll = searchDao.readSearchListsAllDesc();
   // 댓글 작성 요청 처리
  
   if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("comment") != null) {
       String commentContent = request.getParameter("comment");
       int postNumParam = Integer.parseInt(request.getParameter("postNum"));
   }




%>
<html>
<head>
<meta charset="UTF-8">
    <title><%= imageName %></title>
       
    
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/main_content.css">
    <link rel="stylesheet" href="css/sidebar.css">
    <link rel="stylesheet" href="css/overlay.css">
    <link rel="stylesheet" href="css/detail.css">
    <link rel="stylesheet" href="css/setting.css">
    <link rel="stylesheet" href="css/image_gallery.css">
    <link rel="stylesheet" href="css/search.css">
    <link rel="stylesheet" href="css/displaySize.css">
    <link rel="stylesheet" href="css/alert.css">
</head>
<body>
		<%
			String userID = (String) session.getAttribute("userID");
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
			<li id="LogoutBtn"><a href="userLogout.jsp"><span>로그아웃</span></a></li>
			<%
				}
			%>
        </ul>
    </aside>
    <h1><%= imageName %></h1>
    <img src="path/to/your/images/<%= imageName %>.jpg" alt="<%= imageName %>"/> <!-- 이미지 경로 수정 필요 -->
    <p>여기에 해당 이미지에 대한 추가 정보를 넣을 수 있습니다.</p>
    <button onclick="window.close();">창 닫기</button>
</body>
</html>