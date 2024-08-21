<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="post.*, comment.*, Search.*, java.util.List"%>
<% 
	PostDAO dao = new PostDAO();
	int postNum = Integer.parseInt(request.getParameter("postNum"));
	int commentNum = Integer.parseInt(request.getParameter("commentNum"));

	// 댓글
	PostCommentDAO commentDao = new PostCommentDAO();
	PostComment comment = commentDao.readOneComment(commentNum);
	
	// 실시간검색어
	SearchHistoryDAO searchDao = new SearchHistoryDAO();
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
    <link rel="stylesheet" href="css/overlay.css">
    <link rel="stylesheet" href="css/detail.css">
    <link rel="stylesheet" href="css/alert.css">
    <!-- google web font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="js/content_detail.js"></script>
    <script src="js/detail.js"></script>
    <script>
    </script>
</head>

<body>
    <!-- 왼쪽 네비게이션 바 -->
    <div id="sidebar">
        <a href="index.jsp"><span>All Review 올리</span></a>
        <ul>
            <li><a href="index.html"><span>홈</span></a></li>
            <li><a href="search.html"><span>검색</span></a></li>
            <li><a href="#"><span>알림</span></a></li>
            <li><a href="#"><span>설정</span></a></li>
            <li><a href="mypage.html"><span>프로필</span></a></li>
            <li><a href="#"><span>게시하기</span></a></li>
        </ul>
    </div>

    <!-- 중앙 컨텐츠 -->
    <div id="content">
        <a href="<%= request.getHeader("referer") %>"><h3>댓글 수정</h3></a>
        <div class="content_container">
            
            <div>
                <!-- 댓글 쓰기 -->
                 <form action="updateComment.jsp?postNum=<%= postNum %>&commentNum=<%= comment.getCommentNum() %>" method="post" id="comment_form">
                    <img src="images/KakaoTalk_20240503_135834006.jpg">
                    <input name="comment" type="text" placeholder="댓글 쓰기" autocomplete="off" value="<%= comment.getCommentContent() %>">

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
                    <button type="submit" id="comment_submit"><span>확인</span></button>
                    <div id="comment_alert">댓글 내용을 입력하세요</div>
                 </form>
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

