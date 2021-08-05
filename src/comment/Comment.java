package comment;

public class Comment {
private String commentBNO, boardBNO, userID, content, writeDate, recommend;

public String getCommentBNO() {
	return commentBNO;
}

public void setCommentBNO(String commentBNO) {
	this.commentBNO = commentBNO;
}

public String getBoardBNO() {
	return boardBNO;
}

public void setBoardBNO(String boardBNO) {
	this.boardBNO = boardBNO;
}

public String getUserID() {
	return userID;
}

public void setUserID(String userID) {
	this.userID = userID;
}

public String getContent() {
	return content;
}

public void setContent(String content) {
	this.content = content;
}

public String getWriteDate() {
	return writeDate;
}

public void setWriteDate(String writeDate) {
	this.writeDate = writeDate;
}

public String getRecommend() {
	return recommend;
}

public void setRecommend(String recommend) {
	this.recommend = recommend;
}
}
