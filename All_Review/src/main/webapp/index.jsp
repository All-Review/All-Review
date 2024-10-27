<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, util.DatabaseUtil" %>
<%@page import="post.*"%>
<%@page import="Search.*"%>
<%@page import="util.*"%>
<%@page import="user.*" %>
<%@page import="comment.*" %>
<%@page import="like.*"%>
<%@page import="java.util.Collections"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="Search.SearchHistoryDAO" %>
<%@ page import="Search.SearchHistoryAll" %>

<%

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
	List<PostComment> commentList = commentDao.readAllPostComments(postNum);
    // 실시간 검색어 가져오기
    SearchHistoryDAO searchDao = new SearchHistoryDAO();
    List<SearchHistoryAll> searchListAll = searchDao.readSearchListsAllDesc();
    // 댓글 작성 요청 처리
   
    if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("comment") != null) {
        String commentContent = request.getParameter("comment");
        int postNumParam = Integer.parseInt(request.getParameter("postNum"));
    }
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
    <link rel="stylesheet" href="css/overlay.css">
    <link rel="stylesheet" href="css/setting.css">
    <link rel="stylesheet" href="css/mainpost.css">
    <link rel="stylesheet" href="css/displaySize.css">
    <!-- google web font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="js/content_detail.js"></script>
    <script src="js/setting.js"></script>
    <script>
    </script>
</head>

<body>
<%	String userID = (String) session.getAttribute("userID");		%>
    <!-- 왼쪽 네비게이션 바 -->
    <aside id="sidebar">
        <a href="index.jsp"><span>All Review 올리</span></a>
        <ul id="sidebarIcon">
            <li><a href="index.jsp"><span>홈</span></a></li>
            <li><a href="search.jsp"><span>검색</span></a></li>
            <li><a href="alert_page.html"><span>알림</span></a></li> 
            <li id="settingBtn"><a href="#"><span>설정</span></a></li>
            <li><a href="#"><span>프로필</span></a></li>
            <li><a href="writePage.jsp"><span>게시하기</span></a></li>
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

    <!-- 게시물 컨텐츠 -->
 <div id="content">
 	<div class="post-container">
 		 <div class="image-container">
	        <% for (Post p : posts) { %>
	            <%
	                images = postDAO.splitImages(p.getPostImgUrl());
	            %>
	            </div>
         <div class="post">
            <div class="post-header">
           		<div class="post-info">
	                <img src="images/user_profile.png" alt="프로필 이미지">
	                 <span class="nickname"><%= p.getPostTag() %></span>
	                      <span>·</span>
	              		  <span>⭐️ <%= p.getPostRate() %> / 5</span>
	            </div>
            </div>
                <div class="slider-container">
                    <div class="slider" id="slider-<%= p.getPostNum() %>">
                        <% for (String image : images) { %>
                        <img src="<%= image %>" 
                             alt="이미지" 
                             style="cursor: pointer;" 
                             onclick="window.open('detail.jsp?name=<%= p.getPostContent() %>', '_blank')"/>
                    <% } %>
                    </div>
                </div>
                <p><%= p.getPostContent() %></p>
                
                <div class="post-footer">
                <div class="icon">
                    <img src="images/like_icon.png" alt="좋아요">
                    
                </div>
                <div class="icon">
                    <img src="images/comment_icon.png" alt="댓글">
                    <span><%= commentList.size() %></span>
                </div>
            </div>
          </div>
       
 	 		<div class="comment-section">
                <form action="index.jsp?postNum=<%= p.getPostNum() %>" method="post" id="comment_form">
                    <img src="<%= (userID == null) ? "images/user_default_profile.png" : "images/KakaoTalk_20240503_135834006.jpg" %>" />
                    <input name="comment" type="text" placeholder="댓글 쓰기" autocomplete="off" required>
                    <button type="submit" id="comment_submit">확인</button>
                </form>

                <div class="comment_box">
                    <% for (PostComment comment : commentList) { %>
                        <div class="profile_box">
                            <a href="myPage.jsp?userID=<%= comment.getUserId() %>">
                                <img src="<%= comment.getUserProfileImage() %>" />
                            </a>
                            <div>
                                <a href="myPage.jsp?userID=<%= comment.getUserId() %>">
                                    <span><%= comment.getNickname() %></span>
                                </a>
                               <div>
                            <div>
                                <span class="nickname"><%= comment.getNickname() %></span>
                                <span><%= comment.getUserId() %></span>
                                <span>·</span>
                                <span><%= comment.getCommentCreateAt() %></span>
                            </div>
                            <span><%= comment.getCommentContent() %></span>

                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
           </div>
        <% } %>
    </div>
</div>
    <script>
        const slideIndices = {};

        function showSlide(sliderId, index) {
            const slides = document.querySelectorAll(`#${sliderId} img`);
            index = (index + slides.length) % slides.length;
            slides.forEach((slide, i) => slide.style.display = i === index ? 'block' : 'none');
            return index;
        }

        function openImagePage(imageName) {
            window.open("ditail.jsp?name=" + imageName, "_blank");
        }

        function nextSlide(postId) {
            slideIndices[postId] = (slideIndices[postId] || 0) + 1;
            showSlide(`slider-${postId}`, slideIndices[postId]);
        }

        function prevSlide(postId) {
            slideIndices[postId] = (slideIndices[postId] || 0) - 1;
            showSlide(`slider-${postId}`, slideIndices[postId]);
        }

        function deletePost(postId) {
            if (confirm('게시물을 삭제하시겠습니까?')) {
                window.location.href = `deletePost.jsp?postNum=${postId}`;
            }
        }

        document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('.slider').forEach(slider => {
                const postId = slider.id.split('-')[1];
                slideIndices[postId] = 0;
                showSlide(slider.id, 0);
            });
        });
    </script>
</body>
</html>
