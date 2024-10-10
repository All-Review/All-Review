<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    String dbURL = "jdbc:mysql://localhost:3306/SSS";
    String dbID = "root";
    String dbPassword = "123123";
    Connection conn = null;
    PreparedStatement pstmt = null;

    String saveDir = application.getRealPath("/uploads"); // 이미지 저장 경로 설정
    int maxSize = 10 * 1024 * 1024; // 최대 파일 크기 (10MB)
    String encoding = "UTF-8";

    try {
        // 파일 업로드 처리
        MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize, encoding, new DefaultFileRenamePolicy());

        // 게시물 데이터 받기
        String title = multi.getParameter("title");
        String caption = multi.getParameter("caption");
        String rating = multi.getParameter("rating");

        // 이미지 파일들 받기
        Enumeration files = multi.getFileNames();
        List<String> imagePaths = new ArrayList<>();
        while (files.hasMoreElements()) {
            String fileElement = (String) files.nextElement();
            String fileName = multi.getFilesystemName(fileElement); // 실제 저장된 파일 이름 가져오기
            if (fileName != null) {
                imagePaths.add("/uploads/" + fileName); // 경로에 저장
            }
        }

        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

        // 1. 게시물 정보 저장
        String postSql = "INSERT INTO post (user_id, post_content, post_rate, post_tag, is_multiple_img) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(postSql, Statement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, "testUser"); // 유저 ID는 로그인 시스템이 있다면 받아오는 방식으로 변경
        pstmt.setString(2, caption);
        pstmt.setDouble(3, Double.parseDouble(rating));
        pstmt.setString(4, ""); 
        pstmt.setBoolean(5, imagePaths.size() > 1); // 여러 이미지가 있는지 여부
        pstmt.executeUpdate();

        // 생성된 게시물의 ID 가져오기
        ResultSet generatedKeys = pstmt.getGeneratedKeys();
        int postId = 0;
        if (generatedKeys.next()) {
            postId = generatedKeys.getInt(1);
        }

       
        String imageSql = "INSERT INTO images (post_id, image_path) VALUES (?, ?)";
        for (String imagePath : imagePaths) {
            pstmt = conn.prepareStatement(imageSql);
            pstmt.setInt(1, postId);
            pstmt.setString(2, imagePath);
            pstmt.executeUpdate();
        }

        // 성공 메시지
        out.println("<script>alert('게시물이 업로드되었습니다'); location.href='index.jsp';</script>");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('업로드에 실패했습니다.'); history.back();</script>");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
