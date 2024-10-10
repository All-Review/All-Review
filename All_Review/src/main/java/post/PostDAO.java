package post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import util.DatabaseUtil;

public class PostDAO {

    // 게시물 하나 읽기
    public Post readOnePost(int postNum) {
        String sql = "SELECT * FROM post WHERE post_num=?";
        Post p = null;
        try {
            Connection conn = DatabaseUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postNum);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                List<String> images = new ArrayList<>();
                String imageSql = "SELECT image_path FROM images WHERE post_id = ?";
                PreparedStatement imageStmt = conn.prepareStatement(imageSql);
                imageStmt.setInt(1, postNum);
                ResultSet imageRs = imageStmt.executeQuery();
                while (imageRs.next()) {
                    images.add(imageRs.getString("image_path"));
                }
                
                p = new Post(
                        rs.getInt("post_num"),
                        rs.getString("user_id"),
                        rs.getString("post_content"),
                        rs.getString("post_tag"),
                        rs.getDouble("post_rate"),
                        rs.getInt("comment_num"),
                        rs.getInt("like_num"),
                        rs.getBoolean("is_multiple_img"),
                        images
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }

    // 모든 게시물 읽기
    public List<Post> readAllPosts() {
        String sql = "SELECT * FROM post";
        List<Post> result = new ArrayList<>();

        try {
            Connection conn = DatabaseUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("post_num");
                List<String> images = new ArrayList<>();
                String imageSql = "SELECT image_path FROM images WHERE post_id = ?";
                PreparedStatement imageStmt = conn.prepareStatement(imageSql);
                imageStmt.setInt(1, postId);
                ResultSet imageRs = imageStmt.executeQuery();
                while (imageRs.next()) {
                    images.add(imageRs.getString("image_path"));
                }

                Post p = new Post(
                        postId,
                        rs.getString("user_id"),
                        rs.getString("post_content"),
                        rs.getString("post_tag"),
                        rs.getDouble("post_rate"),
                        rs.getInt("comment_num"),
                        rs.getInt("like_num"),
                        rs.getBoolean("is_multiple_img"),
                        images
                );
                result.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}

