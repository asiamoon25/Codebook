<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		session.invalidate(); //logOut버튼을 누름으로서 세션의 정보를 뺏어줌
	%>
	<script>
		location.href = '../MainPage.jsp';
	</script>

</body>
</html>