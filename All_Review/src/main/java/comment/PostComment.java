package comment;

public class PostComment {
	private int postNum; // 몇 번 게시물의 댓글인지
	private int commentNum; // 댓글 고유번호
	private String userId; // 사용자 아이디(고유)
	private String nickname; // 사용자 닉네임
	private String userImgUrl; // 사용자 프로필사진 주소
	private String commentContent; // 댓글 내용
	private double commentRate; // 댓글 별점
	private String commentCreateAt; // 댓글 생성 시간
	
	public PostComment() {}
	
	public PostComment(int postNum, String userId, String nickname, String userImgUrl, String commentContent, double commentRate, String commentCreatedAt) {
		this.postNum = postNum;
		this.userId = userId;
		this.nickname = nickname;
		this.userImgUrl = userImgUrl;
		this.commentContent = commentContent;
		this.commentRate = commentRate;
		this.commentCreateAt = commentCreatedAt;
	}
	
	// 댓글 읽어오기 전용
	public PostComment(int postNum, int commentNum, String userId, String nickname, String userImgUrl, String commentContent, double commentRate, String commentCreatedAt) {
		this.postNum = postNum;
		this.commentNum = commentNum;
		this.userId = userId;
		this.nickname = nickname;
		this.userImgUrl = userImgUrl;
		this.commentContent = commentContent;
		this.commentRate = commentRate;
		this.commentCreateAt = commentCreatedAt;
	}
	
	public int getPostNum() {
		return postNum;
	}
	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}

	public int getCommentNum() {
		return commentNum;
	}
	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
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
	
	public String getUserImgUrl() {
		return userImgUrl;
	}
	public void setUserImgUrl(String userImgUrl) {
		this.userImgUrl = userImgUrl;
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
