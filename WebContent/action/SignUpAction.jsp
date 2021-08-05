<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPW" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userBirthDate" />
<jsp:setProperty name="user" property="userType" />
<jsp:setProperty name="user" property="userPWCheck" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		if (user.getUserPW() == null && user.getUserPWCheck() == null) {
		user.setUserPW("null");
		user.setUserPWCheck("null");
	}
	if (user.getUserID() == null || user.getUserPW() == null || user.getUserEmail() == null || user.getUserGender() == null
			|| user.getUserBirthDate() == null || user.getUserType() == null) { //항목에 공백이 존재할때.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('항목에 공백을 사용할수 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else if (!user.getUserPW().equals(user.getUserPWCheck())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호 확인이 일치하지 않습니다!')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		UserDAO userDAO = new UserDAO();
		int result = userDAO.signUp(user);
		if (result == -1) { //로그인이 실패했을때 즉 primary key(userID)에 의한 내용 중복 오류가 발생했을때
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('중복된 아이디 입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == 1) { //로그인 성공.
			int fileResult = userDAO.makeUserFolder(user.getUserID());
			if (fileResult == 1) {
				System.out.println(user.getUserID()+"의 고유 폴더 생성이 완료되었습니다.");
		session.setAttribute("userID", user.getUserID());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = '../MainPage.jsp'");
		script.println("</script>");
			} else {
		session.setAttribute("userID", user.getUserID());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유저 고유 폴더 생성에 실패했습니다. 관리자에게 문의하세요.')");
		script.println("location.href = '../MainPage.jsp'");
		script.println("</script>");
			}
		}
	}
	%>

</body>
</html>