<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시물 작성</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/writePage.css">
    <link rel="stylesheet" href="css/common.css">
    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="js/writePage.js"></script>
</head>
<body>
<%
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("userLogin.jsp"); // 로그인되지 않은 사용자는 로그인 페이지로
        return;
    }
%>

<div id="content">
    <form action="uploadAction.jsp" method="post" enctype="multipart/form-data">
        <div id="post_form">
            <div id="image_preview">
                <img id="preview" />
            </div>
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" name="title" id="title" placeholder="제목" required />
            </div>
            <div class="form-group">
                <label for="image">이미지 업로드</label>
                <input type="file" name="files" id="image" accept="image/*" multiple onchange="handleChange(event)" />
            </div>
            <div class="form-group">
                <label for="caption">설명</label>
                <textarea name="caption" id="caption" placeholder="설명을 입력"></textarea>
            </div>
            <div class="form-group">
                <label for="rating">별점</label>
                <select name="rating" id="rating">
                    <option value="0">0</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select>
            </div>
            <div class="button-group">
                <input type="submit" value="업로드" id="submitButton">
                <button id="closeButton" type="button">닫기</button>
            </div>
        </div>
    </form>
</div>

<script>
function handleChange(event) {
    var files = event.target.files;
    var previewDiv = document.getElementById('image_preview');
    previewDiv.innerHTML = ''; 
    Array.from(files).forEach(file => {
        var reader = new FileReader();
        reader.onload = function(e) {
            var img = document.createElement('img');
            img.src = e.target.result;
            img.style.maxWidth = '150px';
            img.style.marginRight = '10px';
            previewDiv.appendChild(img);
        };
        reader.readAsDataURL(file);
    });
}
</script>

</body>
</html>

