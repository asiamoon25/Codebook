<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.Board"%>
<%
	String userID = null;
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}

BoardDAO boardDAO = new BoardDAO();

String searchText = (String) request.getParameter("searchText");

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
 String category = (String) (request.getParameter("category"));
if (category == null) {
	category = "FREE";
}

int count = 0;
count = boardDAO.countBoard(category); // 데이터베이스에 저장된 총 갯수
List<Board> list = null;
if (count > 0) {
	// getList()메서드 호출 / 해당 레코드 반환
	if (searchText == null) {
		list = boardDAO.getList_category(startRow, endRow, category);
	} else {
		list = boardDAO.getList_search(startRow, endRow, category, searchText);
		count = boardDAO.countBoard_search(searchText, category);
	}
}
%>
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
<title>Bare - Start Bootstrap Template</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<meta charset="EUC-KR">
<title>CODEBOOK</title>
<style>
pagination {
	display: -webkit-box;
	display: -ms-flexbox;
	display: flex;
	padding-left: 0;
	list-style: none;
	border-radius: .25rem;
}

.search-box .search-input {
	padding-left: 2rem;
	line-height: 1.7;
	border-radius: 50rem;
	box-shadow: none;
}
</style>
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
	<hr style="margin-top: 0px;" />
	<div class="container">
		<!-- 테이블 생성  -->
		<div class="row">
			<!-- 여기에 col-md-2로 카테고리를 만든다. -->
			<div class="col-md-2">
				<ul class="list-group hover">
					<li id="FREE_CA" class="list-group-item list-group-item-action">자유게시판</li>
					<li id="C_CA" class="list-group-item list-group-item-action">C
						게시판</li>
					<li id="JAVA_CA" class="list-group-item list-group-item-action">JAVA
						게시판</li>
					<li id="Python_CA" class="list-group-item list-group-item-action">Python
						게시판</li>
					<li id="Meet_CA" class="list-group-item list-group-item-action">모임
						게시판</li>
				</ul>
			</div>
			<script>
			$('#FREE_CA').click(function(){
				location.href = "CommunityPage.jsp?category=FREE";
			})
			$('#C_CA').click(function(){
				location.href = "CommunityPage.jsp?category=C";
			})
			$('#JAVA_CA').click(function(){
				location.href = "CommunityPage.jsp?category=JAVA";
			})
			$('#Python_CA').click(function(){
				location.href = "CommunityPage.jsp?category=Python";
			})
			$('#Meet_CA').click(function(){
				location.href = "CommunityPage.jsp?category=Meet";
			})
			</script>
			<div class="col-md-10 float-right">
				<table id="userBoard" class="table table-hover">
					<thead>
						<tr>
							<th>번호</th>

							<th>제목</th>

							<th>작성자</th>

							<th>조회수</th>

							<th>추천수</th>

							<th>작성일</th>
						<tr>
					</thead>
					<%
						if (count > 0 && list != null) { // 데이터베이스에 데이터가 있으면
						int number = count - (currentPage - 1) * pageSize; // 글 번호 순번 
						for (int i = 0; i < list.size(); i++) {
							Board board = list.get(i); // 반환된 list에 담긴 참조값 할당
							boardDAO.update_View_RC(board.getBoardBNO());
					%>
					<tbody>
						<tr">
							<td><%=number--%></td>

							<td><%=board.getTitle()%></td>

							<td><%=board.getUserName()%></td>

							<td><%=board.getViews()%></td>

							<td><%=board.getRecommend()%></td>

							<td><%=board.getWriteDate()%></td>

							<td style="display: none;"><%=board.getBoardBNO()%></td>
						</tr>
						<%
							}
						} else { // 데이터가 없으면
						%>
						<tr>
							<td colspan="6" align="center">게시글이 없습니다.</td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				
			</div>
		</div>
	</div>
	<div class="container pt-1">
		<div class="row">
			<div class="col-sm-7 mx-auto text-center">
				<form class="p-2 rounded shadow-sm bg-white border border-3" action="">
					<div class="input-group">
						<input name="searchText"
							class="form-control border-0 mr-2 shadow-none" type="search"
							placeholder="Search" value="">
						<input name="category" value="<%=category%>" style="display:none">
						<div class="input-group-append rounded">
							<button id="btn" type="submit" class="btn-sm btn-primary rounded">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  <path
										d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
</svg>
							</button>
						</div>
					</div>
				</form>
			</div>
			<button id="writeBtn" class="btn-sm btn-primary float-right"
				style="height: 35px;">글쓰기</button>
		</div>
	</div>

	<div class="container pt-4">
		<div class="row">
			<div class="container text-center">
				<nav aria-label="Page navigation example">
					<ul class="pagination" style="justify-content: center;">
						<%
							// 페이징  처리
						if (count > 0) {
							// 총 페이지의 수
							int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
							// 한 페이지에 보여줄 페이지 블럭(링크) 수
							int pageBlock = 5;
							// 한 페이지에 보여줄 시작 및 끝 번호(예 : 1, 2, 3 ~ 10 / 11, 12, 13 ~ 20)
							int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
							int endPage = startPage + pageBlock - 1;

							// 마지막 페이지가 총 페이지 수 보다 크면 endPage를 pageCount로 할당
							if (endPage > pageCount) {
								endPage = pageCount;
							}

							if (startPage > pageBlock && searchText == null) { // 페이지 블록수보다 startPage가 클경우 이전 링크 생성
						%>
						<li class="page-item"><a id="previous" class="page-link"
							href="CommunityPage.jsp?category=<%=category%>&pageNum=<%=startPage - 5%>">Previous</a></li>
						<%
							} else if (startPage > pageBlock && searchText != null) {
						%>
						<li class="page-item"><a id="previous" class="page-link"
							href="CommunityPage.jsp?category=<%=category%>&searchText=<%=searchText%>&pageNum=<%=startPage - 5%>">Previous</a></li>
						<%
							}

						for (int i = startPage; i <= endPage; i++) { // 페이지 블록 번호
						if (searchText == null) {
						%>
						<li class="page-item"><a class="page-link"
							href="CommunityPage.jsp?category=<%=category%>&pageNum=<%=i%>"><%=i%></a></li>
						<%
							} else {
						%>
						<li class="page-item"><a class="page-link"
							href="CommunityPage.jsp?category=<%=category%>&searchText=<%=searchText%>&pageNum=<%=i%>"><%=i%></a></li>
						<%
							}
						}

						if (endPage < pageCount && searchText == null) { // 현재 블록의 마지막 페이지보다 페이지 전체 블록수가 클경우 다음 링크 생성
						%>
						<li class="page-item"><a id="next" class="page-link"
							href="CommunityPage.jsp?category=<%=category%>&pageNum=<%=startPage + 5%>">Next</a></li>
						<%
							} else if (endPage < pageCount && searchText != null) {
						%>
						<li class="page-item"><a id="previous" class="page-link"
							href="CommunityPage.jsp?category=<%=category%>&searchText=<%=searchText%>&pageNum=<%=startPage + 5%>">Next</a></li>
						<%
							}
						}
						%>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	<script>
					$("#userBoard tr").click(function() {
						// 현재 클릭된 Row(<tr>)
						var tr = $(this);
						var td = tr.children();
						var showBNO = td.eq(6).text(); 
						// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
						if(showBNO == 0){
						}else{
						location.href = "Board.jsp?BNO=" + showBNO;
						}
					})
				
					$('#writeBtn').click(function() {
						var userID = '<%=userID%>';
						if (userID == 'null') {
							alert('로그인 된 회원만 글 작성이 가능합니다.');
						} else {
							location.href = "WriteBtn.jsp";
						}
					});
			</script>
</body>
</html>