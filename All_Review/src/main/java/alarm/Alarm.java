package alarm;

public class Alarm {
	private int alarmIndex; // 알람 고유 번호
	private String receiverID; // 알람 받는 유저 아이디
	private String senderID; // 알람 보내는 유저 아이디
	private String alarmType; // 알람 내용 (댓글)
	
	public Alarm() {}
	
	public Alarm(int alarmIndex, String receiverID, String senderID, String alarmType) {
		super();
		this.alarmIndex = alarmIndex;
		this.receiverID = receiverID;
		this.senderID = senderID;
		this.alarmType = alarmType;
	}
	
	public Alarm(String receiverID, String senderID, String alarmType) {
		super();
		this.receiverID = receiverID;
		this.senderID = senderID;
		this.alarmType = alarmType;
	}
	
	public String getReceiverID() {
		return receiverID;
	}
	public void setReceiverID(String receiverID) {
		this.receiverID = receiverID;
	}
	
	public String getSenderID() {
		return senderID;
	}
	public void setSenderID(String senderID) {
		this.senderID = senderID;
	}
	
	public String getAlarmType() {
		return alarmType;
	}
	public void setAlarmType(String alarmType) {
		this.alarmType = alarmType;
	}

}
