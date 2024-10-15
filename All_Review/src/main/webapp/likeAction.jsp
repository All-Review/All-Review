<%@page import="like.LikeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="like.*, post.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	int postNum = Integer.parseInt(request.getParameter("postNum"));
	
	LikeDAO likeDao = new LikeDAO();
	PostDAO postDao = new PostDAO();
	Post post = postDao.readOnePost(postNum);
	String user_id = (String) session.getAttribute("user_id");	
	
	// like 안했으면 추가하고, 했으면 삭제
	if (likeDao.isLiked(postNum, user_id).getUserId() == null) {
		likeDao.createLike(postNum, user_id);
		postDao.updateLikeNum(postNum, post, false);
	} else {
		likeDao.deleteLike(postNum, user_id);
		postDao.updateLikeNum(postNum, post, true);
	}
    
    response.sendRedirect(request.getContextPath() + "/detail.jsp?postNum=" + postNum);

%>