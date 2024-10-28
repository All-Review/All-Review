package alarm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DatabaseUtil;

public class AlarmDAO {
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
    
	// 알람 생성
	public int createAlarm (int postIndex, String receiverID, String senderID, String alarmType) {
		String sql = "insert into alarms (alarm_index, post_index, receiverID, senderId, alarm_type, is_checked) values ((SELECT comment_seq('ALARM_SEQ') FROM dual), ?, ?, ?, ?, ?);";
		try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, postIndex);
    		pstmt.setString(2, receiverID);
    		pstmt.setString(3, senderID);
    		pstmt.setString(4, alarmType);
    		pstmt.setBoolean(5, false);
    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 알람 삭제
	public int deleteAlarm (int postIndex, String receiverID, String senderID) {
		String sql = "delete from alarms where post_index=? and receiverID=? and senderID=?;";
		try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, postIndex);
    		pstmt.setString(2, receiverID);
    		pstmt.setString(3, senderID);
    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 알람 가져오기
	public List<Alarm> readAllAlarms (String receiverID) {
		String sql = "select * from alarms where receiverID=?";
		List<Alarm> result = new ArrayList<>();
    	try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, receiverID);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Alarm alarm = new Alarm(
                		rs.getString(3),
                		rs.getString(4),
                		rs.getString(5),
                		rs.getBoolean(6)
                );
                result.add(alarm);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 알람 개수 업데이트
	public int updateAlarmNum (int alarmNum, String receiverID, boolean isPlus) {
		String sql = "update alarmNum set alarm_num=? where receiverID=?";
		try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		// 알람 추가하면 +1, 삭제하면 -1
    		if (isPlus) {
    			pstmt.setInt(1, alarmNum + 1);
    		} else {
    			pstmt.setInt(1, alarmNum - 1);
    		}
    		pstmt.setString(2, receiverID);
    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 알람 개수 초기화
	public int clearAlarmNum (String receiverID) {
		String sql = "update alarmNum set alarm_num=0 where receiverID=?";
		try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, receiverID);
    		return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 알람 개수 가져오기
	public int readAlarmNum (String receiverID) {
		String sql = "select * from alarmNum where receiverID=?";
		int result = 0;
    	try {
    		conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, receiverID);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	result = rs.getInt(2);
            }
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
