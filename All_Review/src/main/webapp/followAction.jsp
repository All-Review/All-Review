<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="post.*, follow.*, alarm.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	FollowDAO followDao = new FollowDAO();
	
	// 팔로우 추가
	String userID = (String) session.getAttribute("userID");
	String otherUserID = request.getParameter("otherUserID");
	if (userID == null) {
		System.out.print("fail");
		response.sendRedirect(request.getContextPath() + "/userLogin.jsp");
	} else {
		followDao.createFollow(userID, otherUserID);
		response.sendRedirect(request.getContextPath() + "/userMyPage.jsp?otherUserID=" + otherUserID);
	}
	
    // 알림 생성
    String receiverID = request.getParameter("otherUserID");
    AlarmDAO alarmDAO = new AlarmDAO();
    alarmDAO.createAlarm(0, receiverID, userID, "follow");
%>