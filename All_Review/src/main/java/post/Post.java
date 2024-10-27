package post;

import java.util.ArrayList;
import java.util.List;

public class Post {
    private int postNum;  // 게시물 번호
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
        this.postNum = postNum;
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
        return postNum;
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

    // 이미지 추가 메서드
    public void addImage(String imageUrl) {
        if (this.images == null) {
            this.images = new ArrayList<>();
        }
        this.images.add(imageUrl);
    }

    public void setImages(List<String> images) {
        this.images = images;
    }
}
