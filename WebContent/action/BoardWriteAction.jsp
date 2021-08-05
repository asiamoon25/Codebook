<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board" class="board.Board" scope="page" />
<jsp:setProperty name="board" property="userID" />
<jsp:setProperty name="board" property="title" />
<jsp:setProperty name="board" property="content" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if (board.getTitle() == null || board.getContent() == null) { //항목에 공백이 존재할때.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('제목이나 내용에 공백이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
		BoardDAO boardDAO = new BoardDAO();
		int result = boardDAO.writeBoard(board);
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = '../CommunityPage.jsp'");
			script.println("</script>");		
		}else{	//오류
			PrintWriter script = response.getWriter();
			script.print("<script>");
			script.print("alert('오류 발생으로 인해서 글이 등록되지 못했습니다.')");
			script.print("history.back()");
			script.print("</script>");
		}
		
	
	%>
</body>
</html>