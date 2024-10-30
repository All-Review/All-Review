<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.logging.Logger"%>

<%
    Logger logger = Logger.getLogger("UserDeletionLogger");
    request.setCharacterEncoding("UTF-8");

    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    logger.info("Attempting to delete user with userID: " + userID);

    UserDAO userDAO = new UserDAO();
    int result = userDAO.deleteUser(userID);

    response.setContentType("text/html;charset=UTF-8");
    PrintWriter script = response.getWriter();

    if (result == 1) {
        session.invalidate();
        logger.info("User " + userID + " deleted successfully.");
        script.println("<script>");
        script.println("alert('회원 탈퇴가 완료되었습니다.');");
        script.println("location.href='index.jsp';");
        script.println("</script>");
    } else if (result == 0) {
        script.println("<script>");
        script.println("alert('회원 탈퇴에 실패했습니다. 다시 시도해주세요.');");
        script.println("history.back();");
        script.println("</script>");
    } else if (result == -1) {
        script.println("<script>");
        script.println("alert('데이터베이스 오류.');");
        script.println("history.back();");
        script.println("</script>");
    }
    script.close();
%>