
package comment;

public class PostComment {
	private int postIndex; // 몇 번 게시물의 댓글인지
	private int commentIndex; // 댓글 고유번호
	private String userId; // 사용자 아이디(고유)
	private String nickname; // 사용자 닉네임
	private String userProfileImage; // 사용자 프로필사진 주소
	private String commentContent; // 댓글 내용
	private double commentRate; // 댓글 별점
	private String commentCreateAt; // 댓글 생성 시간
	
	public PostComment() {}
	
	public PostComment(int postNum, String userId, String nickname, String userProfileImage, String commentContent, double commentRate, String commentCreatedAt) {
		this.postIndex = postNum;
		this.userId = userId;
		this.nickname = nickname;
		this.userProfileImage = userProfileImage;
		this.commentContent = commentContent;
		this.commentRate = commentRate;
		this.commentCreateAt = commentCreatedAt;
	}
	
	// 댓글 읽어오기 전용
	public PostComment(int postNum, int commentIndex, String userId, String nickname, String userProfileImage, String commentContent, double commentRate, String commentCreatedAt) {
		this.postIndex = postNum;
		this.commentIndex = commentIndex;
		this.userId = userId;
		this.nickname = nickname;
		this.userProfileImage = userProfileImage;
		this.commentContent = commentContent;
		this.commentRate = commentRate;
		this.commentCreateAt = commentCreatedAt;
	}
	
	public int getPostIndex() {
		return postIndex;
	}
	public void setPostIndex(int postNum) {
		this.postIndex = postNum;
	}

	public int getCommentIndex() {
		return commentIndex;
	}
	public void setCommentIndex(int commentIndex) {
		this.commentIndex = commentIndex;
	}

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getUserProfileImage() {
		return userProfileImage;
	}
	public void setUserProfileImage(String userProfileImage) {
		this.userProfileImage = userProfileImage;
	}
	
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	
	public double getCommentRate() {
		return commentRate;
	}
	public void setCommentRate(double commentRate) {
		this.commentRate = commentRate;
	}

	public String getCommentCreateAt() {
		return commentCreateAt;
	}

	public void setCommentCreateAt(String commentCreateAt) {
		this.commentCreateAt = commentCreateAt;
	}
}
