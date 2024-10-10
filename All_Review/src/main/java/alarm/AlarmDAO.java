package alarm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DatabaseUtil;

public class AlarmDAO {
	// 알람 생성
	public int createAlarm (String receiverID, String senderID, String alarmType) {
		String sql = "insert into alarms (alarm_index, receiverID, senderId, alarm_type) values ((SELECT comment_seq('ALARM_SEQ') FROM dual), ?, ?, ?);";
		try {
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, receiverID);
    		pstmt.setString(2, senderID);
    		pstmt.setString(3, alarmType);
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
    		Connection conn = DatabaseUtil.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, receiverID);
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Alarm alarm = new Alarm(
                		rs.getString(2),
                		rs.getString(3),
                		rs.getString(4)
                );
                result.add(alarm);
            }
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
