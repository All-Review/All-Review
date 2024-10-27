<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="post.*, follow.*"%>
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
    
    

%>