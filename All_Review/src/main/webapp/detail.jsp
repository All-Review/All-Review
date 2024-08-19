<%@page import="java.util.Collections"%>
<%@page import="post.*"%>
<%@page import="Search.*"%>
<%@page import="util.*"%>
<%@page import="user.*" %>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	PostDAO dao = new PostDAO();
	int postNum = Integer.parseInt(request.getParameter("postNum"));
	Post post = dao.readOnePost(postNum);
	
	SearchHistoryDAO searchDao = new SearchHistoryDAO();
	List<SearchHistoryAll> searchListAll = searchDao.readSearchListsAllDesc();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
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
    
    <!-- google web font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="js/content_detail.js"></script>
    <script>
    </script>
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
        <a href="<%= request.getHeader("referer") %>"><h3>게시물</h3></a>
        <div class="content_container">
            
            <div>
                <!-- profile -->
                <div class="profile_box">
                    <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                    <div>
                        <span>농담곰</span>
                        <span>nongdam_review</span>
                    </div>
                </div>
                <!-- star -->
                <div class="star">
                    <% for (int i = 0; i < (int)post.getRate(); i++) { %>
                        <img src="icons/star_colored.png">
                    <% }
                    if (post.getRate() % 1 != 0.0) { %>
                    	<img src="icons/star_half.png">
                    <% } %>
                </div>
                <!-- 글 내용 -->
                <p><%= post.getContent() %></p>
                
                <img src="<%= post.getPostUrl() %>">
                
                <div id="tag_container">
                    <div>
                        <span>#<%= post.getPostTag() %></span>
                    </div>
                    <span>2024년 5월 10일 10:00 AM</span>
                </div>

                <!-- 좋아요, 댓글, 공유 -->
                <div class="like_container">
                    <div>
                        <span>like</span><span><%= post.getLikeNum() %></span>
                    </div>
                    <div>
                        <span>comment</span><span><%= post.getCommentNum() %></span>
                    </div>
                    <div>
                        <span>share</span>
                    </div>
                </div>

                <!-- 댓글 쓰기 -->
                 <form action="" method="post" id="comment_form">
                    <img src="images/KakaoTalk_20240503_135834006.jpg">
                    <input name="comment" type="text" placeholder="댓글 쓰기" autocomplete="off">
                    <button type="button" id="comment_submit"><span>확인</span></button>
                 </form>

                <!-- 댓글영역 -->
                <div class="comment_box">
                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>

                            <div>
                                <span>농담곰</span>
                                <span>nongdams_review</span>
                                <span>3시간</span>
                            </div>
    
                            <span>도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다.</span>

                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>

                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>

                            <div>
                                <span>농담곰</span>
                                <span>nongdams_review</span>
                                <span>3시간</span>
                            </div>
    
                            <span>도움이 됩니다. 한 줄일 때는 이런 느낌 한 줄일 때는 이런 느낌 한 줄일 때는 이런 느낌</span>

                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>

                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>

                            <div>
                                <span>농담곰</span>
                                <span>nongdams_review</span>
                                <span>3시간</span>
                            </div>
    
                            <span>도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움 다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩 다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다.</span>

                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>

                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>

                            <div>
                                <span>농담곰</span>
                                <span>nongdams_review</span>
                                <span>3시간</span>
                            </div>
    
                            <span>도움이 됩니다.</span>

                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>

                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>

                            <div>
                                <span>농담곰</span>
                                <span>nongdams_review</span>
                                <span>3시간</span>
                            </div>
    
                            <span>도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다.</span>

                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>

                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>

                            <div>
                                <span>농담곰</span>
                                <span>nongdams_review</span>
                                <span>3시간</span>
                            </div>
    
                            <span>도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다.</span>

                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>

                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>

                            <div>
                                <span>농담곰</span>
                                <span>nongdams_review</span>
                                <span>3시간</span>
                            </div>
    
                            <span>도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다.</span>

                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>

                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>

                            <div>
                                <span>농담곰</span>
                                <span>nongdams_review</span>
                                <span>3시간</span>
                            </div>
    
                            <span>도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다.</span>

                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>

                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>

                            <div>
                                <span>농담곰</span>
                                <span>nongdams_review</span>
                                <span>3시간</span>
                            </div>
    
                            <span>도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다.</span>

                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>

                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>

                            <div>
                                <span>농담곰</span>
                                <span>nongdams_review</span>
                                <span>3시간</span>
                            </div>
    
                            <span>도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다.</span>

                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>

                        </div>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>

                            <div>
                                <span>농담곰</span>
                                <span>nongdams_review</span>
                                <span>3시간</span>
                            </div>
    
                            <span>도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다. 도움이 됩니다.</span>

                            <div class="comment_star">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                            </div>

                        </div>
                    </div>
                </div>
                <!-- /댓글 -->
            </div>

        </div>
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