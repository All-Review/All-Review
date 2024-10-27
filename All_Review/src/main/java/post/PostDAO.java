package post;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import util.DatabaseUtil;

public class PostDAO {

    // 게시물 생성
    public int createPost(Post post) {
        String sql = "INSERT INTO post (userID, post_content, post_img_url, post_tag, post_rate, comment_num, like_num, is_multiple_img) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, post.getUserID());
            pstmt.setString(2, post.getPostContent());
            pstmt.setString(3, post.getPostImgUrl());
            pstmt.setString(4, post.getPostTag());
            pstmt.setDouble(5, post.getPostRate());
            pstmt.setInt(6, post.getCommentNum());
            pstmt.setInt(7, post.getLikeNum());
            pstmt.setBoolean(8, post.isMultipleImg());

            return pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 특정 게시물 조회
    public Post readOnePost(int postNum) {
        String sql = "SELECT * FROM post WHERE post_num=?";
        Post post = null;

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, postNum);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    post = new Post(
                        rs.getInt("post_num"),
                        rs.getString("userID"),
                        rs.getString("post_content"),
                        rs.getString("post_img_url"),
                        rs.getString("post_tag"),
                        rs.getDouble("post_rate"),
                        rs.getInt("comment_num"),
                        rs.getInt("like_num"),
                        rs.getBoolean("is_multiple_img")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return post;
    }

	// 댓글 입력 시 게시물의 댓글개수 업데이트
	public int updateCommentNum (int postNum, Post post, boolean isDelete) {
		String sql = "update post set comment_num=? where post_num=?";
		try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		// 댓글 삭제면 -1, 댓글 추가면 +1
    		if (isDelete) {
        		pstmt.setInt(1, post.getCommentNum() - 1);
    		} else {
        		pstmt.setInt(1, post.getCommentNum() + 1);
    		}
    		pstmt.setInt(2, postNum);
    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

    // 모든 게시물 조회
    public List<Post> readAllPosts() {
        List<Post> result = new ArrayList<>();
        String sql = "SELECT * FROM post";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Post post = new Post(
                    rs.getInt("post_num"),
                    rs.getString("userID"),
                    rs.getString("post_content"),
                    rs.getString("post_img_url"),
                    rs.getString("post_tag"),
                    rs.getDouble("post_rate"),
                    rs.getInt("comment_num"),
                    rs.getInt("like_num"),
                    rs.getBoolean("is_multiple_img")
                );
                result.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // 이미지 URL 분리
    public List<String> splitImages(String postImgUrl) {
        return Arrays.asList(postImgUrl.split(","));
    }

}
