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
    String uploadPath = "C:/Users/USER/uploads"; // 업로드 경로
    int maxSize = 10 * 1024 * 1024; // 최대 10MB

    try {
        MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "UTF-8");

        String userID = (String) session.getAttribute("userID"); // 세션에서 사용자 ID 가져오기
        String content = multi.getParameter("caption");
        String tag = multi.getParameter("title"); // 게시물의 태그(제목)
        String rating = multi.getParameter("rating");

        // 이미지 파일 처리
        Enumeration<?> files = multi.getFileNames();
        StringBuilder imagePaths = new StringBuilder();

        while (files.hasMoreElements()) {
            String file = (String) files.nextElement();
            String fileName = multi.getFilesystemName(file);
            if (fileName != null) {
                if (imagePaths.length() > 0) imagePaths.append(",");
                imagePaths.append("uploads/" + fileName); // 이미지 경로
            }
        }

        // DB에 저장
        Connection conn = DatabaseUtil.getConnection();
        String sql = "INSERT INTO post (userID, post_content, post_img_url, post_tag, post_rate, is_multiple_img) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userID);
        pstmt.setString(2, content);
        pstmt.setString(3, imagePaths.toString());
        pstmt.setString(4, tag); 
        pstmt.setDouble(5, rating != null ? Double.parseDouble(rating) : 0);
        pstmt.setInt(6, imagePaths.toString().contains(",") ? 1 : 0); 

        pstmt.executeUpdate();
        pstmt.close();
        conn.close();

        response.sendRedirect("index.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
