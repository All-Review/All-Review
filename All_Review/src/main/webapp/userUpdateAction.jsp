<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.UserDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.File"%>

<%
    request.setCharacterEncoding("UTF-8");

    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int maxSize = 10 * 1024 * 1024;
    String uploadPath = application.getRealPath("/uploadsProfileimage");

    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs();
    }

    MultipartRequest multi = null;

    try {
        multi = new MultipartRequest(request, uploadPath, maxSize, "UTF-8");

        String newIntroduce = multi.getParameter("newIntroduce");
        String newNickname = multi.getParameter("newNickname");
        String newImage = multi.getFilesystemName("newImage");

        UserDAO userDAO = new UserDAO();
        UserDTO currentUser = userDAO.getUser(userID);

        if (newIntroduce == null || newIntroduce.trim().isEmpty()) {
            newIntroduce = currentUser.getUserIntroduce();
        }
        if (newNickname == null || newNickname.trim().isEmpty()) {
            newNickname = currentUser.getUserNickname();
        }
        if (newImage == null) { // 이미지 파일을 선택하지 않았을 때 기존 이미지 유지
            newImage = currentUser.getUserProfileImage();
        }

        int result = userDAO.updateUser(userID, newNickname, newIntroduce, newImage);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter script = response.getWriter();

        if (result == 1) {
            script.println("<script>");
            script.println("alert('프로필이 성공적으로 업데이트되었습니다.');");
            script.println("location.href='myPage.jsp';");
            script.println("</script>");
        } else if (result == 0) {
            script.println("<script>");
            script.println("alert('프로필 업데이트에 실패했습니다. 다시 시도해주세요.');");
            script.println("history.back();");
            script.println("</script>");
        } else if (result == -1) {
            script.println("<script>");
            script.println("alert('데이터베이스 오류가 발생했습니다.');");
            script.println("history.back();");
            script.println("</script>");
        }
        script.close();

    } catch (IOException e) {
        e.printStackTrace();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter script = response.getWriter();
        script.println("<script>");
        
        if (e.getMessage().contains("exceeds the maximum size")) {
            script.println("alert('업로드한 파일이 10MB를 초과합니다.');");
        } else {
            script.println("alert('파일 업로드 중 오류가 발생했습니다. " + e.getMessage() + "');");
        }
        
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
%> 