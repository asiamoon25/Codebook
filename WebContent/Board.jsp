<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.Board"%>
<%@page import="user.UserDAO"%>
<%@page import="comment.CommentDAO"%>
<%@page import="comment.Comment"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="comment.CommentWrite"%>

<%
	int thisBNO = Integer.parseInt(request.getParameter("BNO"));
BoardDAO boardDAO = new BoardDAO();
UserDAO userDAO = new UserDAO();
String userID = (String) session.getAttribute("userID");
boardDAO.plusView((String) (session.getId()), thisBNO);
boardDAO.update_View_RC(thisBNO);
Board board = boardDAO.getBoard(thisBNO);
String boardContent = board.getContent();

String content = boardContent.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n",
		"<br>");

int rcCheck = userDAO.rcCheck(userID, thisBNO);
List<Comment> commentList = null;
int pageSize = 10;
String pageNum = request.getParameter("pageNum");
if (pageNum == null) { // 클릭한게 없으면 1번 페이지
	pageNum = "1";
}
// 연산을 하기 위한 pageNum 형변환 / 현재 페이지
int currentPage = Integer.parseInt(pageNum);

// 해당 페이지에서 시작할 레코드 / 마지막 레코드
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;

CommentDAO commentDAO = new CommentDAO();
int countComment = 0;
countComment = commentDAO.countComment(thisBNO); // 데이터베이스에 저장된 총 갯수

commentList = commentDAO.commentList(thisBNO, startRow, endRow);
String commentBNO = null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
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
<head>
<style>
.g-height-50 {
	height: 50px;
}

.g-width-50 {
	width: 50px !important;
}

@media ( min-width : 0) {
	.g-pa-30 {
		padding: 2.14286rem !important;
	}
}

.g-bg-secondary {
	background-color: #fafafa !important;
}

.u-shadow-v18 {
	box-shadow: 0 5px 10px -6px rgba(0, 0, 0, 0.15);
}

.g-color-gray-dark-v4 {
	color: #777 !important;
}

.g-font-size-12 {
	font-size: 0.85714rem !important;
}

.media-comment {
	margin-top: 20px
}
</style>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

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
					<li class="nav-item active"><a class="nav-link"
						href="CommunityPage.jsp">Community</a></li>
					<li class="nav-item"><a class="nav-link" href="ChatPage.jsp">Chat</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<hr class="mt-0">


	<div class="container">
		<header class=" border-bottom" style="padding-bottom: 0px">
			<div class="container-fluid" style="grid-template-columns: 1fr 2fr;">
			<%
			if(userID != null && userID.equals(board.getUserID())){
					%>
					<button id="deleteBtn" class="btn btn-sm btn-primary">글 삭제</button>
					<%
				}
				%>
				<div class="row">
					<div class="col-5 ">
						<p class="h3 pt-4"><%=board.getTitle()%></p>
					</div>
					<div class="col-3 offset-4">
						<p class=" small pt-5 pr-3 float-right"
							style="margin-bottom: 0px;">
							글쓴이:
							<%=board.getUserName()%></p>
					</div>
				</div>
			</div>
		</header>

		<div class="contatiner-fluid">
			<div class="row">
				<div class="col-6 small">
					<%=board.getWriteDate()%>
				</div>
				<div class="col-2 offset-2 small">
					추천수:
					<%=board.getRecommend()%>
				</div>
				<div class="col-2 small">
					조회수:
					<%=board.getViews()%>
				</div>
			</div>
		</div>

		<div class="container-fluid pb-3 mt-3">
			<div class="d-grid gap-3" style="grid-template-columns: 1fr 2fr;">
				<p>
					<%=content%>
				</p>
			</div>
		</div>

		<hr style="margin-top: 0px;" />

		<div class="container text-center mt-3">
			<a id="like" class="btn icon-btn btn-primary" href="#"><svg
					xmlns="http://www.w3.org/2000/svg" width="16" height="16"
					fill="currentColor" class="bi bi-hand-thumbs-up-fill"
					viewBox="0 0 16 16">
  <path
						d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a9.84 9.84 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.163 3.163 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.82 4.82 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z" />
