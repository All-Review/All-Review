<%@page import="java.util.Collections"%>
<%@page import="post.*"%>
<%@page import="Search.*"%>
<%@page import="util.*"%>
<%@page import="user.*" %>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	request.setCharacterEncoding("UTF-8");
	
	String searchWord = request.getParameter("search");
	
	PostDAO dao = new PostDAO();
	List<Post> postList = dao.readSearchedPosts(searchWord);

	SearchHistory sh = new SearchHistory();
	SearchHistoryDAO searchDao = new SearchHistoryDAO();
	
	int result = searchDao.createSearchHistory(searchWord);
	
	// 전체 검색 리스트에서 검색한적 없으면 등록, 아니면 숫자 증가
	List<SearchHistoryAll> searchedList = searchDao.readOneSearchHistoryAll(searchWord);
	if (searchedList.size() == 0) {
		int result2 = searchDao.createSearchHistoryAll(searchWord);
	} else {
		searchDao.updateSearchNum(searchWord, searchedList.get(0).getSearchNum());
	}
	
	List<SearchHistory> searchList = searchDao.readSearchLists();
	List<SearchHistoryAll> searchListAll = searchDao.readSearchListsAllDesc();
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
    <link rel="stylesheet" href="css/image_gallery.css">
    <link rel="stylesheet" href="css/search.css">
    <link rel="stylesheet" href="css/overlay.css">
    <link rel="stylesheet" href="css/setting.css">

    <!-- google web font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="js/content_detail.js"></script>
    <script src="js/image_gallery.js"></script>
    <script src="js/search.js"></script>
    <script src="js/setting.js"></script>
</head>

<body>
		<%
			String user_id = (String) session.getAttribute("user_id");	
		%>
    <!-- 글 상세 (오버레이 레이어) -->
    <div id="content_detail">
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
                <div class="star">*****</div>
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
                        <span>3시간</span>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>
                            <span>농담곰</span>
                            <span>도움이 됩니다.재미</span>
                        </div>
                        <span>3시간</span>
                    </div>

                    <div class="profile_box">
                        <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                        <div>
                            <span>농담곰</span>
                            <span>도움이 됩니다.도움이</span>
                        </div>
                        <span>3시간</span>
                    </div>

                    <span>댓글 8개 모두 보기</span>
                </div>
                <!-- /댓글 -->
            </div>
        </div>
    </div>

    <aside id="sidebar">
        <a href="index.jsp"><span>All Review 올리</span></a>
        <ul id="sidebarIcon">
            <li><a href="index.jsp"><span>홈</span></a></li>
            <li><a href="search.jsp"><span>검색</span></a></li>
        <% if (user_id == null) { %>
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
        <form action="./searchResult.jsp" method="post">
            <input name="search" type="text" placeholder="검색" autocomplete="off">
            <button type="button" id="search_delete"><span>search_delete</span></button>
            <div id="search_dropdown">
                <p><span>"#"</span> 검색</p>
    
                <ul>
                <% 
                Collections.reverse(searchList);
                for (int i = 0; i < searchList.size() && i < 5; i++) { %>
                    <li>
                        <a href="searchResult.jsp?search=<%= searchList.get(i).getSearchWord() %>">
                            <div>
                                <span>#<%= searchList.get(i).getSearchWord() %></span>
                                <span>1230 게시물</span>
                            </div>
    
                            <div>
                                <img src="icons/star_colored.png">
                                <img src="icons/star_colored.png">
                                <img src="icons/star_half.png">
                                <img src="icons/star_gray.png">
                                <img src="icons/star_gray.png">
                            </div>
                        </a>
                    </li>
                   <% } %>
                </ul>
            </div>
        </form>


        <ul id="toggle">
            <li class="check">
                <a href="searchPopular.jsp">인기</a>
            </li>
            <li>
                <a href="searchNew.jsp">신규</a>
            </li>
        </ul>
        
        <div id="search_result">
            <p>"#<%= searchWord %>"</p>
            <div>
                <span><%= postList.size() %> 게시물</span>
                <% if (postList.size() == 0) { %>
                	<span>평균 0</span>
                <% } else { %>
                	<span>평균 <%= String.format("%.2f", dao.getAverageRate(postList)) %></span>
            	<% } %>
            </div>
        </div>
        
		<div class="image_box">
		<% if (postList.size() == 0) { %>
			<p>검색 결과가 없습니다.</p>
		<% } else  { %>
				<% for (Post p : postList) { %>
            <div>
                <img src="<%= p.getImagePath() %>">
                <a class="gallery_overlay">
                    <div>
                    <% for (int i = 0; i < (int)p.getPostRate(); i++) { %>
                        <img src="icons/star_white.png">
                    <% }
                    if (p.getPostRate() % 1 != 0.0) { %>
                    	<img src="icons/star_half_white.png">
                    <% }
                    
                    %>
                    </div>
    
                    <div>
                        <div>
                            <span>like</span>
                            <span><%= p.getLikeNum() %></span>
                        </div>
                        <div>
                            <span>comment</span>
                            <span><%= p.getCommentNum() %></span>
                        </div>
                    </div>
                </a>
            </div>
        
			<% } %>
		<% } %>
        </div>
        <!-- /.image_box -->
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