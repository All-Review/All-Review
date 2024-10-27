
package like;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import comment.PostComment;
import util.DatabaseUtil;

public class LikeDAO {
	// like 정보 등록
	public int createLike (int postIndex, String userID) {
		String sql = "insert into likes (post_index, user_id) values (?, ?)";
		try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, postIndex);
    		pstmt.setString(2, userID);
    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// like 정보 삭제
	public int deleteLike (int postIndex, String userID) {
		String sql = "delete from likes where post_index=? and user_id=?";
		try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, postIndex);
    		pstmt.setString(2, userID);
    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 유저가 게시물에 like 했는지 확인
	public Like isLiked (int postIndex, String userId) {
		String sql = "select * from likes where post_index=? and user_id=?";
		Like like = new Like();
		try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, postIndex);
    		pstmt.setString(2, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()) {
                like = new Like(
                		rs.getInt(1),
                		rs.getString(2)
                );
            }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return like;
	}
	
}