</svg> Like </a> <a id="unlike" class="btn icon-btn btn-primary" href="#"><svg
					xmlns="http://www.w3.org/2000/svg" width="16" height="16"
					fill="currentColor" class="bi bi-hand-thumbs-down-fill"
					viewBox="0 0 16 16">
  <path
						d="M6.956 14.534c.065.936.952 1.659 1.908 1.42l.261-.065a1.378 1.378 0 0 0 1.012-.965c.22-.816.533-2.512.062-4.51.136.02.285.037.443.051.713.065 1.669.071 2.516-.211.518-.173.994-.68 1.2-1.272a1.896 1.896 0 0 0-.234-1.734c.058-.118.103-.242.138-.362.077-.27.113-.568.113-.856 0-.29-.036-.586-.113-.857a2.094 2.094 0 0 0-.16-.403c.169-.387.107-.82-.003-1.149a3.162 3.162 0 0 0-.488-.9c.054-.153.076-.313.076-.465a1.86 1.86 0 0 0-.253-.912C13.1.757 12.437.28 11.5.28H8c-.605 0-1.07.08-1.466.217a4.823 4.823 0 0 0-.97.485l-.048.029c-.504.308-.999.61-2.068.723C2.682 1.815 2 2.434 2 3.279v4c0 .851.685 1.433 1.357 1.616.849.232 1.574.787 2.132 1.41.56.626.914 1.28 1.039 1.638.199.575.356 1.54.428 2.591z" />
