<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="follow.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	FollowDAO followDao = new FollowDAO();

	// 팔로우 삭제
	String userID = (String) session.getAttribute("userID");
	String otherUserID = request.getParameter("otherUserID");
	
	followDao.deletefollowing(userID, otherUserID);
	
    
    response.sendRedirect(request.getContextPath() + "/userMyPage.jsp?otherUserID=" + otherUserID);

%>