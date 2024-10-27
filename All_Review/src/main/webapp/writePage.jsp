
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
    <script>
    let currentIndex = 0;
    let imageElements = [];

    function handleChange(event) {
        const files = event.target.files;
        const preview = document.getElementById('image_preview');
        preview.innerHTML = ''; // 미리보기 초기화

        if (files.length === 0) {
            preview.innerHTML = '<p>이미지 미리보기</p>';
            return;
        }

        Array.from(files).forEach((file, index) => {
            const reader = new FileReader();

            reader.onload = function(e) {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.style.maxWidth = '100%';
                img.style.maxHeight = '100%';
                img.setAttribute('data-index', index);

                // 첫 번째 이미지만 표시하고 나머지는 숨김
                if (index !== 0) {
                    img.style.display = 'none';
                } else {
                    img.style.display = 'block';
                }

                preview.appendChild(img);
            };

            reader.readAsDataURL(file);
        });

        imageElements = Array.from(preview.getElementsByTagName('img'));
        currentIndex = 0;

        // 이미지가 2개 이상일 때만 슬라이더 버튼 추가
        if (imageElements.length > 1) {
            addNavigation(preview);
        }
    }

    function addNavigation(preview) {
        // 이전, 다음 버튼이 이미 있으면 다시 추가하지 않음
        if (document.getElementById('prev') || document.getElementById('next')) {
            return;
        }

        const prevButton = document.createElement('button');
        prevButton.id = 'prev';
        prevButton.textContent = '‹';
        prevButton.onclick = showPrevImage;

        const nextButton = document.createElement('button');
        nextButton.id = 'next';
        nextButton.textContent = '›';
        nextButton.onclick = showNextImage;

        preview.appendChild(prevButton);
        preview.appendChild(nextButton);
    }

    function showPrevImage() {
        imageElements[currentIndex].style.display = 'none';
        currentIndex = (currentIndex - 1 + imageElements.length) % imageElements.length;
        imageElements[currentIndex].style.display = 'block';
    }

    function showNextImage() {
        imageElements[currentIndex].style.display = 'none';
        currentIndex = (currentIndex + 1) % imageElements.length;
        imageElements[currentIndex].style.display = 'block';
    }
           
    </script>
</head>
<body>
    <button onclick="showForm()">업로드 폼 열기</button>
    <div id="overlay"></div>
    <form action="uploadAction.jsp" method="post" enctype="multipart/form-data">
        <div id="post_form">
            <div id="image_preview">
                <p>이미지 미리보기</p>
            </div>
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" name="title" id="title" placeholder="제목" />
                <div class="error" id="titleError">제목을 입력해주세요.</div>
            </div>
            <div class="form-group">
                <label for="images">이미지 업로드 </label>
                <input type="file" name="files" id="images" accept="image/*" multiple onchange="handleChange(event)" />
            </div>
            <div class="form-group">
                <label for="caption">설명</label>
                <textarea name="caption" id="caption" placeholder="설명을 입력"></textarea>
                <div class="error" id="captionError">설명을 입력해주세요.</div>
            </div>
            <div class="form-group">
                <label>별점</label>
                <div class="rating">
                    <input type="radio" id="star5" name="rating" value="5" /><label for="star5">★</label>
                    <input type="radio" id="star4" name="rating" value="4" /><label for="star4">★</label>
                    <input type="radio" id="star3" name="rating" value="3" /><label for="star3">★</label>
                    <input type="radio" id="star2" name="rating" value="2" /><label for="star2">★</label>
                    <input type="radio" id="star1" name="rating" value="1" /><label for="star1">★</label>
                </div>
            </div>
            <div class="button-group">
                <input type="submit" value="업로드" id="submitButton">
                <button id="closeButton" type="button">닫기</button>
            </div>
        </div>
    </form>
</body>
</html>