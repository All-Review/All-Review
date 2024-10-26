package follow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import comment.PostComment;
import util.DatabaseUtil;

public class FollowDAO {
	// 팔로우 추가
	public int createFollow (String follower, String following) {
		String sql = "insert into follow values(?, ?)";
		try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, follower);
    		pstmt.setString(2, following);

    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 나를 팔로우중인 사람 목록 읽어오기
	public List<Follow> readAllFollowers(String user_id) {
		String sql = "select * from follow where following=?";
		List<Follow> result = new ArrayList<>();
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, user_id);
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	Follow follow = new Follow(
                		rs.getString(1),
                		rs.getString(2)
                );
                result.add(follow);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 내가 팔로우중인 사람 목록 읽어오기
	public List<Follow> readAllFollowings(String user_id) {
		String sql = "select * from follow where follower=?";
		List<Follow> result = new ArrayList<>();
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, user_id);
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	Follow follow = new Follow(
                		rs.getString(1),
                		rs.getString(2)
                );
                result.add(follow);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}