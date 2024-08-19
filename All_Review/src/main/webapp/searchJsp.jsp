<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String postNum = request.getParameter("postNum");

    response.sendRedirect(request.getContextPath() + "/search.jsp?postNum=" + postNum);
%>