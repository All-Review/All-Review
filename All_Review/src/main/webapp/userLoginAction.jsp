<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.logging.Logger"%>
<%
    Logger logger = Logger.getLogger("LoginLogger");
    request.setCharacterEncoding("UTF-8");
    
    String user_id = request.getParameter("user_id");
    String user_password = request.getParameter("user_password");

    logger.info("Attempting to log in with user_id: " + user_id);

    if (user_id == null || user_password == null || user_id.isEmpty() || user_password.isEmpty()) {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안 된 사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    UserDAO userDAO = new UserDAO();
    int result = userDAO.login(user_id, user_password);
    
    if (result == 1) {
        // 로그인 성공
        session.setAttribute("user_id", user_id); // 세션에 사용자 ID 저장
        logger.info("User " + user_id + " logged in successfully."); // 로그 기록
        response.sendRedirect("index.jsp");
    } else if (result == 0) {
        // 비밀번호 틀림
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 틀립니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    } else if (result == -1) {
        // 존재하지 않는 아이디
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하지 않는 아이디입니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    } else if (result == -2) {
        // 데이터베이스 오류
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
%>