
package user;

public class UserDTO {

    private String userID;
    private String userPassword;
    private String userEmail;
    private String userName;
    private String userNickname;
    private String userProfileImage;
    private String userIntroduce;
    private int userPostNum;

    public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public String getUserProfileImage() {
		return userProfileImage;
	}

	public void setUserProfileImage(String userProfileImage) {
		this.userProfileImage = userProfileImage;
	}

	public String getUserIntroduce() {
		return userIntroduce;
	}

	public void setUserIntroduce(String userIntroduce) {
		this.userIntroduce = userIntroduce;
	}

	public int getUserPostNum() {
		return userPostNum;
	}

	public void setUserPostNum(int userPostNum) {
		this.userPostNum = userPostNum;
	}
	
	public UserDTO(String userID, String userPassword, String userEmail, String userName, String userNickname,
			String userProfileImage, String userIntroduce, int userPostNum) {
		super();
		this.userID = userID;
		this.userPassword = userPassword;
		this.userEmail = userEmail;
		this.userName = userName;
		this.userNickname = userNickname;
		this.userProfileImage = userProfileImage;
		this.userIntroduce = userIntroduce;
		this.userPostNum = userPostNum;
	}
}
