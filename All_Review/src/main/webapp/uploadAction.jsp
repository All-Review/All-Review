<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, javax.servlet.*, javax.servlet.http.*, java.nio.file.*" %>
<%
    String title = request.getParameter("title");
    String caption = request.getParameter("caption");
    String rating = request.getParameter("rating");
    String userID = (String) session.getAttribute("userID");

    // 여러 파일을 처리하기 위한 부분
    Collection<Part> fileParts = request.getParts(); 
    StringBuilder imagePaths = new StringBuilder(); // 여러 파일 경로를 저장할 StringBuilder
    
    for (Part filePart : fileParts) {
        if (filePart.getName().equals("files")) {  
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "upload" + File.separator + fileName;

            // 파일 저장
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, new File(uploadPath).toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            
            if (imagePaths.length() > 0) {
                imagePaths.append(","); // 여러 파일 경로를 콤마로 구분
            }
            imagePaths.append(fileName);
        }
    }

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdatabase", "username", "password");

        
        String sql = "INSERT INTO posts (title, caption, image_path, rating, user_id) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, title);
        stmt.setString(2, caption);
        stmt.setString(3, imagePaths.toString()); // 여러 파일 경로를 하나의 문자열로 저장
        stmt.setInt(4, Integer.parseInt(rating));
        stmt.setString(5, userID);
        
        int result = stmt.executeUpdate();
        if (result > 0) {
            out.println("게시물이 성공적으로 업로드되었습니다!");
        } else {
            out.println("업로드 실패. 다시 시도해주세요.");
        }

        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
%>
