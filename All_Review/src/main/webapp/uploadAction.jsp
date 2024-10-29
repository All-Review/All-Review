<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, post.*, util.DatabaseUtil" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%
    // 사용자 로그인 세션 확인
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }

    // 파일 업로드 경로 설정
    String uploadPath = application.getRealPath("/uploads");
    int maxSize = 10 * 1024 * 1024;  // 최대 10MB

    try {
        MultipartRequest multi = new MultipartRequest(
            request, uploadPath, maxSize, "UTF-8", new DefaultFileRenamePolicy()
        );

        // 폼 데이터 가져오기
        String title = multi.getParameter("title");
        String caption = multi.getParameter("caption");
        String ratingStr = multi.getParameter("rating");
        double rating = (ratingStr != null) ? Double.parseDouble(ratingStr) : 0;

        // 파일 경로 조합
        Enumeration<?> files = multi.getFileNames();
        StringBuilder imagePaths = new StringBuilder();

        while (files.hasMoreElements()) {
            String paramName = (String) files.nextElement();
            String fileName = multi.getFilesystemName(paramName);
            if (fileName != null) {
                if (imagePaths.length() > 0) imagePaths.append(",");
                imagePaths.append("uploads/" + fileName);
            }
        }

        // DB에 게시물 저장
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "INSERT INTO post (userID, post_content, post_img_url, post_tag, post_rate, is_multiple_img) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, userID);
                pstmt.setString(2, caption);
                pstmt.setString(3, imagePaths.toString());
                pstmt.setString(4, title);
                pstmt.setDouble(5, rating);
                pstmt.setBoolean(6, imagePaths.toString().contains(","));
                pstmt.executeUpdate();
            }
        }

        // 인덱스 페이지로 리다이렉트
        response.sendRedirect("index.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("업로드 중 오류가 발생했습니다.");
    }
%>
