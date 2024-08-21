<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="comment.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	int postNum = Integer.parseInt(request.getParameter("postNum"));
	int commentNum = Integer.parseInt(request.getParameter("commentNum"));
	String commentContent = request.getParameter("comment");
	double commentRate;
	String starRate = request.getParameter("star_rate");
	
	// 별점이 0점 (선택안함)일 때
	if (starRate == null) {
		commentRate = 0;
	} else {
		commentRate = Double.parseDouble(starRate);
	}
	
	// 댓글 수정
    PostCommentDAO commentDao = new PostCommentDAO();
    int result = commentDao.updateComment(commentNum, commentContent, commentRate);
    
    response.sendRedirect(request.getContextPath() + "/detail.jsp?postNum=" + postNum);

%>