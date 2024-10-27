<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, post.*, util.DatabaseUtil" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%
    // 세션에서 사용자 ID 가져오기
    String userID = (String) session.getAttribute("user_id");
    if (userID == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }

    // 업로드된 이미지 저장 경로 설정
    String uploadPath = application.getRealPath("/uploads");
    int maxSize = 10 * 1024 * 1024; // 최대 10MB

    try {
        MultipartRequest multi = new MultipartRequest(
            request, uploadPath, maxSize, "UTF-8", new DefaultFileRenamePolicy()
        );

        String content = multi.getParameter("caption");
        String tag = multi.getParameter("title");
        String rating = multi.getParameter("rating");

        // 이미지 파일 처리
        Enumeration<?> files = multi.getFileNames();
        StringBuilder imagePaths = new StringBuilder();

        while (files.hasMoreElements()) {
            String file = (String) files.nextElement();
            String fileName = multi.getFilesystemName(file);
            if (fileName != null) {
                if (imagePaths.length() > 0) imagePaths.append(",");
                imagePaths.append("uploads/" + fileName);
            }
        }

        // DB에 게시물 저장
        Connection conn = DatabaseUtil.getConnection();
        String sql = "INSERT INTO post (userID, post_content, post_img_url, post_tag, post_rate, is_multiple_img) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, userID);
        pstmt.setString(2, content);
        pstmt.setString(3, imagePaths.toString());
        pstmt.setString(4, tag);
        pstmt.setDouble(5, rating != null ? Double.parseDouble(rating) : 0);
        pstmt.setBoolean(6, imagePaths.toString().contains(","));

        pstmt.executeUpdate();
        pstmt.close();
        conn.close();

        response.sendRedirect("index.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("업로드 중 오류가 발생했습니다.");
    }
%>
