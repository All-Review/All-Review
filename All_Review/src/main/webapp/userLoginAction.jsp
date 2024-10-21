<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.logging.Logger"%>
<%
    Logger logger = Logger.getLogger("LoginLogger");
    request.setCharacterEncoding("UTF-8");
    
    String userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");

    logger.info("Attempting to log in with userID: " + userID);

    if (userID == null || userPassword == null || userID.isEmpty() || userPassword.isEmpty()) {
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
    int result = userDAO.login(userID, userPassword);
    
    if (result == 1) {
        // 로그인 성공
        session.setAttribute("userID", userID); // 세션에 사용자 ID 저장
        logger.info("User " + userID + " logged in successfully."); // 로그 기록
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