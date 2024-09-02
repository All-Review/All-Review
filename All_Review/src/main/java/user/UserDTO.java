package user;

public class UserDTO {

    private String user_id;
    private String user_password;
    private String user_email;
    private String user_name;
    private String user_nickname;
    private String user_profileImage;
    private String user_introduce;
    private int user_postNum;

    public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_password() {
		return user_password;
	}

	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}

	public String getUser_profileImage() {
		return user_profileImage;
	}

	public void setUser_profileImage(String user_profileImage) {
		this.user_profileImage = user_profileImage;
	}

	public String getUser_introduce() {
		return user_introduce;
	}

	public void setUser_introduce(String user_introduce) {
		this.user_introduce = user_introduce;
	}

	public int getUser_postNum() {
		return user_postNum;
	}

	public void setUser_postNum(int user_postNum) {
		this.user_postNum = user_postNum;
	}
	
	public UserDTO(String user_id, String user_password, String user_email, String user_name, String user_nickname,
			String user_profileImage, String user_introduce, int user_postNum) {
		super();
		this.user_id = user_id;
		this.user_password = user_password;
		this.user_email = user_email;
		this.user_name = user_name;
		this.user_nickname = user_nickname;
		this.user_profileImage = user_profileImage;
		this.user_introduce = user_introduce;
		this.user_postNum = user_postNum;
	}
}