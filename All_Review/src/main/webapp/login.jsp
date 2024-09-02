<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // 데이터베이스 연결 및 사용자 인증 로직
    String dbURL = "jdbc:mysql://localhost:3306/SSS";
    String dbID = "root";
    String dbPassword = "123123";
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

    String sql = "SELECT id FROM users WHERE username = ? AND password = ?";
    PreparedStatement statement = conn.prepareStatement(sql);
    statement.setString(1, username);
    statement.setString(2, password);
    ResultSet resultSet = statement.executeQuery();

    if (resultSet.next()) {
        int userId = resultSet.getInt("id");
        session.setAttribute("userId", userId);
        response.sendRedirect("welcome.jsp");
    } else {
        out.println("<script>alert('로그인 정보가 올바르지 않습니다.'); history.back();</script>");
    }

    resultSet.close();
    statement.close();
    conn.close();
%>
