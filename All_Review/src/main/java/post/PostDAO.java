package post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DatabaseUtil;

public class PostDAO {
	
	public int createPost (Post post) {
		return -1;
	}
	
	// 글 하나 찾기
	public Post readOnePost (int postNum) {
    	String sql = "select * from post where post_num=?";
    	Post p = new Post();
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, postNum);
            ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()) {
                p = new Post(
                		rs.getInt(1),
                		rs.getString(2),
                		rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getDouble(6),
                        rs.getInt(7),
                        rs.getInt(8)
                );
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return p;
	}
	
	// 모든 게시물 찾기
	public List<Post> readAllPosts() {
		String sql = "select * from post";
		List<Post> result = new ArrayList<>();
		
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Post p = new Post(
                		rs.getInt(1),
                		rs.getString(2),
                		rs.getString(4),
                		rs.getString(5),
                        rs.getDouble(6),
                        rs.getInt(7),
                        rs.getInt(8)
                );
                result.add(p);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 특정 유저의 모든 게시물 찾기
	public List<Post> readAllPostsByUser(String userID) {
		String sql = "select * from post where userID=?";
		List<Post> result = new ArrayList<>();
		
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Post p = new Post(
                		rs.getInt(1),
                		rs.getString(2),
                		rs.getString(4),
                		rs.getString(5),
                        rs.getDouble(6),
                        rs.getInt(7),
                        rs.getInt(8)
                );
                result.add(p);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 게시물들의 평균 평점
	public double getAverageRate(List<Post> postLists) {
		double sum = 0;
		for (int i = 0; i < postLists.size(); i++) {
			sum += postLists.get(i).getRate();
		}
		double result = sum / postLists.size();
		return result;
	}
	
	// 태그 검색
	public List<Post> readSearchedPosts (String tagString) {
		String sql = "select * from post where post_tag=?";
		List<Post> result = new ArrayList<>();
		
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, tagString);
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Post p = new Post(
                		rs.getInt(1),
                		rs.getString(2),
                		rs.getString(4),
                		rs.getString(5),
                        rs.getDouble(6),
                        rs.getInt(7),
                        rs.getInt(8)
                );
                result.add(p);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
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

}
