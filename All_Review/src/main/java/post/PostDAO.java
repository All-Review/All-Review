package post;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import follow.Follow;
import util.DatabaseUtil;

public class PostDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// 커넥션 해제
    private void closeConnection () {
        if (rs != null) try { rs.close(); } catch (Exception ignored) { }
        if (pstmt != null) try { pstmt.close(); } catch (Exception ignored) { }
        if (conn != null) try { conn.close(); } catch (Exception ignored) { }
        rs = null;
        pstmt = null;
        conn = null;
    }

    // 게시물 생성
	public int createPost(Post post) {
	    String sql = "INSERT INTO post (userID, post_content, post_img_url, post_tag, post_rate, is_multiple_img) VALUES (?, ?, ?, ?, ?, ?)";
	    try (Connection conn = DatabaseUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, post.getUserID());
	        pstmt.setString(2, post.getPostContent());
	        pstmt.setString(3, post.getPostImgUrl());
	        pstmt.setString(4, post.getPostTag());
	        pstmt.setDouble(5, post.getPostRate());
	        pstmt.setBoolean(6, post.isMultipleImg());

	        int result = pstmt.executeUpdate();
	        if (result > 0) {
	            System.out.println("게시물 생성 성공");
	        }
	        return result;

	    } catch (SQLException e) {
	        System.err.println("게시물 생성 실패: " + e.getMessage());
	        e.printStackTrace();
	        return -1;
	    }
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
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
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
		} finally {
			closeConnection();
		}
		return -1;
	}
	
	// 좋아요 클릭 시 게시물의 좋아요 개수 업데이트
			public int updateLikeNum (int postNum, Post post, boolean isLiked) {
				String sql = "update post set like_num=? where post_num=?";
				try {
		    		conn = DatabaseUtil.getConnection();
		    		pstmt = conn.prepareStatement(sql);
		    		// 좋아요 누른 상태면 -1, 안누른 상태면 +1
		    		if (isLiked) {
		        		pstmt.setInt(1, post.getLikeNum() - 1);
		    		} else {
		        		pstmt.setInt(1, post.getLikeNum() + 1);
		    		}
		    		pstmt.setInt(2, postNum);
		    		return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					closeConnection();
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
    
 // 게시물 삭제 메서드
    public int deletePost(int postNum) {
        String sql = "DELETE FROM post WHERE post_num = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, postNum);
            return pstmt.executeUpdate(); 

        } catch (SQLException e) {
            e.printStackTrace();
            return -1;  // 오류 발생 시 -1 반환
        }
    }
    
	// 게시물들의 평균 평점
	public double getAverageRate(List<Post> postLists) {
		double sum = 0;
		for (int i = 0; i < postLists.size(); i++) {
			sum += postLists.get(i).getPostRate();
		}
		double result = sum / postLists.size();
		return result;
	}
	
	// 태그 검색
	public List<Post> readSearchedPosts (String tagString) {
		String sql = "select * from post where post_tag=?";
		List<Post> result = new ArrayList<>();
		
    	try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, tagString);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Post p = new Post(
                		rs.getInt(1),
                		rs.getString(2),
                		rs.getString(3),
                		rs.getString(4),
                		rs.getString(5),
                        rs.getDouble(6),
                        rs.getInt(7),
                        rs.getInt(8),
                        rs.getBoolean(9)
                );
                result.add(p);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConnection();
		}
		
		return result;
	}
	
	// 특정 유저의모든 게시물 조회
	public List<Post> readAllPostsByUser(String userID) {
		List<Post> result = new ArrayList<>();
		String sql = "SELECT * FROM post where userID=?";
    	try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	Post post = new Post(
                		rs.getInt(1),
                		rs.getString(2),
                		rs.getString(3),
                		rs.getString(4),
                		rs.getString(5),
                        rs.getDouble(6),
                        rs.getInt(7),
                        rs.getInt(8),
                        rs.getBoolean(9)
                );
                result.add(post);
            }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConnection();
		}
		return result;
	}

	// 특정 유저의 게시물 수 출력
	public int getUserPostNum (String userID) {
		String sql = "select count(*) from post where userID=?";
		List<Post> result = new ArrayList<>();
		try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, userID);
    		rs = pstmt.executeQuery();
    		rs.next();
    		return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConnection();
		}
		return -1;
	}

}
