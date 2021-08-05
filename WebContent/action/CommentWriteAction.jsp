<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="comment" class="comment.Comment" scope="page" />
<jsp:setProperty name="comment" property="userID" />
<jsp:setProperty name="comment" property="boardBNO" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if (comment.getBoardBNO() == null || comment.getContent() == null) { //항목에 공백이 존재할때.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('제목이나 내용에 공백이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
		CommentDAO commentDAO = new CommentDAO();
		int result = commentDAO.writeComment(comment);
	%>
</body>
</html>