<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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
<title>CODEBOOK</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<link href="css/styles.css" rel="stylesheet" />
<link rel="stylesheet" href="css/bootstrap-datepicker.css">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script src="js/bootstrap-datepicker.ko.min.js"></script>
</head>
<body>
	<%
		String userID = null;
	String userName = null;
	String userEmail = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
		userName = (String) session.getAttribute("userName");
		userEmail = (String) session.getAttribute("userEmail");
	}
	%>
	<!-- Navigation-->
	<div class="container-sm">
		<nav class="navbar navbar-expand-lg navbar-light">
			<a class="navbar-brand" href="action/LogoutAction.jsp"
				style="color: black; border: 1px;">CODEBOOK</a>

			<button class="navbar-toggler collapsed" type="button"
				data-toggle="collapse" data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="navbar-collapse collapse " id="navbarSupportedContent">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link"
						href="action/LogoutAction.jsp">Home <span class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item active"><a class="nav-link"
						href="LoginPage.jsp">Login</a></li>
					<li class="nav-item"><a class="nav-link"
						href="CommunityPage.jsp">Community</a></li>
					<li class="nav-item"><a class="nav-link" href="ChatPage.jsp">Chat</a></li>
				</ul>
			</div>
		</nav>
	</div>

	<hr style="margin-top: 0px;" />

	<section class="section">
		<div class="container">
			<div class="py-5 text-center">
				<!-- <img class="d-block mx-auto mb-4"
					src="../../assets/brand/bootstrap-solid.svg" alt="" width="72"
					height="72">-->
				<h2>카카오 회원가입</h2>
				<p class="lead">간단한 정보를 입력하여 [~~~]에 가입할수 있습니다.</p>
				<p class="lead">여러 사람을 만나고 함께 성장해 보세요!</p>
			</div>

			<div class="row">
				<div
					class="col-xl-4 col-lg-4 col-md-6 offset-md-3 offset-lg-4 col-sm-8 offset-sm-2">
					<h4 class="mb-3">회원 정보</h4>
					<form class="needs-validation" method="post"
						action="action/SignUpAction.jsp">
						<div class="row">
							<div class="col-sm-6 mb-3">
								<label for="userName">이름</label> <input type="text"
									class="form-control" name="userName" placeholder=""
									value="<%=userName%>" required="">
								<div class="invalid-feedback">Valid first name is
									required.</div>
							</div>
						</div>

						<div class="mb-3">
							<label for="email">이메일</label> <input type="email"
								class="form-control" name="userEmail" value="<%=userEmail%>"
								placeholder="you@example.com" required="">
							<div class="invalid-feedback">Please enter a valid email
								address for shipping updates.</div>
						</div>

						<div class="row">
							<div class="col-sm-5 mb-3">
								<label for="userGender">성별</label> <select
									class="custom-select d-block w-100" name="userGender"
									required="">
									<option value="">성별 선택</option>
									<option>남성</option>
									<option>여성</option>
								</select>
							</div>
							<div class="col-sm-6 mb-3">
								<label for="userBirthDate">생일</label> <input type="text"
									name="userBirthDate" id="userBirthDate" class="form-control"
									value="" required="">
							</div>
							<script>
								document.getElementById('userBirthDate').value = new Date()
										.toISOString().substring(0, 10);
								;
								$('#userBirthDate').datepicker({
									format : "yyyy-mm-dd", //데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
									startDate : '-90y', //달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
									endDate : '-1d', //달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
									autoclose : true, //사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
									calendarWeeks : false, //캘린더 옆에 몇 주차인지 보여주는 옵션 기본값 false 보여주려면 true
									clearBtn : false, //날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
									disableTouchKeyboard : false, //모바일에서 플러그인 작동 여부 기본값 false 가 작동 true가 작동 안함.
									immediateUpdates : false, //사용자가 보는 화면으로 바로바로 날짜를 변경할지 여부 기본값 :false 
									multidate : false, //여러 날짜 선택할 수 있게 하는 옵션 기본값 :false 
									showWeekDays : true,// 위에 요일 보여주는 옵션 기본값 : true
									toggleActive : true, //이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
									weekStart : 0,//달력 시작 요일 선택하는 것 기본값은 0인 일요일 
									language : "ko" //달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
								}).on("changeDate");
							</script>
						</div>
						<input type="text" class="form-control" name="userID"
							value="<%=userID%>" style="display: none"> <input
							type="text" class="form-control" name="userType" value="kakao"
							style="display: none"> <input type="text"
							class="form-control" name="userPW" value="null"
							style="display: none"> <input type="text"
							class="form-control" name="userPWCheck" value="null"
							style="display: none">

						<button class="btn btn-primary btn-lg btn-block col-4 offset-4"
							onclick="signUp();" type="submit" style="margin-top: 5%;"
							id="#submit">저장</button>
						<input name="userType" value="default" style="display: none">

					</form>
				</div>
			</div>

			<footer class="my-5 pt-5 text-muted text-center text-small">
				<p class="mb-1">© 2021-2021 회사명 미정</p>
				<ul class="list-inline">
					<li class="list-inline-item"><a href="#">Privacy</a></li>
					<li class="list-inline-item"><a href="#">Terms</a></li>
					<li class="list-inline-item"><a href="#">Support</a></li>
				</ul>
			</footer>
		</div>
	</section>

	<!-- copyright Section -->
	<div class="copyright text-center text-white">
		<div class="container">
			<small> Copyright © Your Website </small>
		</div>
	</div>
	<!-- Bootstrap core JS-->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<script>
		function signUp() {
			var userName = document.getElementById("userID").value;
			alert("아이디 :" + userName);
		}
	</script>
</body>
</html>
