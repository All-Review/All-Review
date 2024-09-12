package like;

public class Like {
	private int postIndex;
	private String userId;
	
	public Like () {}
	
	public Like (int postIndex, String userId) {
		super();
		this.postIndex = postIndex;
		this.userId = userId;
	}
	
	public int getPostIndex() {
		return postIndex;
	}
	public void setPostIndex(int postIndex) {
		this.postIndex = postIndex;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
}
