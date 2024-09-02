<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
   
    HttpSession session = request.getSession();
    Integer loggedInUserId = (Integer) session.getAttribute("userId");
    if (loggedInUserId == null) {
        response.sendRedirect("login.jsp"); 
        return;
    }

  
    Integer followedId = Integer.parseInt(request.getParameter("followedId"));
    String url = "jdbc:mysql://localhost:3306/sss";
    String user = "root";
    String password = "123123";
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

       
        String checkFollowSql = "SELECT COUNT(*) FROM followers WHERE follower_id = ? AND followed_id = ?";
        pstmt = conn.prepareStatement(checkFollowSql);
        pstmt.setInt(1, loggedInUserId);
        pstmt.setInt(2, followedId);
        ResultSet rs = pstmt.executeQuery();
        rs.next();
        boolean isFollowing = rs.getInt(1) > 0;
        pstmt.close();

        if (isFollowing) {
           
            String unfollowSql = "DELETE FROM followers WHERE follower_id = ? AND followed_id = ?";
            pstmt = conn.prepareStatement(unfollowSql);
            pstmt.setInt(1, loggedInUserId);
            pstmt.setInt(2, followedId);
            pstmt.executeUpdate();
        } else {
            
            String followSql = "INSERT INTO followers (follower_id, followed_id) VALUES (?, ?)";
            pstmt = conn.prepareStatement(followSql);
            pstmt.setInt(1, loggedInUserId);
            pstmt.setInt(2, followedId);
            pstmt.executeUpdate();
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    response.sendRedirect("follow.jsp");
%>
