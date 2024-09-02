<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<%
    String userID = (String) session.getAttribute("userID");
    Connection conn = null;
    Statement stmt = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdatabase", "username", "password");
        stmt = conn.createStatement();
        resultSet = stmt.executeQuery("SELECT id, image_path, caption, title, rating FROM posts");

%>

    <aside id="sidebar">
        <a href="index.jsp"><span>All Review 올리</span></a>
        <ul id="sidebarIcon">
            <li><a href="index.jsp"><span>홈</span></a></li>
            <li><a href="search.jsp"><span>검색</span></a></li>
            <li><a href="alert_page.html"><span>알림</span></a></li> <!-- href 속성 다시 설정 -->
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

    <!-- 중앙 컨텐츠 -->
<div id="content">
    <ul>
        <%
            while (resultSet != null && resultSet.next()) {
                int postId = resultSet.getInt("id"); 
                String imagePath = resultSet.getString("image_path");
                String caption = resultSet.getString("caption");
                String title = resultSet.getString("title");
                int rating = resultSet.getInt("rating"); // 별점 데이터 가져오기
        %>
        <li class="content_container" data-post-id="<%= postId %>">
            <img src="upload/<%= imagePath %>" alt="이미지">
            <div class="text">
                <h2><%= title %></h2>
                <p class="caption"><%= caption %></p>
                <!-- 별점 표시 영역 -->
                <div class="rating">
                    <%
                        for (int i = 1; i <= 5; i++) {
                            if (i <= rating) {
                    %>
                        <span class="star filled">★</span>
                    <%
                            } else {
                    %>
                        <span class="star">☆</span>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
            <button class="delete-btn">x</button>
        </li>
        <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error processing result set: " + e.getMessage());
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("Error closing resources: " + e.getMessage());
            }
        }
        %>
    </ul>
</div>
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
    
    <div id="setting_container">
        <div id="settingBox">
            <h1><span>설정</span><p>설정</p></h1>
            <button class="close"><span>닫기</span></button>

            <div id="setBox">
                <div id="switchBox">
                    <label>
                        <span>알람</span>
                        <input id="alertSwitch" role="switch" type="checkbox"/>
                    </label>
                </div>
            </div>

        </div>
    </div>
    
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const captions = document.querySelectorAll(".caption");
            captions.forEach(caption => {
                if (caption.innerText.length > 20) {
                    caption.innerText = caption.innerText.substring(0, 10) + "...";
                }
            });

            document.querySelectorAll(".delete-btn").forEach(button => {
                button.addEventListener("click", function() {
                    const postId = this.closest(".content_container").getAttribute("data-post-id");
                    if (confirm("정말 삭제하시겠습니까?")) {
                    	fetch(`/deletePost.jsp ? id=${postId}`, { method: "DELETE" })
                        .then(response => response.text())
                        .then(data => {
                            console.log(data);  
                            if (data.trim() === "success") {
                                alert("게시글이 성공적으로 삭제되었습니다.");
                                this.closest(".content_container").remove();
                            } else {
                                alert("삭제 실패. 다시 시도해주세요.");
                            }
                        })
                        .catch(error => {
                            console.error("Error:", error);
                            alert("서버와의 연결에 실패했습니다.");
                        });

                    }
                });
            });
        });
    </script>
</body>
</html>
</body>



</html>