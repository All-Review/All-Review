<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="follow.*, alarm.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	FollowDAO followDao = new FollowDAO();

	// 팔로우 삭제
	String userID = (String) session.getAttribute("userID");
	String otherUserID = request.getParameter("otherUserID");
	
	followDao.deletefollowing(userID, otherUserID);
	
	// 알림 삭제
	AlarmDAO alarmDAO = new AlarmDAO();
	alarmDAO.deleteAlarm(0, otherUserID, userID);

    response.sendRedirect(request.getContextPath() + "/userMyPage.jsp?otherUserID=" + otherUserID);

%>