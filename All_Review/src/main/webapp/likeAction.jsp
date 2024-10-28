<%@page import="like.LikeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="like.*, post.*, alarm.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	int postNum = Integer.parseInt(request.getParameter("postNum"));
	
	LikeDAO likeDao = new LikeDAO();
	PostDAO postDao = new PostDAO();
	Post post = postDao.readOnePost(postNum);
	String userID = (String) session.getAttribute("user_id");	
	
    // 알림
    String receiverID = post.getUserID();
    AlarmDAO alarmDAO = new AlarmDAO();
	
	// like 안했으면 추가하고, 했으면 삭제
	if (likeDao.isLiked(postNum, userID).getUserId() == null) {
		likeDao.createLike(postNum, userID);
		postDao.updateLikeNum(postNum, post, false);
		// 알림 생성
		alarmDAO.createAlarm(postNum, receiverID, userID, "like");
		alarmDAO.updateAlarmNum(alarmDAO.readAlarmNum(receiverID), receiverID, true);
	} else {
		likeDao.deleteLike(postNum, userID);
		postDao.updateLikeNum(postNum, post, true);
		// 알림 삭제
		alarmDAO.deleteAlarm(postNum, receiverID, userID);
		alarmDAO.updateAlarmNum(alarmDAO.readAlarmNum(receiverID), receiverID, false);
	}
    
    response.sendRedirect(request.getContextPath() + "/detail.jsp?postNum=" + postNum);

%>