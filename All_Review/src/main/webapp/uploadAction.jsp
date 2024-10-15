<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.sql.*, java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="util.DatabaseUtil" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>업로드 처리</title>
</head>
<body>
<%
    String uploadPath = "C:/Users/USER/uploads"; // 파일 업로드 경로
    int maxSize = 10 * 1024 * 1024; // 최대 10MB

    try {
        MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "UTF-8");

        // 제목 및 내용 가져오기
        String title = multi.getParameter("title");
        String content = multi.getParameter("caption"); // 'caption'으로 수정
        String rating = multi.getParameter("rating");

        // 이미지 경로 처리
        Enumeration files = multi.getFileNames();
        StringBuilder imagePaths = new StringBuilder();

        while (files.hasMoreElements()) {
            String file = (String) files.nextElement();
            String fileName = multi.getFilesystemName(file);
            if (fileName != null) {
                if (imagePaths.length() > 0) {
                    imagePaths.append(",");
                }
                imagePaths.append("uploads/" + fileName); // 업로드된 파일 경로
            }
        }

        // DB에 게시물 정보 저장
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseUtil.getConnection();
            String sql = "INSERT INTO post2 (user_id, post_content, post_tag, post_rate, is_multiple_img, post_img_url) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "userID_example"); // 여기에 실제 사용자 ID를 넣어야 합니다.
            pstmt.setString(2, content);
            pstmt.setString(3, title); // 제목을 post_tag에 저장
            pstmt.setDouble(4, rating != null ? Double.parseDouble(rating) : 0); // 별점
            pstmt.setInt(5, imagePaths.toString().split(",").length > 1 ? 1 : 0); // 다중 이미지 여부
            pstmt.setString(6, imagePaths.toString()); // 이미지 경로를 post_img_url에 저장
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }

        // 업로드 완료 후 인덱스 페이지로 리디렉션
        response.sendRedirect("index.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
