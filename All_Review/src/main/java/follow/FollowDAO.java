package follow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import comment.PostComment;
import util.DatabaseUtil;

public class FollowDAO {
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
	
	// 팔로우 추가
	public int createFollow (String follower, String following) {
		String sql = "insert into follow values(?, ?)";
		try {
			conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, follower);
    		pstmt.setString(2, following);

    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConnection();
		}
		return -1;
	}
	
	// 나를 팔로우중인 사람 목록 읽어오기
	public List<Follow> readAllFollowers(String userID) {
		String sql = "select * from follow where following=?";
		List<Follow> result = new ArrayList<>();
    	try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	Follow follow = new Follow(
                		rs.getString(1),
                		rs.getString(2)
                );
                result.add(follow);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConnection();
		}
		
		return result;
	}
	
	// 내가 팔로우중인 사람 목록 읽어오기
	public List<Follow> readAllFollowings(String userID) {
		String sql = "select * from follow where follower=?";
		List<Follow> result = new ArrayList<>();
    	try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	Follow follow = new Follow(
                		rs.getString(1),
                		rs.getString(2)
                );
                result.add(follow);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConnection();
		}
		
		return result;
	}
	
	// 내가 팔로우 하고 있는 사람인지 확인
	public boolean isFollowing (String follower, String following) {
		String sql = "select * from follow where follower=? and following=?";
		List<Follow> result = new ArrayList<>();
    	try {
    		if (follower == null) {
    			return false;
    		}
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, follower);
    		pstmt.setString(2, following);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	Follow follow = new Follow(
                		rs.getString(1),
                		rs.getString(2)
                );
                result.add(follow);
            }
            
            if (result.size() > 0) {
        		return true;
        	}
            
    		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConnection();
		}
		
		return false;
	}
	
	// 내 팔로우 목록에서 삭제
	public int deletefollowing (String follower, String following) {
		String sql = "delete from follow where follower=? and following=?";
		try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, follower);
    		pstmt.setString(2, following);
    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConnection();
		}
		return -1;
	}
	
	// 팔로우 수 출력
	public int getFollowingNum (String follower) {
		String sql = "select count(*) from follow where follower=?";
		List<Follow> result = new ArrayList<>();
		try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, follower);
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
	
	// 팔로워 수 출력
	public int getFollowerNum (String following) {
		String sql = "select count(*) from follow where following=?";
		List<Follow> result = new ArrayList<>();
		try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, following);
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
