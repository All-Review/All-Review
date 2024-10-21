<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
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
		HttpSession session1 = request.getSession();
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

    <!-- 중앙 컨텐츠 -->
    <div id="content">
        <ul id="toggle">
            <li>추천</li>
            <li>팔로우</li>
        </ul>

        <div class="content_container">
            <a href="detail.jsp?postNum=37">
                <img src="images/15fd24a290e3154d44f486b0720b0692_res.jpeg">
            </a>
            <div>
                <!-- profile -->
                <div class="profile_box">
                    <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                    <div>
                        <span>농담곰</span>
                        <span>nongdam_review</span>
                    </div>
                    <span>3시간</span>
                </div>
                <!-- star -->
                <div class="star">
                    <img src="icons/star_colored.png">
                    <img src="icons/star_colored.png">
                    <img src="icons/star_colored.png">
                    <img src="icons/star_colored.png">
                    <img src="icons/star_half.png">
                </div>
                <!-- 글 내용 -->
                <p>안녕하세요. 농담곰입니다. 리뷰를해보겠습니다.안녕하세요. 농담곰입니다. 리뷰를해보겠습니다.안녕하세요. 농담곰입니다. 리뷰를해보겠습니다</p>
                <!-- 좋아요, 댓글, 공유 -->
                <div class="like_container">
                    <div>
                        <span>like</span><span>31</span>
                    </div>
                    <div>
                        <span>comment</span><span>8</span>
                    </div>
                    <div>
                        <span>share</span>
                    </div>
                </div>

                <!-- 댓글영역 -->
                <div class="comment_box">
                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>
                            <span>농담곰</span>
                            <span>도움이 됩니다.</span>
                        </div>

                        <div>
                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>
                            <span>3시간</span>
                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>
                            <span>농담곰</span>
                            <span>도움이 됩니다.재미</span>
                        </div>
                        
                        <div>
                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>
                            <span>3시간</span>
                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>
                            <span>농담곰</span>
                            <span>도움이 됩니다.도움이</span>
                        </div>
                        
                        <div>
                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>
                            <span>3시간</span>
                        </div>
                    </div>

                    <span>댓글 8개 모두 보기</span>
                </div>
                <!-- /댓글 -->
            </div>

        </div>
        <!-- /content_container -->

        <div class="content_container">
            <img src="images/KakaoTalk_20240503_135834006.jpg">
            <div>
                <!-- profile -->
                <div class="profile_box">
                    <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                    <div>
                        <span>농담곰</span>
                        <span>nongdam_review</span>
                    </div>
                    <span>3시간</span>
                </div>
                <!-- star -->
                <div class="star">
                    <img src="icons/star_colored.png">
                    <img src="icons/star_colored.png">
                    <img src="icons/star_colored.png">
                    <img src="icons/star_gray.png">
                    <img src="icons/star_gray.png">
                </div>
                <!-- 글 내용 -->
                <p>안녕하세요. 농담곰입니다. 리뷰를해보겠습니다.안녕하세요. 농담곰입니다. 리뷰를해보겠습니다.안녕하세요. 농담곰입니다. 리뷰를해보겠습니다</p>
                <!-- 좋아요, 댓글, 공유 -->
                <div class="like_container">
                    <div>
                        <span>like</span>
                    </div>
                    <div>
                        <span>comment</span>
                    </div>
                    <div>
                        <span>share</span>
                    </div>
                </div>

                <!-- 댓글영역 -->
                <div class="comment_box">
                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>
                            <span>농담곰</span>
                            <span>도움이 됩니다.</span>
                        </div>

                        <div>
                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>
                            <span>3시간</span>
                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>
                            <span>농담곰</span>
                            <span>도움이 됩니다.재미</span>
                        </div>

                        <div>
                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>
                            <span>3시간</span>
                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>
                            <span>농담곰</span>
                            <span>도움이 됩니다.도움이</span>
                        </div>

                        <div>
                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>
                            <span>3시간</span>
                        </div>
                    </div>

                    <span>댓글 8개 모두 보기</span>
                </div>
                <!-- /댓글 -->
            </div>

        </div>
        <!-- /content_container -->

        <div class="content_container">
            <img src="images/15fd24a290e3154d44f486b0720b0692_res.jpeg">
            <div>
                <!-- profile -->
                <div class="profile_box">
                    <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                    <div>
                        <span>농담곰</span>
                        <span>nongdam_review</span>
                    </div>
                    <span>3시간</span>
                </div>
                <!-- star -->
                <div class="star">
                    <img src="icons/star_colored.png">
                    <img src="icons/star_colored.png">
                    <img src="icons/star_half.png">
                    <img src="icons/star_gray.png">
                    <img src="icons/star_gray.png">
                </div>
                <!-- 글 내용 -->
                <p>안녕하세요. 농담곰입니다. 리뷰를해보겠습니다.안녕하세요. 농담곰입니다. 리뷰를해보겠습니다.안녕하세요. 농담곰입니다. 리뷰를해보겠습니다</p>
                <!-- 좋아요, 댓글, 공유 -->
                <div class="like_container">
                    <div>
                        <span>like</span>
                    </div>
                    <div>
                        <span>comment</span>
                    </div>
                    <div>
                        <span>share</span>
                    </div>
                </div>

                <!-- 댓글영역 -->
                <div class="comment_box">
                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>
                            <span>농담곰</span>
                            <span>도움이 됩니다.</span>
                        </div>

                        <div>
                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>
                            <span>3시간</span>
                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>
                            <span>농담곰</span>
                            <span>도움이 됩니다.재미</span>
                        </div>

                        <div>
                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>
                            <span>3시간</span>
                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>
                            <span>농담곰</span>
                            <span>도움이 됩니다.도움이</span>
                        </div>

                        <div>
                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>
                            <span>3시간</span>
                        </div>
                    </div>

                    <span>댓글 8개 모두 보기</span>
                </div>
                <!-- /댓글 -->
            </div>

        </div>
        <!-- /content_container -->

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
</body>

</html>