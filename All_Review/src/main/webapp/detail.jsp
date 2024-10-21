<%@page import="like.LikeDAO"%>
<%@page import="java.util.Collections"%>
<%@page import="post.*"%>
<%@page import="Search.*"%>
<%@page import="util.*"%>
<%@page import="user.*" %>
<%@page import="comment.*" %>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	PostDAO dao = new PostDAO();
	int postNum = Integer.parseInt(request.getParameter("postNum"));
	Post post = dao.readOnePost(postNum);
	
	// 실시간 검색어
	SearchHistoryDAO searchDao = new SearchHistoryDAO();
	List<SearchHistoryAll> searchListAll = searchDao.readSearchListsAllDesc();
	
	// 댓글
	PostCommentDAO commentDao = new PostCommentDAO();
	List<PostComment> commentList = commentDao.readAllPostComments(postNum);
	
	// 좋아요
	LikeDAO likeDao = new LikeDAO();
	
	List<String> imageList = dao.splitImages(post.getImagePath());
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
    <link rel="stylesheet" href="css/alert.css">
    
    <!-- google web font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="js/detail.js"></script>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script>
    $(function () {
  	  $('#share').on('click', function () {
	      shareKakao();
	  });

	  function shareKakao(id) {
	      // Kakao Javascript key
	      Kakao.init('667e3ef354b2246f627c0e2295367de5');
	     
	      // 카카오링크 버튼 생성
	      Kakao.Link.createDefaultButton({
	        container: '#share',
	        objectType: 'feed',
	        content: {
	          title: "All Review",
	          description: "<%= post.getPostContent() %>",
	          imageUrl: "<%= post.getImagePath() %>",
	          link: {
	        	  mobileWebUrl: "http://localhost:8080/All_Review/detail.jsp?postNum=<%= post.getPostId() %>",
		             webUrl: "http://localhost:8080/All_Review/detail.jsp?postNum=<%= post.getPostId() %>"
	          }
	        }
	      });
	    }
    
    });
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
        <a href="<%= request.getHeader("referer") %>"><h3>게시물</h3></a>
        <div class="content_container">
            
            <div>
                <!-- profile -->
                <div class="profile_box">
                    <img src="images/KakaoTalk_20240503_135834006_10.jpg">
                    <div>
                        <span>농담곰</span>
                        <span><%= post.getUserID() %></span>
                    </div>
                </div>
                <!-- star -->
                <div class="star">
                    <% for (int i = 0; i < (int)post.getPostRate(); i++) { %>
                        <img src="icons/star_colored.png">
                    <% }
                    if (post.getPostRate() % 1 != 0.0) { %>
                    	<img src="icons/star_half.png">
                    <% } %>
                </div>
                <!-- 글 내용 -->
                <p><%= post.getPostContent() %></p>
                
                <div id="image_list">
                <% if (post.getIsMultipleImg()) { %>
                	<button><span>left</span></button>
                    <button><span>right</span></button>
                    <ul>
                    <% for (int i = 0; i < imageList.size(); i++) { %>
                        <li>
                            <img src="<%= imageList.get(i) %>">
                        </li>
                    <% } %>
                    </ul>

                    <ol>
                    <% for (int i = 0; i < imageList.size(); i++) { %>
                    	<li class="on"><span><%= i + 1 %></span></li>
                    <% } %>
                    </ol>
                <% } else { %>
                	<ul>
                    
                        <li>
                            <img src="<%= post.getImagePath() %>">
                        </li>
                    
                    </ul>
                <% } %>
                    
                </div>
                
                <div id="tag_container">
                    <div>
                        <span>#<%= post.getPostTag() %></span>
                    </div>
                    <span>2024년 5월 10일 10:00 AM</span>
                </div>

                <!-- 좋아요, 댓글, 공유 -->
                <div class="like_container">
                <% if (likeDao.isLiked(postNum, userID).getUserId() == null) { %>
                	<div style="background-image: url('icons/heart-regular.svg')">
                <% } else { %>
                	<div style="background-image: url('icons/icon_heart_red.png')">
                <% } %>
                    <% if (userID == null) { %>
                    	<a href="userLogin.jsp"><span>like</span><span><%= post.getLikeNum() %></span></a>
                    <% } else { %>
                    	<a href="likeAction.jsp?postNum=<%= postNum %>&receiverID=<%= post.getUserID() %>"><span>like</span><span><%= post.getLikeNum() %></span></a>
                    <% } %>
                    </div>
                    <div>
                        <span>comment</span><span><%= post.getCommentNum() %></span>
                    </div>
                    <div>
                        <span>share</span>
                        <div id="share">카카오톡으로 공유하기</div>
                    </div>
                </div>

                <!-- 댓글 쓰기 -->
                <% if (userID == null) { %>
                	<form action="./userLogin.jsp" id="comment_form">
                	<img src="images/user_default_profile.png">
                <% } else { %>
                	<form action="./createComment.jsp?postNum=<%= postNum %>&receiverID=<%= post.getUserID() %>" method="post" id="comment_form">
                	<img src="images/KakaoTalk_20240503_135834006.jpg">
                <% } %>
                    
                    <input name="comment" type="text" placeholder="댓글 쓰기" autocomplete="off">
                    <div class="star_radio">
                        <label for="star_rate_1" class="label_star" title="0.5"></label>
                        <label for="star_rate_2" class="label_star" title="1"></label>
                        <label for="star_rate_3" class="label_star" title="1.5"></label>
                        <label for="star_rate_4" class="label_star" title="2"></label>
                        <label for="star_rate_5" class="label_star" title="2.5"></label>
                        <label for="star_rate_6" class="label_star" title="3"></label>
                        <label for="star_rate_7" class="label_star" title="3.5"></label>
                        <label for="star_rate_8" class="label_star" title="4"></label>
                        <label for="star_rate_9" class="label_star" title="4.5"></label>
                        <label for="star_rate_10" class="label_star" title="5"></label>
                        <input type="radio" name="star_rate" id="star_rate_1" value="0.5">
                        <input type="radio" name="star_rate" id="star_rate_2" value="1">
                        <input type="radio" name="star_rate" id="star_rate_3" value="1.5">
                        <input type="radio" name="star_rate" id="star_rate_4" value="2">
                        <input type="radio" name="star_rate" id="star_rate_5" value="2.5">
                        <input type="radio" name="star_rate" id="star_rate_6" value="3">
                        <input type="radio" name="star_rate" id="star_rate_7" value="3.5">
                        <input type="radio" name="star_rate" id="star_rate_8" value="4">
                        <input type="radio" name="star_rate" id="star_rate_9" value="4.5">
                        <input type="radio" name="star_rate" id="star_rate_10" value="5">
                        <span class="star_rate_bg"></span>
                      </div>
                    <button type="submit" id="comment_submit">확인</button>
                    <div id="comment_alert">댓글 내용을 입력하세요</div>
                 </form>

                <!-- 댓글영역 -->
                <div class="comment_box">
                <% for(PostComment comment : commentList) { %>
                    <div class="profile_box">
                        <a href="myPage.jsp?userID=<%= comment.getUserId() %>"><img src="<%= comment.getUserProfileImage() %>"></a>
                        <div>

                            <div>
                                <a href="myPage.jsp?userID=<%= comment.getUserId() %>"><span><%= comment.getNickname() %></span></a>
                                <span><%= comment.getUserId() %></span>
                                <span><%= comment.getCommentCreateAt() %></span>
                                <% // if(comment.getUserId().equals(userID)) { %>
                                <div class="comment_menu">
                                    <span>더보기</span>
                                    <ul>
                                        <li onClick="location.href='deleteComment.jsp?postNum=<%= postNum %>&commentNum=<%= comment.getCommentIndex() %>'">삭제하기</li>
                                        <li onClick="location.href='updateCommentForm.jsp?postNum=<%= postNum %>&commentNum=<%= comment.getCommentIndex() %>'">수정하기</li>
                                    </ul>
                                </div>
                                <% // } %>
                            </div>
    
                            <span><%= comment.getCommentContent() %></span>

                            <div class="comment_star">
                    			<% for (int i = 0; i < (int)comment.getCommentRate(); i++) { %>
                    			    <img src="icons/star_colored.png">
                    			<% }
                    				if (comment.getCommentRate() % 1 != 0.0) { %>
                    				<img src="icons/star_half.png">
                    			<% } else { %>
                    				<img src="icons/star_gray.png">
                    			<% } 
                    				for (int i = 0; i < 4 - (int)comment.getCommentRate(); i++) { %>
                    			    <img src="icons/star_gray.png">
                    			<% } %>
                            </div>

                        </div>
                    </div>
				<% } %>
                </div>
                <!-- /댓글 -->
            </div>

        </div>
        <button id="top_button">Top</button>
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