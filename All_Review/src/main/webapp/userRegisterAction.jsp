<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String user_id = request.getParameter("user_id");
	String user_name = request.getParameter("user_name");
	String user_nickname = request.getParameter("user_nickname");
	String user_password = request.getParameter("user_password");
	String user_email = request.getParameter("user_email");
	
	if(user_id == null || user_name == null || user_nickname == null || user_password == null || user_email == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	
	UserDTO user = new UserDTO(user_id, user_password, user_email, user_name, user_nickname, "여기에 프로필 기본 이미지", "자기소개를 입력해주세요.", 0);
    UserDAO userDAO = new UserDAO();
    int result = userDAO.join(user);
    
	/*int result = userDAO.join(new UserDTO(user_id, user_password, user_email));*/
	if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디입니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	} else {
		session.setAttribute("user_id", user_id);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>