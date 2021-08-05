<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="chat.ChatRoom"%>
<%@page import="chat.ChatDAO"%>
<%@page import="chat.ChatMessage"%>
<%@page import="java.util.ArrayList"%>
<%
	String userID = (String) session.getAttribute("userID");
ChatDAO chatDAO = new ChatDAO();
ArrayList<ChatRoom> list = chatDAO.showChatRoom(userID);
String searchBy = request.getParameter("searchBy");
String searchText = request.getParameter("searchText");
ArrayList<ChatRoom> modalRoomList = null;
if(searchText == null && searchBy == null){
modalRoomList = chatDAO.showAllChatRoom();	
}else{
modalRoomList = chatDAO.searchChatRoom(searchBy, searchText);
System.out.println(modalRoomList);
}
String rB = request.getParameter("roomBNO");
int roomBNO;
if(rB != null){
	roomBNO = Integer.parseInt(rB);
}else{
	roomBNO = 0;
}
%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>미니 프로젝트</title>
<link rel="shortcut icon" type="image/x-icon"
	href="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/800px-Apple_logo_black.svg.png">
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="findRoom-modal2" class="modal fade">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5>채팅방 찾기</h5>
										<div class="dropdown">
											<button class="btn-sm btn-secondary dropdown-toggle"
												type="button" id="findRoomBy"
												data-bs-toggle="dropdown" aria-expanded="false" style="margin-top:3px;">방 이름</button>
											<ul class="dropdown-menu"
												aria-labelledby="dropdownMenuButton1">
												<li><a id="byRoomName" class="dropdown-item">방 이름</a></li>
												<li><a id="byOperatorID" class="dropdown-item">방장 ID</a></li>
												<li><a id="byRoomIntro" class="dropdown-item">방 설명</a></li>
											</ul>
										</div>
										<div class="input-group mb-3">
  											<input id="findRoomVal" type="text" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
 											 <button class="btn btn-outline-secondary" type="button" id="findRoomSubmit">검색</button>
										</div>
									</div>
									<div class="modal-body">
										<div class="form-group">
											<div class="messages-box">
												<div class="list-group rounded-0">
													<%
														if (modalRoomList != null) {
														for (ChatRoom ch : modalRoomList) {
													%>
													<a id="<%=ch.getRoomBNO()%>"
														class="list-group-item list-group-item-action list-group-item-light rounded-0">
														<div class="media">
															<img src="image/default_user_img.png" alt="user"
																width="50" class="rounded-circle">
															<div class="media-body ml-4">
																<div
																	class="d-flex align-items-center justify-content-between mb-1">
																	<h6 class="mb-0"><%=ch.getRoomName()%></h6>
																</div>
																<p class="font-italic mb-0 text-small"><%=ch.getRoomIntro()%></p>
															</div>
														</div>
													</a>
													<%
														}
													}
													%>
												</div>
											</div>
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-bs-dismiss="modal">Close</button>
									</div>
								</div>
							</div>
						</div>
</body>
</html>