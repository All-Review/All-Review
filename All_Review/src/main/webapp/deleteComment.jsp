<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="post.*, comment.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	int postNum = Integer.parseInt(request.getParameter("postNum"));
	int commentNum = Integer.parseInt(request.getParameter("commentNum"));
	
	// 댓글 삭제
    PostCommentDAO commentDao = new PostCommentDAO();
    int result = commentDao.deleteComment(postNum, commentNum);
    
    // 게시물 댓글 개수 업데이트
    PostDAO postDao = new PostDAO();
    Post post = postDao.readOnePost(postNum);
    postDao.updateCommentNum(postNum, post, true);
    
    response.sendRedirect(request.getContextPath() + "/detail.jsp?postNum=" + postNum);

%>