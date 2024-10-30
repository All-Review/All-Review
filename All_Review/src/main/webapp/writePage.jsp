
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>upload</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/writePage.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/setting.css">
    <link rel="stylesheet" href="css/sidebar.css">
	  <link rel="stylesheet" href="css/displaySize.css">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        #overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 10;
            display: none;
        }

        #post_form {
            display: flex;
            width: 800px;
            margin: 20px auto;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1000;
            flex-direction: column;
        }
	/* 이미지 미리보기 칸 (설명 칸의 2.5배 높이 적용) */
#image_preview {
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 10px;  
    margin-bottom: 20px;
    text-align: center;  /* 이미지 중앙 정렬 */
    width: 80%;
    justify-content: center;
    align-items: center;
    height: calc(100px * 2.5);  /* 설명 칸의 2.5배 높이 */
    overflow: hidden;  /* 이미지가 칸을 넘지 않도록 */
    background-color: #fafafa;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    position: relative;
}

/* 이미지 스타일: 미리보기 칸의 30% 여유 두고 중앙에 채우기 */
#image_preview img {
    max-height: 70%;  /* 높이를 70%로 제한해 30% 여유 */
    max-width: 70%;   /* 너비도 동일하게 70%로 제한 */
    margin: auto;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);  /* 중앙 정렬 */
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s;
    cursor: pointer;
}

#image_preview img:hover {
    transform: translate(-50%, -50%) scale(1.05);  /* 호버 시 확대 */
}

/* 업로드 버튼 스타일 (연두색) */
#submitButton {
    padding: 12px 20px;
    border: none;
    border-radius: 25px;
    background: linear-gradient(45deg, #8bc34a, #aed581);  /* 연두색 그라디언트 */
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background 0.3s, transform 0.2s;
    margin-top: 10px;
}

#submitButton:hover {
    background: linear-gradient(45deg, #7cb342, #9ccc65);  /* 호버 시 색상 변경 */
    transform: scale(1.05);  /* 약간 확대 */
}

#submitButton:active {
    transform: scale(0.98);  /* 클릭 시 살짝 눌리는 효과 */
}
	
        #prev, #next {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            font-size: 18px;
        }

        #prev {
            left: 0;
        }

        #next {
            right: 0;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input[type="file"] {
            display: block;
            margin-top: 10px;
        }

        .form-group textarea, .form-group input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .form-group textarea {
            height: 100px;
            resize: vertical; 
        }

        .rating {
            display: flex;
            justify-content: flex-start;
        }

        .rating input {
            display: none;
        }

        .rating label {
            font-size: 30px;
            color: #ddd;
            cursor: pointer;
        }

        .rating label:hover,
        .rating input:checked ~ label {
            color: gold;
        }

        #submitButton {
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            margin-right: 10px;
        }

        #submitButton:hover {
            background-color: #0056b3;
        }

        #closeButton {
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #6c757d;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }

        #closeButton:hover {
            background-color: #5a6268;
        }

        .button-group {
            display: flex;
            justify-content: flex-end;
        }

        .error {
            color: red;
            margin-bottom: 10px;
            display: none;
        }
    </style>

    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="js/writePage.js"></script>
    <script src="js/setting.js"></script>
    <script>
    </script>
</head>
<body>
    	<%
	    	String userID = request.getParameter("userID");
	    	
	    	if (userID == null) {
	    		userID = (String) session.getAttribute("userID");
	    	}
	    	
	    	UserDAO userDAO = new UserDAO();
	    	
	    	UserDTO user = userDAO.getUser(userID);
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

    <!-- 중앙 컨텐츠 -->
    <div id="content">
	    <form id="post_form" action="uploadAction.jsp" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" required>
        </div>
        <div class="form-group">
            <label for="caption">설명</label>
            <textarea id="caption" name="caption" rows="3" required></textarea>
        </div>
        <div class="form-group">
            <label for="rating">별점</label>
            <input type="number" id="rating" name="rating" min="1" max="5" required>
        </div>
        <div class="form-group">
            <label for="images">이미지 업로드</label>
            <input type="file" id="images" name="files" accept="image/*" multiple required>
        </div>
        <div id="image_preview">이미지 미리보기</div>
        <div class="button-group">
            <button type="submit" id="submitButton">업로드</button>
        </div>
    </form>
    </div>
    <!-- /content -->

    <div id="popular">
    </div>
    <script>
          const imageInput = document.getElementById('images');
          const preview = document.getElementById('image_preview');

          imageInput.addEventListener('change', (event) => {
              preview.innerHTML = '';
              Array.from(event.target.files).forEach(file => {
                  const reader = new FileReader();
                  reader.onload = (e) => {
                      const img = document.createElement('img');
                      img.src = e.target.result;
                      img.style.maxWidth = '100px';
                      img.style.marginRight = '10px';
                      preview.appendChild(img);
                  };
                  reader.readAsDataURL(file);
              });
          });
      </script>
</body>
</html>

