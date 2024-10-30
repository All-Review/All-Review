<%@page import="java.time.LocalDateTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="post.*, comment.*, alarm.*, java.util.Date"%>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 댓글 내용과 게시물 번호 받아오기
    String commentContent = request.getParameter("comment");
    String userID = (String) session.getAttribute("userID");

    int postNum = 0;
    try {
        postNum = Integer.parseInt(request.getParameter("postNum"));
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid post number.");
        return;
    }

    // 별점 처리
    double commentRate = 0;
    String starRate = request.getParameter("star_rate");
    if (starRate != null) {
        try {
            commentRate = Double.parseDouble(starRate);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    // 현재 시간 포맷팅
    Date date = new Date();
    SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");

    // 댓글 객체 생성
    PostComment comment = new PostComment(
        postNum,
        userID,
        "테스트용닉네임",
        "images/15fd24a290e3154d44f486b0720b0692_res.jpeg",
        commentContent,
        commentRate,
        format1.format(date)
    );

    // 댓글 저장
    PostCommentDAO commentDao = new PostCommentDAO();
    int result = commentDao.createComment(comment);

    // 게시물 댓글 개수 업데이트
    PostDAO postDao = new PostDAO();
    Post post = postDao.readOnePost(postNum);
    if (post == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Post not found.");
        return;
    }
    postDao.updateCommentNum(postNum, post, false);
    
    // 알림 생성
    String receiverID = post.getUserID();
    AlarmDAO alarmDAO = new AlarmDAO();
    alarmDAO.createAlarm(postNum, receiverID, userID, "comment");  
    response.sendRedirect(request.getContextPath() + "/detail.jsp?postNum=" + postNum);

    // 이미지 파라미터 처리 및 리다이렉트
    String imageParam = request.getParameter("image");
    String encodedImage = (imageParam != null) ? URLEncoder.encode(imageParam, "UTF-8") : "";

    response.sendRedirect("index.jsp");

%>
