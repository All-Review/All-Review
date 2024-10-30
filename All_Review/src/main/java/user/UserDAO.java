
package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {
	
	public int login(String userID, String userPassword) {

		String SQL = "SELECT user_password FROM user WHERE user_id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;
				}
				else {
					return 0;
				}
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		return -2;
	}
	
	public int join(UserDTO user) {

		String SQL = "INSERT INTO user (user_id, user_password, user_email, user_name, user_nickname, user_profileimage, user_introduce, user_post_num) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			 conn = DatabaseUtil.getConnection();
		     pstmt = conn.prepareStatement(SQL);
		     pstmt.setString(1, user.getUserID());
		     pstmt.setString(2, user.getUserPassword());
		     pstmt.setString(3, user.getUserEmail());
		     pstmt.setString(4, user.getUserName());
		     pstmt.setString(5, user.getUserNickname());
		     pstmt.setString(6, user.getUserProfileImage());
		     pstmt.setString(7, user.getUserIntroduce());
		     pstmt.setInt(8, user.getUserPostNum());
		     
		     return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		return -1;
	}
	
	public String getUserNicknameById(String userID) {
		String userNickname = "";
		
		String SQL = "SELECT user_nickname FROM user WHERE user_id = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
                userNickname = rs.getString("user_nickname");
            }
			
		} catch (Exception e) {
            e.printStackTrace();
        }
		
		return userNickname;
	}
	
	public String getUserIntroduceById(String userID) {
		String userIntroduce = "";
		
		String SQL = "SELECT user_introduce FROM user WHERE user_id = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				userIntroduce = rs.getString("user_introduce");
            }
			
		} catch (Exception e) {
            e.printStackTrace();
        }
		
		return userIntroduce;
	}
	
	public String getUserProfileimageById(String userID) {
		String userProfileimage = "";
		
		String SQL = "SELECT user_profileimage FROM user WHERE user_id = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID); 
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				userProfileimage = rs.getString("user_profileimage");
            }
		} catch (Exception e) {
            e.printStackTrace();
        }
		
		return userProfileimage;
	}
	
	public int deleteUser(String userID) {
        String SQL = "DELETE FROM user WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
        	conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            
            int result = pstmt.executeUpdate();
            return result > 0 ? 1 : 0;

        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
	
	public int updateUser(String userID, String newNickname, String newIntroduce, String newImage) {
	    String SQL = "UPDATE user SET user_nickname = ?, user_introduce = ?, user_profileimage = ? WHERE user_id = ?";
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    try {
	        conn = DatabaseUtil.getConnection();
	        pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, newNickname);
	        pstmt.setString(2, newIntroduce);
	        pstmt.setString(3, newImage);
	        pstmt.setString(4, userID);
	        
	        int result = pstmt.executeUpdate();
	        return result > 0 ? 1 : 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return -1;
	    } finally {
	        try {
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}
	
	public UserDTO getUser(String userID) {
	    UserDTO user = null;
	    String SQL = "SELECT * FROM user WHERE user_id = ?";
	    try (Connection conn = DatabaseUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(SQL)) {
	        
	        pstmt.setString(1, userID);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                user = new UserDTO(
	                    rs.getString("user_id"),
	                    rs.getString("user_password"),
	                    rs.getString("user_email"),
	                    rs.getString("user_name"),
	                    rs.getString("user_nickname"),
	                    rs.getString("user_profileimage"),
	                    rs.getString("user_introduce"),
	                    rs.getInt("user_post_num")
	                );
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return user;
	}

}
