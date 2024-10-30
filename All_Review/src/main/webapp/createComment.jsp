<%@page import="java.time.LocalDateTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="post.*, comment.*, alarm.*, java.util.Date"%>
<%
	request.setCharacterEncoding("UTF-8");

	String userID = (String) session.getAttribute("userID");
	String commentContent = request.getParameter("comment");
	int postNum = Integer.parseInt(request.getParameter("postNum"));
	double commentRate;
	String starRate = request.getParameter("star_rate");
	
	// 별점이 0점 (선택안함)일 때
	if (starRate == null) {
		commentRate = 0;
	} else {
		commentRate = Double.parseDouble(starRate);
	}
    
	Date date = new Date();
	// SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
	SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd  HH:mm");
	
	// 댓글 작성
	//System.out.println(now.toString());
    PostComment comment = new PostComment(postNum, (String) session.getAttribute("userID"), "테스트용닉네임", "images/15fd24a290e3154d44f486b0720b0692_res.jpeg", commentContent, commentRate, format1.format(date));
    PostCommentDAO commentDao = new PostCommentDAO();
    int result = commentDao.createComment(comment);
    
    // 게시물 댓글 개수 업데이트
    PostDAO postDao = new PostDAO();
    Post post = postDao.readOnePost(postNum);
    postDao.updateCommentNum(postNum, post, false);
    
    // 알림 생성
    String receiverID = post.getUserID();
    AlarmDAO alarmDAO = new AlarmDAO();
    alarmDAO.createAlarm(postNum, receiverID, userID, "comment");  
    response.sendRedirect(request.getContextPath() + "/detail.jsp?postNum=" + postNum);

%>