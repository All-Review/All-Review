<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<%@ page import="post.Post" %>


<%
    
    String dbURL = "jdbc:mysql://localhost:3306/SSS";
    String dbID = "root";
    String dbPassword = "123123";
    Connection conn = null;
    Statement statement = null;
    ResultSet resultSet = null;
    List<Post> posts = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 

        
        String sql = "SELECT * FROM post";
        statement = conn.createStatement();
        resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            int postId = resultSet.getInt("post_num");
            String userId = resultSet.getString("user_id");
            String caption = resultSet.getString("post_content");
            String postTag = resultSet.getString("post_tag");
            double rating = resultSet.getDouble("post_rate");
            boolean isMultipleImg = resultSet.getBoolean("is_multiple_img");

            List<String> images = new ArrayList<>();
            
            String imageSql = "SELECT image_path FROM images WHERE post_id = ?";
            PreparedStatement imageStmt = conn.prepareStatement(imageSql);
            imageStmt.setInt(1, postId);
            ResultSet imageRs = imageStmt.executeQuery();
            while (imageRs.next()) {
                images.add(imageRs.getString("image_path"));
            }

           
            Post post = new Post(postId, userId, caption, postTag, rating, 0, 0, isMultipleImg, images);
            posts.add(post);
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 목록</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/main_content.css">
    <link rel="stylesheet" href="css/sidebar.css">
    <link rel="stylesheet" href="css/overlay.css">
    <link rel="stylesheet" href="css/setting.css">
    <link rel="stylesheet" href="css/displaySize.css">
    <link rel="stylesheet" href="css/deleteui.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="js/content_detail.js"></script>
    <script src="js/setting.js"></script>
</head>
<body>
    <%
        String userID = (String) session.getAttribute("userID");
    %>
    <!-- 왼쪽 네비게이션 바 -->
    <aside id="sidebar">
        <a href="index.jsp"><span>All Review 올리</span></a>
        <ul id="sidebarIcon">
            <li><a href="index.jsp"><span>홈</span></a></li>
            <li><a href="search.jsp"><span>검색</span></a></li>
            <li><a href="alert_page.html"><span>알림</span></a></li>
            <li id="settingBtn"><a href="#"><span>설정</span></a></li>
            <li><a href="#"><span>프로필</span></a></li>
            <li><a href="writePage.jsp"><span>게시하기</span></a></li>
        </ul>
        <ul id="sidebarUserIcon">
            <%
                if (userID == null) {
            %>
            <li id="loginBtn"><a href="userLogin.jsp"><span>로그인</span></a></li>
            <li id="joinBtn"><a href="userJoin.jsp"><span>회원가입</span></a></li>
            <%
                } else {
            %>
            <li id="LogoutBtn"><a href="userLogout.jsp"><span>로그아웃</span></a></li>
            <%
                }
            %>
        </ul>
    </aside>

    <div id="content">
        <ul>
            <%
            for (Post post : posts) {
                int postId = post.getPostId();
                List<String> images = post.getImages();
            %>
                <li>
                    <h2>게시물 ID: <%= postId %></h2>
                    <p>내용: <%= post.getPostContent() %></p>
                    <div>
                        <%
                        for (String image : images) {
                        %>
                            <img src="<%= image %>" alt="Image" style="width:100px;height:auto;"/>
                        <%
                        }
                        %>
                    </div>
                </li>
            <%
            }
            %>
        </ul>
    </div>
</body>
</html>

