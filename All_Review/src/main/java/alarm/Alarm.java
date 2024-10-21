package alarm;

public class Alarm {
	private int alarmIndex; // 알람 고유 번호
	private int postIndex; // 알람이 발생한 게시글 번호 (null 가능)
	private String receiverID; // 알람 받는 유저 아이디
	private String senderID; // 알람 보내는 유저 아이디
	private String alarmType; // 알람 내용 (댓글)
	private boolean isChecked; // 받는 유저가 알림을 확인했는지
	
	public Alarm() {}
	
	public Alarm(int alarmIndex, int postIndex, String receiverID, String senderID, String alarmType, boolean isChecked) {
		super();
		this.alarmIndex = alarmIndex;
		this.postIndex = postIndex;
		this.receiverID = receiverID;
		this.senderID = senderID;
		this.alarmType = alarmType;
		this.isChecked = isChecked;
	}
	
	public Alarm(String receiverID, String senderID, String alarmType, boolean isChecked) {
		super();
		this.receiverID = receiverID;
		this.senderID = senderID;
		this.alarmType = alarmType;
		this.isChecked = isChecked;
	}
	
	public int getPostIndex() {
		return postIndex;
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
	
	public boolean getIsChecked() {
		return isChecked;
	}
	public void setIsChecked(boolean isChecked) {
		this.isChecked = isChecked;
	}

}
