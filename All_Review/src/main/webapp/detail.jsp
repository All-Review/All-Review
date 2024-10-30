<%@page import="java.util.Collections"%>
<%@page import="post.*"%>
<%@page import="Search.*"%>
<%@page import="util.*"%>
<%@page import="user.*" %>
<%@page import="comment.*" %>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, post.*, comment.*" %>
<%
    // URL 파라미터로 전달된 게시물 번호와 이미지 URL을 받음
    int postNum = Integer.parseInt(request.getParameter("postNum"));
    String imageUrl = request.getParameter("image");

    // 게시물 정보와 댓글 가져오기
    PostDAO postDAO = new PostDAO();
    Post post = postDAO.readOnePost(postNum);

    PostCommentDAO commentDao = new PostCommentDAO();
    List<PostComment> commentList = commentDao.readAllPostComments(postNum);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시물 상세 페이지</title>
    <link rel="stylesheet" href="css/detail.css">
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/main_content.css">
    <link rel="stylesheet" href="css/sidebar.css">
    <link rel="stylesheet" href="css/overlay.css">
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
    <div class="detail-container">
        <!-- 이미지 출력 -->
        <div class="image-container">
            <img src="<%= imageUrl %>" alt="게시물 이미지" />
        </div>

        <!-- 게시물 정보 출력 -->
        <div class="post-content">
            <h2>게시물 내용</h2>
            <p><%= post.getPostContent() %></p>
            <p><strong>태그:</strong> <%= post.getPostTag() %></p>
            <p><strong>평점:</strong> ⭐️ <%= post.getPostRate() %> / 5</p>
        </div>

        <!-- 댓글 리스트 -->
        <div class="comment-section">
            <h3>댓글</h3>
            <ul>
                <% for (PostComment comment : commentList) { %>
                    <li>
                        <span><strong><%= comment.getNickname() %></strong></span>
                        <p><%= comment.getCommentContent() %></p>
                        <small><%= comment.getCommentCreateAt() %></small>
                    </li>
                <% } %>
            </ul>

            <!-- 댓글 작성 폼 -->
            <form action="createComment.jsp" method="post">
                <input type="hidden" name="postNum" value="<%= postNum %>" />
                <textarea name="comment" placeholder="댓글을 작성하세요" required></textarea>
                <button type="submit">댓글 작성</button>
            </form>
        </div>
    </div>
</body>
</html>
