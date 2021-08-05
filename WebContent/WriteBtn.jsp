<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Bare - Start Bootstrap Template</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>

	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light bg-white static-top">
		<div class="container-sm">
			<a class="navbar-brand" href="MainPage.jsp"
				style="color: black; border: 1px;">Start Bootstrap</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation"
				style="color: black">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link" href="MainPage.jsp">
							Home <span class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="CommunityPage.jsp">Community</a></li>
					<li class="nav-item"><a class="nav-link" href="ChatPage.jsp">Chat</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<hr style="margin-top: 0px;" />

	<div class="container" role="main">

		<h2>board Form</h2>

		<form name="form" id="form" role="form" method="post"
			action="action/BoardWriteAction.jsp">

			<div class="mb-3">

				<label for="title">제목</label> <input type="text"
					class="form-control" name="title" name="title"
					placeholder="제목을 입력해 주세요">

			</div>

			<div class="mb-3">

				<label for="content">내용</label>

				<textarea class="form-control" rows="5" name="content" placeholder="내용을 입력해 주세요"></textarea>

			</div>

			<div class="mb-3">

				<label for="tag">TAG</label> <input type="text" class="form-control"
					name="tag" id="tag" placeholder="태그를 입력해 주세요">

			</div>
			<input type="text" name="userID" value="<%=userID%>"
				style="display: none;">
			<div>

				<button type="submit" class="btn btn-sm btn-primary" id="btnSave">저장</button>

			</div>
		</form>


	</div>
</body>
</html>