</svg> UnLike </a>
		</div>
		<%
			if (userID != null) {
		%>
		<div class="row">
			<img class="img-fluid img-responsive rounded-circle ml-3 mr-2"
				src="<%=userDAO.showUserImg(userID)%>" width="48">
			<h5 class="h5 pt-3 ml-2"><%=userID%></h5>
		</div>
		<%
			} else {
		%>
		<div class="row">
			<img class="img-fluid img-responsive rounded-circle ml-3 mr-2"
				src="image/default_user_img.png" width="38">
			<h5 class="small pt-3 ml-2">로그인 된 회원만 댓글 입력이 가능합니다.</h5>
		</div>
		<%
			}
		%>
		<div class="d-flex flex-row add-comment-section mt-4 mb-4">
			<textarea id="comment" name="comment" class="form-control mr-3"
				placeholder="Add comment"></textarea>
		</div>
		<button id="submitBtn" class="btn btn-primary">Comment</button>
		<script>
			$("#deleteBtn").click(function(){
				var id = '<%=userID%>';
				var boardBNO = '<%=board.getBoardBNO()%>';
				$.ajax({
					url: "BoardDelete.do",
					type: "POST",
					dataType: "text",
					data:{
						id: id,
						boardBNO: boardBNO
					},
					success:function(){
						alert('게시글이 삭제되었습니다.');
						location.href = document.referrer;
					},
					error:function(){
						alert('서버 통신 에러');
					}
				})
			})
		
			$('#submitBtn').click(function() {
				var comment = $('#comment').val();
				<%if (userID == null) {%>
					alert("로그인을 해주세요.");
					<%} else {%>
						$.ajax({
							url: "<%=request.getContextPath()%>/CommentWrite.do",
							type: "POST",
							dataType:"json",
							async:false,
							data: {
								userID: '<%=userID%>',
								boardBNO: '<%=thisBNO%>',
								comment : comment
					},
					success : function(data) {
						result = data.result;
						if (result === 1) {
							console.log("댓글 가져오기 성공");
							location.reload();
						} else {
							console.log("댓글 추가 실패.");
						}
					},
					error : function(request, status, error) {
						alert("ajax fail");
					}
				});
		<%}%>
			});
		</script>

		<hr />
		<div class="row">

			<%
				if (countComment > 0) { // 데이터베이스에 데이터가 있으면
				int number = countComment - (currentPage - 1) * pageSize; // 글 번호 순번 
				for (int i = 0; i < commentList.size(); i++) {
					Comment comment = commentList.get(i);
					String commentContent = comment.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
					.replaceAll(">", "&gt;").replaceAll("\n", "<br>");
					if (comment.getUserID().equals(boardDAO.matchIDfromBoardBNO(thisBNO))) {
			%>
			<div class="col-md-12">
				<div class="media g-mb-30 media-comment">
					<div class="media-body u-shadow-v18 g-bg-secondary g-pa-30">
						<div class="g-mb-15">
							<h3 class="h5 g-color-primary-dark-v1 mb-0 text-primary"><%=boardDAO.matchName(comment.getUserID())%></h3>
							<span class="g-color-gray-dark-v4 g-font-size-12"><%=comment.getWriteDate()%></span>
						</div>
						<p><%=commentContent%></p>
						<ul class="list-inline d-sm-flex my-0">
						 	<%if(userID != null && userID.equals(comment.getUserID())){%>
							<li><button id="<%=comment.getCommentBNO() %>" type="button" class="btn btn-outline-primary btn-sm btn-delete">삭제</button></li>								
							<%
							commentBNO = comment.getCommentBNO();
							}
							%> 
							<li class="list-inline-item ml-auto"><a id="<%=comment.getCommentBNO() %>/<%=comment.getUserID() %>"
								class="u-link-v5 g-color-gray-dark-v4 g-color-primary--hover RC-click"
								href="#!"><%=comment.getRecommend() %> <svg xmlns="http://www.w3.org/2000/svg"
										width="25" height="25" fill="currentColor"
										class="bi bi-hand-thumbs-up" viewBox="0 0 16 16">
  <path
											d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z" />
</svg>
							</a></li>
						</ul>
					</div>
					<img class="img-fluid img-responsive rounded-circle ml-3 mr-2"
						src="<%=commentDAO.showCommentImg(comment.getCommentBNO())%>"
						width="48">
				</div>
			</div>
			<%
				} else {
			%>
			<div class="col-md-12">
				<div class="media g-mb-30 media-comment">
					<img class="img-fluid img-responsive rounded-circle ml-3 mr-2"
						src="<%=commentDAO.showCommentImg(comment.getCommentBNO())%>"
						width="48">
					<div class="media-body u-shadow-v18 g-bg-secondary g-pa-30">
						<div class="g-mb-15">
							<h5 class="h5 g-color-gray-dark-v1 mb-0"><%=boardDAO.matchName(comment.getUserID())%></h5>
							<span class="g-color-gray-dark-v4 g-font-size-12"><%=comment.getWriteDate()%></span>
						</div>
						<p><%=commentContent%></p>
							<ul class="list-inline d-sm-flex my-0">
							 <%
							if(userID != null && userID.equals(comment.getUserID())){%>
							<li><button id="<%=comment.getCommentBNO() %>" type="button" class="btn btn-outline-primary btn-sm btn-delete">삭제</button></li>								
							<%
							commentBNO = comment.getCommentBNO();
							}
							%> 
								<li class="list-inline-item ml-auto"><a id="<%=comment.getCommentBNO() %>/<%=comment.getUserID() %>"
									class="u-link-v5 g-color-gray-dark-v4 g-color-primary--hover RC-click"
									href="#!"><%=comment.getRecommend() %><svg xmlns="http://www.w3.org/2000/svg"
											width="25" height="25" fill="currentColor"
											class="bi bi-hand-thumbs-up" viewBox="0 0 16 16">
  <path
												d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z" />
</svg> </a></li>
							</ul>
					</div>
				</div>
			</div>
			<%
				}
			}

			} else {
			%>
			댓글이 없습니다.
			<%
				}
			%>
		</div>
			<script>
			var userID = '<%=userID%>';
			
			$('.btn-delete').click(function(){
				var id = $(this).attr("id");
				 $.ajax({
						url: "<%=request.getContextPath()%>/CommentWrite.do",
						type: "POST",
						dataType:"json",
						async:false,
						data: {
							commentBNO : id
				},
				success : function(data) {
					result = data.result;
					if (result === 1) {
						alert("댓글을 삭제했습니다.");
						location.reload();
					} else {
						console.log("댓글 삭제 실패.");
					}
				},
				error : function(request, status, error) {
					alert("ajax fail");
				}
			}); 	
 			})
 			
 			$(".RC-click").click(function(){
 				var data = $(this).attr("id").split("/");
 				var bno = data[0];
 				var id = data[1];
 				
 				if(id == userID){
 					alert('본인의 댓글을 추천하실수 없습니다.');
 				}else{
 					$.ajax({
 						url: "CommentRcPlus.do",
 						dataType: "text",
 						type: "POST",
 						data: {
 							bno : bno,
 							id : id
 						},
 						success: function(result){
 							if(result == 1){
 								alert('댓글을 추천하셨습니다.');
 							}else if(result == 0){
 								alert('댓글 추천을 취소하셨습니다.');
 							}else{
 								alert('오류.');
 							}
 							location.reload();
 						},
 						error: function(){
 							alert('서버 통신 에러.');
 						}
 					})
 				}
 			})
			</script>
		<div class="container pt-4">
			<div class="row">
				<div class="container text-center">
					<nav aria-label="Page navigation example">
						<ul class="pagination" style="justify-content: center;">
							<%
								// 페이징  처리
							if (countComment > 0) {
								// 총 페이지의 수
								int pageCount = countComment / pageSize + (countComment % pageSize == 0 ? 0 : 1);
								// 한 페이지에 보여줄 페이지 블럭(링크) 수
								int pageBlock = 5;
								// 한 페이지에 보여줄 시작 및 끝 번호(예 : 1, 2, 3 ~ 10 / 11, 12, 13 ~ 20)
								int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
								int endPage = startPage + pageBlock - 1;

								// 마지막 페이지가 총 페이지 수 보다 크면 endPage를 pageCount로 할당
								if (endPage > pageCount) {
									endPage = pageCount;
								}

								if (startPage > pageBlock) { // 페이지 블록수보다 startPage가 클경우 이전 링크 생성
							%>
							<li class="page-item"><a id="previous" class="page-link"
								href="Board.jsp?BNO=<%=thisBNO%>&pageNum=<%=startPage - 5%>">Previous</a></li>
							<%
								}

							for (int i = startPage; i <= endPage; i++) { // 페이지 블록 번호
							%>
							<li class="page-item"><a class="page-link"
								href="Board.jsp?BNO=<%=thisBNO%>&pageNum=<%=i%>"><%=i%></a></li>
							<%
								}

							if (endPage < pageCount) { // 현재 블록의 마지막 페이지보다 페이지 전체 블록수가 클경우 다음 링크 생성
							%>
							<li class="page-item"><a id="next" class="page-link"
								href="Board.jsp?BNO=<%=thisBNO%>&pageNum=<%=startPage + 5%>">Next</a></li>
							<%
								}
							}
							%>
						</ul>
					</nav>
				</div>
			</div>
		</div>

	</div>
	<hr class="mt-5" />
	<div class="container-fluid text-center">
		<div class="footer">
			<h5 class="mt-3">사이트 이름</h5>
			<p class="lead">A complete project boilerplate built with
				Bootstrap</p>
			<ul class="list-unstyled">
				<li>Bootstrap 4.6.0</li>
				<li>jQuery 3.5.1</li>
			</ul>
		</div>
	</div>
	<script>
	<%if (rcCheck == 1) {%>
			$("#unlike").show();	
			$("#like").hide();
		<%} else {%>
			$("#like").show();
			$("#unlike").hide();		
		<%}%>
			$("#like").click(function() {
				<%if (userID != null) {%>
				$.ajax({
					url: "<%=request.getContextPath()%>/RecommendAction.do",
					type: "POST",
					dataType:"json",
					async:false,
					data: {
						userID: '<%=userID%>',
						boardBNO: '<%=thisBNO%>',
					action : 1
				},
				success : function(data) {
					result = data.result;
					if (result === 1) {
						alert('추천 하셨습니다.');
						$("#like").hide();
						$("#unlike").show();
						location.reload();
					} else {
						console.log("추천 실패.");
					}
				},
				error : function(request, status, error) {
					alert("ajax fail");
				}
			});
	<%} else {%>
		alert("로그인한 회원만 추천이 가능합니다.");
	<%}%>
		})
		$("#unlike").click(function() {
			$.ajax({
				url: "<%=request.getContextPath()%>/RecommendAction.do",
				type: "POST",
				dataType:"json",
				async:false,
				data: {
					userID: '<%=userID%>',
					boardBNO: '<%=thisBNO%>',
					action : -1
				},
				success : function(data) {
					result = data.result;
					if (result === 1) {
						alert('추천을 취소 하셨습니다.');
						$("#like").show();
						$("#unlike").hide();
						location.reload();
					} else {
						console.log("추천 취소 실패.");
					}
				},
				error : function(request, status, error) {
					alert("ajax fail");
				}
			});
		})
	</script>

</body>
</html>