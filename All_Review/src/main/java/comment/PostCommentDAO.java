package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DatabaseUtil;

public class PostCommentDAO {
	// 댓글 목록 읽어오기
	public List<PostComment> readAllPostComments(int postNum) {
		String sql = "select * from comments where post_num=?";
		List<PostComment> result = new ArrayList<>();
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, postNum);
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
}
