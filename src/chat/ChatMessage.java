package chat;

public class ChatMessage {
	private String userID, chatRoomBNO, message, sendDate;

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getChatRoomBNO() {
		return chatRoomBNO;
	}

	public void setChatRoomBNO(String chatRoomBNO) {
		this.chatRoomBNO = chatRoomBNO;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getSendDate() {
		return sendDate;
	}

	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}

}
