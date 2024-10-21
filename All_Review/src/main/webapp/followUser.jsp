<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="util.DatabaseUtil" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<%
    HttpSession session = request.getSession();
    Integer loggedInUserId = (Integer) session.getAttribute("userId"); // 로그인한 사용자 ID 가져오기

    if (loggedInUserId == null) {
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED); // 로그인하지 않은 경우
        return;
    }

    String usernameToFollow = request.getParameter("username");

    // 데이터베이스 연결 및 팔로우 추가
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = DatabaseUtil.getConnection();
        String sql = "INSERT INTO followers (follower_id, followed_user_id) VALUES (?, (SELECT user_id FROM user WHERE username = ?))";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, loggedInUserId); // 팔로워 ID
        pstmt.setString(2, usernameToFollow); // 팔로우할 사용자 이름
        pstmt.executeUpdate();
        
        response.getWriter().write("팔로우 성공");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
