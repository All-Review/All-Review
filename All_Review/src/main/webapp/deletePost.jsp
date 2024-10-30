<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, post.*, util.DatabaseUtil" %>

<%
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }

    // 삭제할 게시물 번호 받아오기
    int postNum = Integer.parseInt(request.getParameter("postNum"));
    PostDAO postDAO = new PostDAO();

    int result = postDAO.deletePost(postNum);

    if (result > 0) {
        // 삭제 성공 시 메인 페이지로 이동
        response.sendRedirect("index.jsp");
    } else {
        // 오류 발생 시 메시지 출력
        out.println("게시물 삭제 중 오류가 발생했습니다.");
    }
%>
