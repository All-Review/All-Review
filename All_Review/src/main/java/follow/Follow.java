package follow;

public class Follow {
	private String follower; // 팔로우를 건 사람
	private String following; // 팔로우되는 사람
	
	public Follow() {}
	
	public Follow(String follower, String following) {
		super();
		this.follower = follower;
		this.following = following;
	}

	public String getFollower() {
		return follower;
	}
	public void setFollower(String follower) {
		this.follower = follower;
	}
	public String getFollowing() {
		return following;
	}
	public void setFollowing(String following) {
		this.following = following;
	}
}
