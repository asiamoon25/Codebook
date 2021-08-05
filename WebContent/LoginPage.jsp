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
<link href="css/styles.css" rel="stylesheet" />
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light bg-white static-top">
		<div class="container-sm">
			<a class="navbar-brand" href="MainPage.jsp"
				style="color: black; border: 1px;">CODEBOOK</a>
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
					<li class="nav-item active"><a class="nav-link"
						href="LoginPage.jsp">Login</a></li>
					<li class="nav-item"><a class="nav-link"
						href="CommunityPage.jsp">Community</a></li>
					<li class="nav-item"><a class="nav-link" href="ChatPage.jsp">Chat</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<hr style="margin-top: 0px;" />

	<section class="ftco-section">
		<div class="container" style="padding-top: 10%">
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-4 col-sm-8">
					<div class="login-wrap p-0">
						<h3 class="mb-4 text-center">로그인</h3>
						<form method="post" action="action/LoginAction.jsp">
							<!-- 로그인 누르면 넘어가는  -->
							<div class="form-group">
								<input name="userID" type="text" class="form-control"
									placeholder="이메일 또는 아이디" required>
							</div>
							<div class="form-group">
								<input name="userPW" type="password" class="form-control"
									placeholder="비밀번호" required> <span
									toggle="#password-field"
									class="fa fa-fw fa-eye field-icon toggle-password"></span>
							</div>
							<div class="form-group">
								<button type="submit"
									class="form-control btn btn-primary submit px-3">로그인</button>
							</div>
							<div class="form-group d-md-flex">
								<div class="w-50">
									<label class="checkbox-wrap checkbox-primary">아이디 저장 <input
										type="checkbox" checked> <span class="checkmark"></span>
									</label>
								</div>
								<a href="SignUpPage.jsp">계정이 없으신가요?</a>
							</div>
						</form>


						<p class="w-100 text-center">&mdash; Or Sign In With &mdash;</p>
						<a href="javascript:kakaoLogin();"><img
							src="image\kakao_login_medium_narrow.png" /></a>
						
						<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
						
						<!-- 카카오 스크립트 -->
						<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
						<script>
							Kakao.init('f5d1d2287d188a0f345aaa60b4b0e732'); //발급받은 키 중 javascript키를 사용해준다.
							console.log(Kakao.isInitialized()); // sdk초기화여부판단
							//카카오로그인
							function kakaoLogin() {
								Kakao.Auth.login({
									success : function(response) {
										Kakao.API.request({
											url : '/v2/user/me',
											success : function(response) {
												console.log(response)
												console.log(response.id); 
												console.log(response.properties.nickname); 
												console.log(response.kakao_account.email); 
												location.href = 'action/LoginAction.jsp?userName='+response.properties.nickname+'&userID='+response.id+'&userEmail='+response.kakao_account.email;
											},
											fail : function(error) {
												console.log(error)
											},
										})
									},
									fail : function(error) {
										console.log(error)
									},
								})
							}
							//카카오로그아웃  
							function kakaoLogout() {
								if (Kakao.Auth.getAccessToken()) {
									Kakao.API.request({
										url : '/v1/user/unlink',
										success : function(response) {
											console.log(response)
										},
										fail : function(error) {
											console.log(error)
										},
									})
									Kakao.Auth.setAccessToken(undefined)
								}
							}
						</script>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>