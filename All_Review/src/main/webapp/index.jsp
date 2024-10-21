<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="user.UserDAO" %>
<%@ page import="post.Post" %>
<%@ page import="post.PostDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>게시물</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/main_content.css">
    <link rel="stylesheet" href="css/sidebar.css">
    <link rel="stylesheet" href="css/overlay.css">
    <link rel="stylesheet" href="css/setting.css">
    <link rel="stylesheet" href="css/displaySize.css">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="js/content_detail.js"></script>
    <script src="js/setting.js"></script>

    <script>
        function showSlide(sliderId, index) {
            const slides = document.querySelectorAll(#${sliderId} img);
            index = (index + slides.length) % slides.length;
            slides.forEach((slide, i) => {
                slide.style.display = (i === index) ? 'block' : 'none';
            });
            return index;
        }

        const slideIndices = {};

        function nextSlide(postId) {
            if (!slideIndices[postId]) {
                slideIndices[postId] = 0;
            }
            slideIndices[postId]++;
            const sliderId = slider-${postId};
            slideIndices[postId] = showSlide(sliderId, slideIndices[postId]);
        }

        function prevSlide(postId) {
            if (!slideIndices[postId]) {
                slideIndices[postId] = 0;
            }
            slideIndices[postId]--;
            const sliderId = slider-${postId};
            slideIndices[postId] = showSlide(sliderId, slideIndices[postId]);
        }

        document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('.slider').forEach(slider => {
                const sliderId = slider.id;
                slideIndices[sliderId.split('-')[1]] = 0;
                showSlide(sliderId, 0);
            });
        });
        
        function deletePost(postId) {
            if (confirm('게시물을 삭제하시겠습니까?')) {
                window.location.href = deletePost.jsp?postId=${postId}; // 삭제 요청 페이지로 이동
            }
        }
    </script>

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        #content {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            max-width: 800px;
            margin: auto;
        }
        .post {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            padding: 10px;
            width: 100%;
            overflow: hidden;
            position: relative;
        }
        .slider-container {
            position: relative;
            overflow: hidden;
            width: 100%;
            height: 300px; /* 원하는 높이로 조정 */
        }
        .slider {
            display: flex;
            transition: transform 0.5s ease;
        }
        .slider img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            object-fit: cover; 
            flex: 0 0 auto; 
            margin-right: 10px; 
        }
			.controls {
			    display: flex;
			    justify-content: center; 
			    margin-top: 10px;
			}
			
			.controls button {
			    background-color: #007bff;
			    color: white;
			    border: none;
			    border-radius: 5px;
			    padding: 10px 15px;
			    cursor: pointer;
			    transition: background-color 0.3s;
			    margin: 0 5px; 
			}
			
			.controls button:hover {
			    background-color: #0056b3;
			}
        #popular {
            margin-top: 40px;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 100%;
        }
        #popular h3 {
            margin-bottom: 10px;
        }
        #popular ol {
            list-style: none;
            padding: 0;
        }
        #popular li {
            margin-bottom: 10px;
        }
        #popular a {
            text-decoration: none;
            color: #333;
        }
        #setting_container {
            display: none; /* 기본적으로 숨김 */
        }
        #settingBox {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            z-index: 1000;
        }
        .close {
            background: #ff4c4c;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .close:hover {
            background: #ff1a1a;
        }
    </style>
</head>

<body>
    <%
        HttpSession session1 = request.getSession();
        String user_id = (String) session.getAttribute("user_id");
    %>
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
                if(user_id == null) {
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
        <%
            PostDAO postDAO = new PostDAO();
            List<Post> posts = postDAO.readAllPosts();
            for (Post post : posts) {
                List<String> images = postDAO.splitImages(post.getImagePath());
        %>
        <div class="post">
		    <h3><%= post.getPostTag() %></h3>
		    <div class="slider-container">
		        <div class="slider" id="slider-<%= post.getPostID() %>">
		            <% for (String image : images) { %>
		                <img src="<%= image %>" alt="이미지">
		            <% } %>
		        </div>
		    </div>
		    <div class="controls">
		        <button onclick="prevSlide(<%= post.getPostID() %>)">이전</button>
		        <button onclick="nextSlide(<%= post.getPostID() %>)">다음</button>
		        <button onclick="deletePost(<%= post.getPostID() %>)">삭제</button>
		    </div>
		    <p>⭐️<%= post.getPostRate() %> / 5</p>
		    <p><%= post.getPostContent() %></p>
		</div>
        <% } %>
        
       
    </div>
</body>

</html>