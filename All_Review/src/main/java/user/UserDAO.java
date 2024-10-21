package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {
	
	public int login(String userID, String userPassword) { // 로그인

		String SQL = "SELECT user_password FROM user WHERE user_id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); // 데이터 조회
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
		} // 사용후 자원 해제
		return -2;
	}
	
	public int join(UserDTO user) { // 회원가입

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
			return pstmt.executeUpdate(); // 업데이트
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
		} // 사용후 자원 해제
		return -1;
	}
}
