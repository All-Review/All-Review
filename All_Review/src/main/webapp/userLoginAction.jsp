<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String user_id = null;
	String user_password = null;
	
	if(request.getParameter("user_id") != null) {
		user_id = request.getParameter("user_id");
	}
	if(request.getParameter("user_password") != null) {
		user_password = request.getParameter("user_password");
	}
	if(user_id == null || user_password == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user_id, user_password);
	if(result == 1) {
		session.setAttribute("user_id", user_id);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	} else if(result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	} else if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	} else if(result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
%>