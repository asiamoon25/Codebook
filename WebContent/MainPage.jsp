<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserCount"%>
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
<link rel="shortcut icon" type="image/x-icon"
	href="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/800px-Apple_logo_black.svg.png">
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
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
				style="color: black; border: 1px;">CODEBOOK</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation"
				style="color: black">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><label class="nav-link">동시 접속자 수:(<%=UserCount.getCount()%>)</label></li>
					<li class="nav-item active"><a class="nav-link"
						href="MainPage.jsp"> Home <span class="sr-only">(current)</span>
					</a></li>
					<%
						if (userID == null) {
					%>
					<li class="nav-item"><a class="nav-link" href="LoginPage.jsp">LogIn</a></li>
					<%
						} else {
					%>
					<li class="nav-item"><a class="nav-link"
						href="action/LogoutAction.jsp">LogOut(<%=userID%>)
					</a></li>
					<%
						}
					%>
					<li class="nav-item"><a class="nav-link"
						href="CommunityPage.jsp">Community</a></li>
					<li class="nav-item"><a class="nav-link" href="ChatPage.jsp">Chat</a></li>
				</ul>
			</div>
		</div>
	</nav>
	
	<div class="container-fluid">
	
	<!-- Page content-->

		<div class="text-center">
			<div class="jumbotron-fluid p-3 p-md-5 text-white bg-dark"
				style="margin-bottom: 5%;">
				<div class="col-md-12 px-0"
					style="padding-bottom: 5%; padding-top: 5%">
					<h1 class="display-4 font-italic">Title of a longer featured
						blog post</h1>
					<p class="lead my-3">Multiple lines of text that form the lede,
						informing new readers quickly and efficiently about what's most
						interesting in this post's contents.</p>
					<p class="lead mb-0">
						<a href="#" class="text-white font-weight-bold">Continue
							reading...</a>
					</p>
				</div>
			</div>


			<div class="col-lg-14" style="margin-top: 15%; margin-bottom: 15%;">
				<h2>텍스트 자리</h2>
				<p>텍스트 들어갈 자리입니다. 텍스트 들어갈 자리입니다.</p>
				<p>텍스트 들어갈 자리입니다. 텍스트 들어갈 자리입니다.</p>
				<p>텍스트 들어갈 자리입니다. 텍스트 들어갈 자리입니다.</p>
			</div>

			<!-- 네모 이미지 두개 -->
			<div class="container-fluid" style="background-color: #f9f9f9">
				<div class="container">
					<div class="row align-items-center">
						<div class="row mb-2"
							style="padding-top: 10%; padding-bottom: 10%; margin-top: 5%; margin-bottom: 5%;">
							<div class="col-md-5 offset-md-1">
								<div class="card flex-md-row mb-4 box-shadow h-md-250">
									<div class="card-body d-flex flex-column align-items-start">
										<strong class="d-inline-block mb-2 text-primary">World</strong>
										<h3 class="mb-0">
											<a class="text-dark" href="#">Featured post</a>
										</h3>
										<div class="mb-1 text-muted">Nov 12</div>
										<p class="card-text mb-auto">This is a wider card with
											supporting text below as a natural lead-in to additional
											content.</p>
										<a href="#">Continue reading</a>
									</div>
									<img class="card-img-right flex-auto d-none d-md-block"
										data-src="holder.js/200x250?theme=thumb"
										alt="Thumbnail [200x250]" style="width: 200px; height: 250px;"
										src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22200%22%20height%3D%22250%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20200%20250%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_17964be9224%20text%20%7B%20fill%3A%23eceeef%3Bfont-weight%3Abold%3Bfont-family%3AArial%2C%20Helvetica%2C%20Open%20Sans%2C%20sans-serif%2C%20monospace%3Bfont-size%3A13pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_17964be9224%22%3E%3Crect%20width%3D%22200%22%20height%3D%22250%22%20fill%3D%22%2355595c%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2256.1953125%22%20y%3D%22131%22%3EThumbnail%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"
										data-holder-rendered="true">
								</div>
							</div>
							<div class="col-md-5">
								<div class="card flex-md-row mb-4 box-shadow h-md-250">
									<div class="card-body d-flex flex-column align-items-start">
										<strong class="d-inline-block mb-2 text-success">Design</strong>
										<h3 class="mb-0">
											<a class="text-dark" href="#">Post title</a>
										</h3>
										<div class="mb-1 text-muted">Nov 11</div>
										<p class="card-text mb-auto">This is a wider card with
											supporting text below as a natural lead-in to additional
											content.</p>
										<a href="#">Continue reading</a>
									</div>
									<img class="card-img-right flex-auto d-none d-md-block"
										data-src="holder.js/200x250?theme=thumb"
										alt="Thumbnail [200x250]"
										src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22200%22%20height%3D%22250%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20200%20250%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_17964be9225%20text%20%7B%20fill%3A%23eceeef%3Bfont-weight%3Abold%3Bfont-family%3AArial%2C%20Helvetica%2C%20Open%20Sans%2C%20sans-serif%2C%20monospace%3Bfont-size%3A13pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_17964be9225%22%3E%3Crect%20width%3D%22200%22%20height%3D%22250%22%20fill%3D%22%2355595c%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2256.1953125%22%20y%3D%22131%22%3EThumbnail%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"
										data-holder-rendered="true"
										style="width: 200px; height: 250px;">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class="col-lg-14" style="margin-top: 15%; margin-bottom: 15%;">
				<h2>텍스트 자리</h2>
				<p>텍스트 들어갈 자리입니다. 텍스트 들어갈 자리입니다.</p>
				<p>텍스트 들어갈 자리입니다. 텍스트 들어갈 자리입니다.</p>
				<p>텍스트 들어갈 자리입니다. 텍스트 들어갈 자리입니다.</p>
			</div>

			<!-- 작은 네모 이미지 세개 -->

			<div class="container-fluid" style="background-color: #f9f9f9">
				<div class="container">
					<div class="card-deck mb-3 text-center"
						style="padding-top: 10%; padding-bottom: 10%; margin-top: 5%; margin-bottom: 5%;">
						<div class="card mb-4 box-shadow">
							<div class="card-header">
								<h4 class="my-0 font-weight-normal">Free</h4>
							</div>
							<div class="card-body">
								<h1 class="card-title pricing-card-title">
									$0 <small class="text-muted">/ mo</small>
								</h1>
								<ul class="list-unstyled mt-3 mb-4">
									<li>10 users included</li>
									<li>2 GB of storage</li>
									<li>Email support</li>
									<li>Help center access</li>
								</ul>
								<button type="button" class="btn btn-lg btn-block btn-primary">Sign
									up for free</button>
							</div>
						</div>
						<div class="card mb-4 box-shadow" style="">
							<div class="card-header">
								<h4 class="my-0 font-weight-normal">Pro</h4>
							</div>
							<div class="card-body">
								<h1 class="card-title pricing-card-title">
									$15 <small class="text-muted">/ mo</small>
								</h1>
								<ul class="list-unstyled mt-3 mb-4">
									<li>20 users included</li>
									<li>10 GB of storage</li>
									<li>Priority email support</li>
									<li>Help center access</li>
								</ul>
								<button type="button" class="btn btn-lg btn-block btn-primary">Get
									started</button>
							</div>
						</div>
						<div class="card mb-4 box-shadow">
							<div class="card-header">
								<h4 class="my-0 font-weight-normal">Enterprise</h4>
							</div>
							<div class="card-body">
								<h1 class="card-title pricing-card-title">
									$29 <small class="text-muted">/ mo</small>
								</h1>
								<ul class="list-unstyled mt-3 mb-4">
									<li>30 users included</li>
									<li>15 GB of storage</li>
									<li>Phone and email support</li>
									<li>Help center access</li>
								</ul>
								<button type="button" class="btn btn-lg btn-block btn-primary">Contact
									us</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-14" style="margin-top: 15%; margin-bottom: 15%;">
				<h2>텍스트 자리</h2>
				<p>텍스트 들어갈 자리입니다. 텍스트 들어갈 자리입니다.</p>
				<p>텍스트 들어갈 자리입니다. 텍스트 들어갈 자리입니다.</p>
				<p>텍스트 들어갈 자리입니다. 텍스트 들어갈 자리입니다.</p>
			</div>

			<hr />

			<div class="container-fluid">
				<div class="footer">
					<h1 class="mt-5">메인 페이지</h1>
					<p class="lead">A complete project boilerplate built with
						Bootstrap</p>
					<ul class="list-unstyled">
						<li>Bootstrap 4.6.0</li>
						<li>jQuery 3.5.1</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
