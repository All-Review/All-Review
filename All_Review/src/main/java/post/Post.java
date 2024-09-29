package post;

public class Post {
	private int postID;
	private String userID;
	private String postContent;
	private String imagePath;
	private String postTag;
	private double postRate;
	private int commentNum;
	private int likeNum;
	private boolean isMultipleImg;
	
	public Post() {}
	
	public Post(int postID, String userID, String imagePath, String postTag, double postRate, int commentNum, int likeNum, boolean isMultipleImg) {
		super();
		this.userID = userID;
		this.postID = postID;
		this.imagePath = imagePath;
		this.postTag = postTag;
		this.postRate = postRate;
		this.commentNum = commentNum;
		this.likeNum = likeNum;
		this.isMultipleImg = isMultipleImg;
	}
	
	public Post(int postID, String userID, String postContent, String imagePath, String postTag, double postRate, int commentNum, int likeNum, boolean isMultipleImg) {
		super();
		this.postID = postID;
		this.userID = userID;
		this.postContent = postContent;
		this.imagePath = imagePath;
		this.postTag = postTag;
		this.postRate = postRate;
		this.commentNum = commentNum;
		this.likeNum = likeNum;
		this.isMultipleImg = isMultipleImg;
	}
	
	public int getPostId () {
		return postID;
	}
	
	public String getUserID() {
		return userID;
	}
	
	public String getPostContent () {
		return postContent;
	}
	public void setPostContent (String postContent) {
		this.postContent = postContent;
	}
	
	public String getImagePath () {
		return imagePath;
	}
	public void setImagePath (String imagePath) {
		this.imagePath = imagePath;
	}
	
	public String getPostTag () {
		return postTag;
	}
	public void setPostTag (String postTag) {
		this.postTag = postTag;
	}
	
	public double getPostRate () {
		return postRate;
	}
	public void setPostRate (double postRate) {
		this.postRate = postRate;
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
	
	public boolean getIsMultipleImg () {
		return isMultipleImg;
	}
	public void setIsMultipleImg (boolean isMultipleImg) {
		this.isMultipleImg = isMultipleImg;
	}

}
