package post;

import java.util.ArrayList;
import java.util.List;

public class Post {
    private int post_num;  // 게시물 번호
    private String userID;  // 사용자 ID
    private String postContent;  // 게시물 내용
    private String postImgUrl;  // 이미지 URL 문자열
    private String postTag;  // 게시물 태그
    private double postRate;  // 게시물 평점
    private int commentNum;  // 댓글 개수
    private int likeNum;  // 좋아요 개수
    private boolean isMultipleImg;  // 다중 이미지 여부
    private List<String> images;  // 이미지 리스트

    // 생성자
    public Post(int postNum, String userID, String postContent, String postImgUrl, 
                String postTag, double postRate, int commentNum, int likeNum, 
                boolean isMultipleImg) {
        this.post_num = postNum;
        this.userID = userID;
        this.postContent = postContent;
        this.postImgUrl = postImgUrl;
        this.postTag = postTag;
        this.postRate = postRate;
        this.commentNum = commentNum;
        this.likeNum = likeNum;
        this.isMultipleImg = isMultipleImg;
        this.images = new ArrayList<>();
    }

    // Getter 메서드들
    public int getPostNum() {
        return post_num;
    }

    public String getUserID() {
        return userID;
    }

    public String getPostContent() {
        return postContent;
    }

    public String getPostImgUrl() {
        return postImgUrl;
    }

    public String getPostTag() {
        return postTag;
    }

    public double getPostRate() {
        return postRate;
    }

    public int getCommentNum() {
        return commentNum;
    }

    public int getLikeNum() {
        return likeNum;
    }

    public boolean isMultipleImg() {
        return isMultipleImg;
    }

    public List<String> getImages() {
        return images;
    }

    // Setter 메서드들
    public void setPostNum(int post_num) {
        this.post_num = post_num;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }

    public void setPostImgUrl(String postImgUrl) {
        this.postImgUrl = postImgUrl;
    }

    public void setPostTag(String postTag) {
        this.postTag = postTag;
    }

    public void setPostRate(double postRate) {
        this.postRate = postRate;
    }

    public void setCommentNum(int commentNum) {
        this.commentNum = commentNum;
    }

    public void setLikeNum(int likeNum) {
        this.likeNum = likeNum;
    }

    public void setMultipleImg(boolean isMultipleImg) {
        this.isMultipleImg = isMultipleImg;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    // 이미지 추가 메서드
    public void addImage(String imageUrl) {
        if (this.images == null) {
            this.images = new ArrayList<>();
        }
        this.images.add(imageUrl);
    }
}
