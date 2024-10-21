<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = request.getParameter("userID");
	String userName = request.getParameter("userName");
	String userNickname = request.getParameter("userNickname");
	String userPassword = request.getParameter("userPassword");
	String userEmail = request.getParameter("userEmail");
	
	if(userID == null || userName == null || userNickname == null || userPassword == null || userEmail == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	
	UserDTO user = new UserDTO(userID, userPassword, userEmail, userName, userNickname, "여기에 프로필 기본 이미지", "자기소개를 입력해주세요.", 0);
    UserDAO userDAO = new UserDAO();
    int result = userDAO.join(user);
    
	/*int result = userDAO.join(new UserDTO(userID, userPassword, userEmail));*/
	if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디입니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	} else {
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>