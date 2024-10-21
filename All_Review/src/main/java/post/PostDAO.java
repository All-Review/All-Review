package post;

import java.sql.*;
import java.util.*;
import util.DatabaseUtil;

public class PostDAO {
    // 게시물 생성 (기능 미구현)
    public int createPost(Post post) {
        return -1;
    }

    // 특정 게시물 조회
    public Post readOnePost(int postNum) {
        String sql = "SELECT * FROM post WHERE post_num=?";
        Post post = null;

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, postNum);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                post = new Post(
                    rs.getInt(1), rs.getString(2), rs.getString(3),
                    rs.getString(4), rs.getString(5), rs.getDouble(6),
                    rs.getInt(7), rs.getInt(8), rs.getBoolean(9)
                );
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }

    // 모든 게시물 조회
    public List<Post> readAllPosts() {
        String sql = "SELECT * FROM post";
        List<Post> result = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Post post = new Post(
                    rs.getInt(1), rs.getString(2), rs.getString(3),
                    rs.getString(4), rs.getString(5), rs.getDouble(6),
                    rs.getInt(7), rs.getInt(8), rs.getBoolean(9)
                );
                result.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // 특정 유저의 게시물 조회
    public List<Post> readAllPostsByUser(String userID) {
        String sql = "SELECT * FROM post WHERE userID=?";
        List<Post> result = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Post post = new Post(
                    rs.getInt(1), rs.getString(2), rs.getString(3),
                    rs.getString(4), rs.getString(5), rs.getDouble(6),
                    rs.getInt(7), rs.getInt(8), rs.getBoolean(9)
                );
                result.add(post);
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // 게시물 이미지 경로 분리
    public List<String> splitImages(String str) {
        if (str == null || str.isEmpty()) return new ArrayList<>();
        return Arrays.asList(str.split(","));
    }

    // 댓글 수 업데이트
    public int updateCommentNum(int postNum, int currentCommentNum, boolean isDelete) {
        String sql = "UPDATE post SET comment_num=? WHERE post_num=?";
        int newCommentNum = isDelete ? currentCommentNum - 1 : currentCommentNum + 1;

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, newCommentNum);
            pstmt.setInt(2, postNum);
            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 좋아요 수 업데이트
    public int updateLikeNum(int postNum, int currentLikeNum, boolean isLiked) {
        String sql = "UPDATE post SET like_num=? WHERE post_num=?";
        int newLikeNum = isLiked ? currentLikeNum - 1 : currentLikeNum + 1;

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, newLikeNum);
            pstmt.setInt(2, postNum);
            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 게시물의 평균 평점 계산
    public double getAverageRate(List<Post> postList) {
        if (postList.isEmpty()) return 0;
        double sum = 0;
        for (Post post : postList) {
            sum += post.getPostRate();
        }
        return sum / postList.size();
    }

    // 태그 검색
    public List<Post> readSearchedPosts(String tag) {
        String sql = "SELECT * FROM post WHERE post_tag=?";
        List<Post> result = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, tag);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Post post = new Post(
                    rs.getInt(1), rs.getString(2), rs.getString(3),
                    rs.getString(4), rs.getString(5), rs.getDouble(6),
                    rs.getInt(7), rs.getInt(8), rs.getBoolean(9)
                );
                result.add(post);
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
