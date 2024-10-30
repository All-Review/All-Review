<%@page import="follow.FollowDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="post.*"%>
<%@page import="Search.*"%>
<%@page import="user.*"%>
<%@page import="follow.*"%>
<%@page import="java.util.List" %>
<%

	if (userID == null) {
		userID = (String) session.getAttribute("userID");
	}
	
	UserDAO userDAO = new UserDAO();
	
	UserDTO user = userDAO.getUser(userID);

	// if (userID == null) {
	// 	userID = (String) session.getAttribute("userID");
	// }


	String userID = (String) session.getAttribute("userID");
	// 로그인 안되어있으면 로그인페이지로
	//if (userID == null) {
	//	response.sendRedirect(request.getContextPath() + "/userLogin.jsp");
	//}

	PostDAO dao = new PostDAO();
	List<Post> postList = dao.readAllPostsByUser(userID);
	
	
	
	//String userNickname = userDAO.getUserNicknameById(userID);
	//String userIntroduce = userDAO.getUserIntroduceById(userID);
	//String userProfileimage = userDAO.getUserProfileimageById(userID);

	// 실시간 검색어
	SearchHistoryDAO searchDAO = new SearchHistoryDAO();
	List<SearchHistory> searchList = searchDAO.readSearchLists();
	List<SearchHistoryAll> searchListAll = searchDAO.readSearchListsAllDesc();
	
	// 팔로우
	FollowDAO followDao = new FollowDAO();
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
	<link rel="stylesheet" href="css/displaySize.css">
    <link rel="stylesheet" href="css/mypage.css">
    <link rel="stylesheet" href="css/image_gallery.css">
    <link rel="stylesheet" href="css/overlay.css">
    <link rel="stylesheet" href="css/setting.css">
    <link rel="stylesheet" href="css/profileEditOverlay.css">

    <!-- google web font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="js/image_gallery.js"></script>
    <script src="js/mypage.js"></script>
    <script src="js/checkFileSize.js"></script>
    <script src="js/profileEditOverlay.js"></script>

</head>

<body>
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
			<li>
				<div id="sidebarUserProfile">
	                <img src="<%= request.getContextPath() + "/uploadsProfileimage/" + user.getUserProfileImage() %>" alt="Profile Image" />
	                <div>
	                    <span><%= user.getUserNickname() %></span>
                		<span><%= user.getUserID() %></span>
	                </div>     
	            </div>
            </li>
			<li id="LogoutBtn"><a href="userLogout.jsp"><span>로그아웃</span></a></li>
			<%
				}
			%>
        </ul>
    </aside>

    <div id="content">
        <div class="profile_box">
            <img src="<%= request.getContextPath() + "/uploadsProfileimage/" + user.getUserProfileImage() %>" alt="Profile Image" />
            <div>
                <span><%= user.getUserNickname() %></span>
                <span><%= user.getUserID() %></span>
                <span><%= user.getUserIntroduce() %></span>
            </div>

            <ul>

            <% if (userID != null && userID.equals((String) session.getAttribute("userID"))) { %>

                <li class="mypage_button">
                    <span>privacy setting</span>
                    <ul>
                        <li onClick="location.href='deleteUser.jsp'">탈퇴하기</li>
                        <li onClick="location.href='userLogout.jsp'">로그아웃</li>
                    </ul>
                </li>
                <li class="mypage_button">
                    <span>setting</span>
                    <ul>
                        <li id="editProfile">프로필 수정</li>
                    </ul>
                </li>
            <% } %>
            </ul>
        </div>

        <div>
            <a href="myPage.jsp" class="check">게시물 26</a>
            <a href="follower.jsp">팔로워 <%= followDao.getFollowerNum(userID) %></a>
            <a href="following.jsp">팔로우 <%= followDao.getFollowingNum(userID) %></a>
        </div>

        <div class="image_box">
<% for (Post p : postList) { %>
            <div>
                <img src="<%= p.getImagePath() %>">
                <a href="detail.jsp?postNum=<%= p.getPostId() %>" class="gallery_overlay">
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
    <!-- /#popular -->
    
    
    <!-- 프로필 수정 오버레이 -->
	<div id="profileEditOverlay">
		<div id="profileEditBox">
		<button class="close" id="closeProfileEdit"><span>닫기</span></button>
		<h2>프로필 수정</h2>
			        
			<form method="post" action="./userUpdateAction.jsp" id="editBox" enctype="multipart/form-data">
				<div id="profileImageContainer">
					<img id="profileImagePreview" src="<%= request.getContextPath() + "/uploadsProfileimage/" + user.getUserProfileImage() %>" alt="프로필 이미지" />
					<div class="overlayText">이미지<br>선택하기</div>
				</div>
				<input type="file" name="newImage" id="newImageUpload" accept="image/*"/>
					            
				<label for="nickname">닉네임</label>
				<input type="text" name="newNickname" id="nickname" value="<%= user.getUserNickname() %>" placeholder="닉네임">
					            
				<label for="description">자기소개</label>
				<textarea name="newIntroduce" id="description" rows="4" placeholder="자기소개"><%= user.getUserIntroduce() %></textarea>
					            
				<span id="fileSizeMessage" style="color:red;"></span>
				<button type="submit" id="userUpdate" class="account">수정</button>
			</form>
		</div>
	</div>

</body>

</html>