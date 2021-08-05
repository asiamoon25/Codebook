<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userPW" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO();
	if (user.getUserID() != null && user.getUserName() != null) { //회원의 이름과 아이디가 프로퍼티로 넘어왔다면 즉 카카오 회원이라면.
			if(userDAO.checkUser(user.getUserID())){	//만약 프로퍼티로 받은 아이디값이 데이터 베이스에 있다면 기존 회원이므로 트루값 리턴 후 조건문 실행 로그인
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = '../MainPage.jsp'");
			script.println("</script>");				
			}else{	//존재하지 않다면 회원가입 진행
				System.out.print(user.getUserID());
				System.out.print("here");
			session.setAttribute("userID", user.getUserID());
			session.setAttribute("userName", user.getUserName());
			session.setAttribute("userEmail", user.getUserEmail());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = '../KakaoSignUpPage.jsp'");
			script.println("</script>");				
			}
	} else if (user.getUserID() != null && user.getUserPW() != null && user.getUserName() == null) { //정보과 이런 형식으로 넘어 왔다면 기존의 회원이 아이디 비밀번호를 인풋에 담아 넘겨준것.
		String userID = null; //세션에 담아줄 변수값은 아이디값으로 지정
		if (session.getAttribute("userID") != null) { //밑에서 보이는 setAttribute 에서 userID에 user의 아이디 값을 담아줬다면(담아 준 뒤의 데이터 타입은 object임) String 타입으로 형변환 후 userID에 담아줌 
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = '../MainPage.jsp'");
			script.println("</script>");
		}
		int result = userDAO.login(user.getUserID(), user.getUserPW());
		if (result == 1) { //로그인이 성공했을때
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = '../MainPage.jsp'");
			script.println("</script>");
		} else if (result == 0 || result == -1) { //로그인이 실패했을때
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디 또는 비밀번호가 잘못되었습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == 2) { //데이터 베이스 오류일 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인에 오류가 발생했습니다!')");
			script.println("history.back()");
			script.println("</script>");
		}
	}
	%>

</body>
</html>