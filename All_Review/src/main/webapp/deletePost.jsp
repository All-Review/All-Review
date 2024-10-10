<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.*" %>

<%
    String dbURL = "jdbc:mysql://localhost:3306/SSS";
    String dbID = "root";
    String dbPassword = "123123";
    Connection conn = null;
    PreparedStatement pstmt = null;

    String postId = request.getParameter("postId");
    String imagePath = request.getParameter("imagePath");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

        
        String sql = "DELETE FROM post WHERE post_num = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(postId));
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            
            String fullPath = application.getRealPath("/uploads/" + imagePath);
            File file = new File(fullPath);
            if (file.exists()) {
                file.delete(); 
            }
            out.println("<script>alert('게시물이 삭제되었습니다.');</script>");
        } else {
            out.println("<script>alert('게시물 삭제에 실패했습니다.');</script>");
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("JDBC Driver not found.");
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Database error: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

   
    response.sendRedirect("index.jsp");
%>

