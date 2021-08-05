package chat;

public class ChatRoom {
private String operator,roomName,roomPW,roomIntro,openDate;
public String getOpenDate() {
	return openDate;
}

public void setOpenDate(String openDate) {
	this.openDate = openDate;
}

public int getRoomBNO() {
	return roomBNO;
}

public void setRoomBNO(int roomBNO) {
	this.roomBNO = roomBNO;
}

private int roomBNO;


public String getOperator() {
	return operator;
}

public void setOperator(String operator) {
	this.operator = operator;
}

public String getRoomName() {
	return roomName;
}

public void setRoomName(String roomName) {
	this.roomName = roomName;
}

public String getRoomPW() {
	return roomPW;
}

public void setRoomPW(String roomPW) {
	this.roomPW = roomPW;
}

public String getRoomIntro() {
	return roomIntro;
}

public void setRoomIntro(String roomIntro) {
	this.roomIntro = roomIntro;
}
}
