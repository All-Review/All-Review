package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DatabaseUtil;

public class PostCommentDAO {
	// 댓글 작성
	public int createComment (PostComment comment) {
		String sql = "insert into comments (post_index, comment_index, user_id, user_nickname, user_profileimage, comment_content, comment_rate, comment_created_at) values (?, (SELECT comment_seq('COMMENT_SEQ') FROM dual), ?, ?, ?, ?, ?, ?)";
		try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, comment.getPostIndex());
    		pstmt.setString(2, comment.getUserId());
    		pstmt.setString(3, comment.getNickname());
    		pstmt.setString(4, comment.getUserProfileImage());
    		pstmt.setString(5, comment.getCommentContent());
    		pstmt.setDouble(6, comment.getCommentRate());
    		pstmt.setString(7, comment.getCommentCreateAt());
    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	

	
	// 댓글 목록 읽어오기
	public List<PostComment> readAllPostComments(int postIndex) {
		String sql = "select * from comments where post_index=?";
		List<PostComment> result = new ArrayList<>();
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, postIndex);
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()) {
                PostComment comment = new PostComment(
                		rs.getInt(1),
                		rs.getInt(2),
                		rs.getString(3),
                		rs.getString(4),
                		rs.getString(5),
                        rs.getString(6),
                        rs.getDouble(7),
                        rs.getString(8)
                );
                result.add(comment);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 댓글 하나 찾기
	public PostComment readOneComment (int commentIndex) {
    	String sql = "select * from comments where comment_index=?";
    	PostComment comment = new PostComment();
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, commentIndex);
            ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()) {
                comment = new PostComment(
                		rs.getInt(1),
                		rs.getInt(2),
                		rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getDouble(7),
                        rs.getString(8)
                );
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return comment;
	}
	
	// 댓글 수정
	public int updateComment (int commentIndex, String commentContent, double commentRate) {
		String sql = "update comments set comment_content=?, comment_rate=? where comment_index=?";
		try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, commentContent);
    		pstmt.setDouble(2, commentRate);
    		pstmt.setInt(3, commentIndex);
    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 댓글 삭제
	public int deleteComment (int postIndex, int commentIndex) {
		String sql = "delete from comments where post_index=? and comment_index=?";
		try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, postIndex);
    		pstmt.setInt(2, commentIndex);
    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
}