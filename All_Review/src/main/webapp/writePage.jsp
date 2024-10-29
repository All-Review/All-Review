
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>JSP 파일 업로드</title>
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

        #image_preview {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 1px;
            margin-bottom: 20px;
            text-align: center;
            width: 100%;
            height: 300px;
            overflow: hidden;
            position: relative;
        }

        #image_preview img {
            max-width: 100%;
            max-height: 100%;
            display: none;
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

</head>
<body>
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