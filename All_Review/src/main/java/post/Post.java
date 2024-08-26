package post;

public class Post {
	private int postNum;
	private String userID;
	private String content;
	private String postUrl;
	private String postTag;
	private double rate;
	private int commentNum;
	private int likeNum;
	
	public Post() {}
	
	public Post(int postNum, String userID, String postUrl, String postTag, double rate, int commentNum, int likeNum) {
		super();
		this.userID = userID;
		this.postNum = postNum;
		this.postUrl = postUrl;
		this.postTag = postTag;
		this.rate = rate;
		this.commentNum = commentNum;
		this.likeNum = likeNum;
	}
	
	public Post(int postNum, String userID, String content, String postUrl, String postTag, double rate, int commentNum, int likeNum) {
		super();
		this.postNum = postNum;
		this.userID = userID;
		this.content = content;
		this.postUrl = postUrl;
		this.postTag = postTag;
		this.rate = rate;
		this.commentNum = commentNum;
		this.likeNum = likeNum;
	}
	
	public int getPostNum () {
		return postNum;
	}
	
	public String getUserID() {
		return userID;
	}
	
	public String getContent () {
		return content;
	}
	public void setContent (String content) {
		this.content = content;
	}
	
	public String getPostUrl () {
		return postUrl;
	}
	public void setPostUrl (String postUrl) {
		this.postUrl = postUrl;
	}
	
	public String getPostTag () {
		return postTag;
	}
	public void setPostTag (String postTag) {
		this.postTag = postTag;
	}
	
	public double getRate () {
		return rate;
	}
	public void setRate (double rate) {
		this.rate = rate;
	}
	
	public int getCommentNum () {
		return commentNum;
	}
	public void setCommentNum (int commentNum) {
		this.commentNum = commentNum;
	}
	
	public int getLikeNum () {
		return likeNum;
	}
	public void setLikeNum (int likeNum) {
		this.likeNum = likeNum;
	}

}
