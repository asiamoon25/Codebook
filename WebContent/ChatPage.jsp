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
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>CODEBOOK</title>
<link rel="shortcut icon" type="image/x-icon"
	href="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/800px-Apple_logo_black.svg.png">
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<style>
body {
	background-color: #74EBD5;
	background-image: linear-gradient(90deg, #74EBD5 0%, #9FACE6 100%);
	min-height: 100vh;
}

::-webkit-scrollbar {
	width: 5px;
}

::-webkit-scrollbar-track {
	width: 5px;
	background: #f5f5f5;
}

::-webkit-scrollbar-thumb {
	width: 1em;
	background-color: #ddd;
	outline: 1px solid slategrey;
	border-radius: 1rem;
}

.text-small {
	font-size: 0.9rem;
}

.messages-box, .chat-box {
	height: 510px;
	overflow-y: scroll;
}

.rounded-lg {
	border-radius: 0.5rem;
}

input::placeholder {
	font-size: 0.9rem;
	color: #999;
}
</style>
</head>
<body>
	<input type="hidden" id="endNum" value="10">
	<input type="hidden" id="beforeEndNum" value="0">
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
					<li class="nav-item"><a class="nav-link"
						href="CommunityPage.jsp">Community</a></li>
					<li class="nav-item active"><a class="nav-link"
						href="ChatPage.jsp">Chat</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<hr style="margin-top: 0px;" />

	<div class="container py-5 px-4">

		<div class="row rounded-lg overflow-hidden shadow">
			<!-- Users box-->
			<div class="col-lg-4 px-0">
				<div class="bg-white">
					<div class="row bg-gray px-4 bg-light"
						style="padding-top: 10px; padding-bottom: 5px;">
						<p class="small mb-0 py-1 col-sm-3">채팅 목록</p>
						<button id="findChat"
							class="float-right btn btn-outline-primary btn-sm col-sm-3 offset-sm-2">방
							찾기</button>
						<div id="findRoom-modal" class="modal fade">
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
													<a id="<%=ch.getRoomBNO()%>" name = "<%=ch.getRoomPW() %>"
														class="list-group-item modal-list-item list-group-item-action list-group-item-light rounded-0">
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
									<div id="searchfooter" class="modal-footer">
										<button type="button" class="btn btn-default"
											data-bs-dismiss="modal">Close</button>
									</div>
								</div>
							</div>
						</div>
						<button id="createChat"
							class="float-right btn btn-outline-primary btn-sm col-sm-3 offset-sm-1">방
							생성</button>
						<div id="createRoom-modal" class="modal fade" role="dialog">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h3>채팅방 생성</h3>
									</div>
									<form id="createForm" name="contact" role="form" method="post">
										<div class="modal-body">
											<div class="form-group">
												<label for="name">채팅방 명</label> <input type="text"
													id="chatName" class="form-control">
											</div>
											<div class="form-group">
												<label for="email">채팅방 비밀번호</label> <input type="password"
													id="chatPW" class="form-control"
													placeholder="입력하지 않으면 채팅방이 공개됩니다.">
											</div>
											<div class="form-group">
												<label for="message">채팅방 소개</label>
												<textarea id="chatIntro" class="form-control"></textarea>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-bs-dismiss="modal">Close</button>
											<input type="submit" class="btn btn-success"
												id="createsubmitmodal">
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>


					<div class="messages-box" style="height: 559px;">
						<div class="list-group rounded-0">
							<%
								if (list != null) {
								for (int i = 0; i < list.size(); i++) {
									ChatRoom ch = list.get(i);
							%>
							<a id="<%=ch.getRoomBNO()%>"
								class="message-list-item list-group-item list-group-item-action list-group-item-light rounded-0">
								<div class="media">
									<img src="image/default_user_img.png" alt="user" width="50"
										class="rounded-circle">
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
			<!-- Chat Box-->
			<div class="col-lg-8 px-0">
				<!-- invite friends -->
				<div class="bg-light">
					<div class="input-group">
						<input id="invite" type="text" placeholder="Invite friends!"
							aria-describedby="button-addon2"
							class="form-control border-0 py-4 bg-light"
							autocomplete="off">
						<div class="input-group-append">
							<button id="inviteBtn" type="submit" class="btn btn-link">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-person-plus-fill"
									viewBox="0 0 16 16">
  <path
										d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" />
  <path fill-rule="evenodd"
										d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z" />
</svg>
							</button>
							<button id="exit_room" class="btn btn-outline-secondary" type="button">방 나가기</button>
						</div>
					</div>
				</div>
				<div id="chat-container" class="px-4 py-5 chat-box bg-white">
					<%-- <%
						if (roomBNO != 0) {
						ArrayList<ChatMessage> chatList = chatDAO.findChatMessage(roomBNO, endNum);
						for (ChatMessage cm : chatList) {
							if (userID.equals(cm.getUserID())) {
					%>
					<div class="media w-50 ml-auto mb-3">
						<div class="media-body mr-3">
							<div class="bg-primary rounded py-2 px-3 mb-2">
								<p class="text-small mb-0 text-white"><%=cm.getMessage()%></p>
							</div>
							<p class="small text-muted"><%=cm.getSendDate()%></p>
						</div>
					</div>
					<%
						} else {
					%>
					<div class="media w-50 mb-3">
						<img src="image/default_user_img.png" alt="user" width="50"
							class="rounded-circle mt-1">
						<div class="media-body ml-3">
							<p class="small text-muted"><%=cm.getUserID()%></p>
							<div class="bg-light rounded py-2 px-3 mb-2">
								<p class="text-small mb-0 text-muted"><%=cm.getMessage()%></p>
							</div>
							<p class="small text-muted"><%=cm.getSendDate()%></p>
						</div>
					</div>
					<%
						}
					}
					}
					%> --%>
				</div>

				<!-- Typing area -->
				<div class="bg-light">
					<div class="input-group">
						<input id="inputMessage" type="text" placeholder="Type a message"
							aria-describedby="button-addon2"
							class="form-control rounded-0 border-0 py-4 bg-light"
							autocomplete="off">
						<div class="input-group-append">
							<button id="button-submit" type="submit" class="btn btn-link">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-shift" viewBox="0 0 16 16">
  <path
										d="M7.27 2.047a1 1 0 0 1 1.46 0l6.345 6.77c.6.638.146 1.683-.73 1.683H11.5v3a1 1 0 0 1-1 1h-5a1 1 0 0 1-1-1v-3H1.654C.78 10.5.326 9.455.924 8.816L7.27 2.047zM14.346 9.5 8 2.731 1.654 9.5H4.5a1 1 0 0 1 1 1v3h5v-3a1 1 0 0 1 1-1h2.846z" />
</svg>

							</button>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<script type="text/javascript">
		var userID ='<%=userID%>';
		var roomBNO = <%=roomBNO%>;
		var searchText = '<%=searchText%>';
		
		$("#createsubmitmodal").click(function test1(){
        var chatName = $("#chatName").val();
        var chatPW = $("#chatPW").val();
        var chatIntro = $("#chatIntro").val();

        $.ajax({
            url : "<%=request.getContextPath()%>/ChatRoomCreate.do", // 요기에
            type : 'POST', 
            dataType:"text",
            data : {
            		userID: '<%=userID%>',
            		chatName: chatName,
            		chatPW: chatPW,
            		chatIntro: chatIntro
            		},
            success : function() {
            	location.reload();
            }, // success 
    
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        }); 
    })
    
    $("#exit_room").click(function(){
    	if(roomBNO == 0){
    		alert("입장한 채팅방이 없습니다.");
    	}else{
    		$.ajax({
                url : "<%=request.getContextPath()%>/ExitChatRoom.do",
    			type : 'POST',
    			dataType : "text",
    			data : {
    				userID : userID,
    				roomBNO : roomBNO
    			},
    			success : function(result) {
    				if(result == 1){
    				location.href = "ChatPage.jsp"					
    				}else{
    					alert("방을 나가지 못했습니다.");
    				}
    			},
    			error : function() {
    				alert("서버 통신 에러.");
    			}
    		});	
    	}
    	
    });
    
    $(".message-list-item").click(function(){
    	var chatRoomBNO = $(this).attr("id");		
    	location.href = "ChatPage.jsp?roomBNO="+chatRoomBNO;
    })
    $(".modal-list-item").click(function(){
    	var chatRoomBNO = $(this).attr("id");		
    	var chatRoomPW = $(this).attr("name");
    	if(chatRoomPW != 'null'){
    		var $passwordInput = $("<div class='input-group mb-3'>"
    				  				+"<input id='pwInput' type='text' class='form-control' placeholder='방 비밀번호 입력' aria-label='Recipient username' aria-describedby='button-addon2'>"
    		  						+"<button id='pwBtn' class='btn btn-outline-secondary' type='button' id='button-addon2'>Button</button>"
    								+"</div>");
    		$('#searchfooter').append($passwordInput);
    		$("#pwBtn").click(function(){
    			var pw = $("#pwInput").val();
    			if(pw == chatRoomPW){
    				$.ajax({
    		            url : "<%=request.getContextPath()%>/InviteFriends.do",
    					type : 'POST',
    					dataType : "text",
    					data : {
    						friendID : <%=userID%>,
    						roomBNO : chatRoomBNO
    					},
    					success : function(data) {
    						if (data === "error") {
    							alert("접속 에러");
    						}else if(data === "overlap"){
    							alert("이미 채팅방에 있습니다.");					
    						}else{
				    			 location.href = "ChatPage.jsp?roomBNO="+chatRoomBNO;     		    				
    						}
    					},
    					error : function() {
    						alert("서버 통신 에러.");
    					}
    				});
    			}else{
    				alert('비밀번호가 일치하지 않습니다.');
    			}
    		})
    	}else{
    		$.ajax({
	            url : "<%=request.getContextPath()%>/InviteFriends.do",
				type : 'POST',
				dataType : "text",
				data : {
					friendID : <%=userID%>,
					roomBNO : chatRoomBNO
				},
				success : function(data) {
					if (data === "error") {
						alert("접속 에러");
					}else if(data === "overlap"){
						alert("이미 채팅방에 있습니다.");					
					}else{
	    			 location.href = "ChatPage.jsp?roomBNO="+chatRoomBNO;     		
					}
				},
				error : function() {
					alert("서버 통신 에러.");
				}
			});
    	}
    })
    
    	var webSocket = new WebSocket('ws://jungho.duckdns.org/ChatServer/<%=roomBNO%>');
    	var inputMessage = document.getElementById('inputMessage');
    	
    	webSocket.onopen = function(e){
    		onOpen(e);
    	};
    	webSocket.onerror = function(e){
    		onError(e);
    	};
    	webSocket.onmessage = function(e){
    		onMessage(e);
    	};
    	function onOpen(e){
    		
    	}
    	
    	function onError(e){
    		alert(e.data);
    	}
    	
    	function onMessage(e){
    		var chatMsg = event.data;
    		chatMsg = chatMsg.split("/");
    		var fromID = chatMsg[1];
    		var message = chatMsg[0];
    		var date = new Date();
    		var dateInfo = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
    		if(message.substring(0,6) == 'server'){		//서버측 공지
    			var $chat = $("<div class='chat notice'>" + chatMsg + "</div>");
    			$('#chat-container').append($chat);
    			$('#chat-container').scrollTop($('#chat-container')[0].scrollHeight+20);
    		}else{
    			var $chat = $("<div class='media w-50 mb-3'>"
    		    		+"<img src='image/default_user_img.png' alt='user' width='48' class='rounded-circle mt-1'>"
    		    		+"<div class='media-body mt-1 ml-3'>"
    		    		+"<p class='small text-muted'>"+fromID+"</p>"
    		    		+"<div class='bg-light rounded py-2 px-3 mb-2'>"
    		    		+"<p class='text-small mb-0 text-muted'>"+message+"</p>"
    		    		+"</div>"
    		    		+"<p class='small text-muted'>"+dateInfo+"</p>"
    		    		+"</div>"
    		    		+"</div>");
    			$('#chat-container').append($chat);
    			$('#chat-container').scrollTop($('#chat-container')[0].scrollHeight+20);
    		}
    		
    	}
    	
    	function send(){
    		var chatMsg = inputMessage.value;
    		if(chatMsg == ''){
    			return;
    		}
    		var date = new Date();
    		var dateInfo = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
    		var $chat = $("<div class='media w-50 ml-auto mb-3'>"
    		+"<div class='media-body mt-1 mr-3'>"
    		+"<div class='bg-primary rounded py-2 px-3 mb-2'>"
    		+"<p class='text-small mb-0 text-white'>"+ chatMsg +"</p>"
    		+"</div>"
    		+"<p class='small text-muted'>"+ dateInfo +"</p>"
    		+"</div>"
    		+"</div>");
    		$('#chat-container').append($chat);
    		webSocket.send(chatMsg+"/"+userID);
    		inputMessage.value = "";
    		$('#chat-container').scrollTop($('#chat-container')[0].scrollHeight+20);
    	}
    	<%if (roomBNO != 0) {%>
		 $(function(){
			 $('#inputMessage').keydown(function(key){
				if(key.keyCode == 13){
					$('#inputMessage').focus();
					send();
				}
			}); 
			$('#button-submit').click(function(){
				send();
			});
		})
		<%}%>
		if(userID !== "null"){
		$("#findChat").click(function(){
			$("#findRoom-modal").modal('show');
		})
		$("#createChat").click(function(){
			$("#createRoom-modal").modal('show');
		})
		}else{
			$("#findChat").click(function(){
				alert('로그인한 유저만 이용 가능합니다.');
			})
			$("#createChat").click(function(){
				alert('로그인한 유저만 이용 가능합니다.');
			})
		}
		
		$("#inviteBtn").click(function(){
			var friendID = $("#invite").val();
			$.ajax({
	            url : "<%=request.getContextPath()%>/InviteFriends.do",
				type : 'POST',
				dataType : "text",
				data : {
					friendID : friendID,
					roomBNO : roomBNO
				},
				success : function(data) {
					if (data === "error") {
						alert("친구의 아이디가 잘못되었습니다.");
					}else if(data === "overlap"){
						alert("친구가 이미 채팅방에 있습니다.");					
					}else{
					location.reload();						
					}
				},
				error : function() {
					alert("서버 통신 에러.");
				}
			});
		})
		
		$("#byRoomName").click(function(){
			var btnText = $(this).html();
			$("#findRoomBy").html(btnText);
		})
		$("#byOperatorID").click(function(){
			var btnText = $(this).html();
			$("#findRoomBy").html(btnText);
		})
		$("#byRoomIntro").click(function(){
			var btnText = $(this).html();
			$("#findRoomBy").html(btnText);
		})
		
		 $("#findRoomSubmit").click(function(){
			var text = $("#findRoomBy").html()+"/"+$("#findRoomVal").val();
			$.ajax({
				url : "<%=request.getContextPath()%>/searchChatRoom.do",
				type : "POST",
				dataType : "json",
				data : {
					text : text
				},
				success : function(data){
					searchBy = data.searchBy;
					searchText = data.searchText;
					location.href = "ChatPage.jsp?roomBNO="+roomBNO+"&searchBy="+searchBy+"&searchText="+searchText;
				},
				error : function(){
					alert("서버 통신 에러.");					
				}
			
			});
		}) 
		
		if(searchText != 'null'){
			jQuery(document).ready(function () {
			$("#findRoom-modal").modal('show');
			});
		}
		
		window.onkeydown = function() {
			var kcode = event.keyCode;
			if(kcode == 116) {
			history.replaceState({}, null, location.pathname);
			}
		}
		
		function fnMove(seq){
	        var offset = $("#" + seq).offset();
	        $('#chat-container').animate({scrollTop : offset.top}, 300);
	    }
		
		$('#chat-container').on("mousewheel", function(e){
			var wheel = e.originalEvent.wheelDelta;
			var sHeight = $('#chat-container').scrollTop();
			if(wheel > 0){
				if(sHeight == 0){
					var endNum = parseInt($("#endNum").val());
					var beforeEndNum = parseInt($("#beforeEndNum").val());
					if(endNum != beforeEndNum){
						$.ajax({
							url : "/ChatDataLoad.do",
							dataType : "json",
							type : "POST",
							async : false,
							data : {
								roomBNO : roomBNO,
								endNum : endNum 
							},
							success : function(data){
								$("#beforeEndNum").val(endNum);
									var resultData = data;
									var min = 0;
								for(var i = 0; i < Object.keys(resultData).length; i++){
									if(i == 0){
										min = (endNum+i);
									}
									var message = resultData[i].split('/');
									var writer = message[0];
									var ms = message[1];
									var date = message[2];
									if(writer == userID){
										var $chat = $("<div id='"+(endNum+i)+"' class='media w-50 ml-auto mb-3'>"
									    		+"<div class='media-body mt-1 mr-3'>"
									    		+"<div class='bg-primary rounded py-2 px-3 mb-2'>"
									    		+"<p class='text-small mb-0 text-white'>"+ ms +"</p>"
									    		+"</div>"
									    		+"<p class='small text-muted'>"+ date +"</p>"
									    		+"</div>"
									    		+"</div>");
									    		$('#chat-container').prepend($chat);
									}else{
										var $chat = $("<div id='"+(endNum+i)+"' class='media w-50 mb-3'>"
						    		    		+"<img src='image/default_user_img.png' alt='user' width='48' class='rounded-circle mt-1'>"
						    		    		+"<div class='media-body mt-1 ml-3'>"
						    		    		+"<p class='small text-muted'>"+writer+"</p>"
						    		    		+"<div class='bg-light rounded py-2 px-3 mb-2'>"
						    		    		+"<p class='text-small mb-0 text-muted'>"+ms+"</p>"
						    		    		+"</div>"
						    		    		+"<p class='small text-muted'>"+date+"</p>"
						    		    		+"</div>"
						    		    		+"</div>");
						    					$('#chat-container').prepend($chat);
									}
								}
								if(min != 0){
								fnMove(min);									
								}
								if(Object.keys(resultData).length != 0){
									var nowEndNum = endNum+10;
									$("#endNum").val(nowEndNum);									
								}
							},
							error : function(){						
							}
						});
					}
				}
			}
		})
		<%if (roomBNO != 0) {%>
		$(document).ready(function(){
			var endNum = parseInt($("#endNum").val());
			$.ajax({
				url : "/ChatDataLoad.do",
				dataType : "json",
				type : "POST",
				async : false,
				data : {
					roomBNO : roomBNO,
					endNum : endNum 
				},
				success : function(data){
					var nowEndNum = endNum+10;
					$("#endNum").val(nowEndNum);
					var resultData = data;
					for(var i = 0; i < Object.keys(resultData).length; i++){
						var message = resultData[i].split("/");
						var writer = message[0];
						var ms = message[1];
						var date = message[2];
						if(writer == userID){
							var $chat = $("<div class='media w-50 ml-auto mb-3'>"
						    		+"<div class='media-body mt-1 mr-3'>"
						    		+"<div class='bg-primary rounded py-2 px-3 mb-2'>"
						    		+"<p class='text-small mb-0 text-white'>"+ ms +"</p>"
						    		+"</div>"
						    		+"<p class='small text-muted'>"+ date +"</p>"
						    		+"</div>"
						    		+"</div>");
						    		$('#chat-container').prepend($chat);
						    		$('#chat-container').scrollTop($('#chat-container')[0].scrollHeight+20);
						}else{
							var $chat = $("<div class='media w-50 mb-3'>"
			    		    		+"<img src='image/default_user_img.png' alt='user' width='48' class='rounded-circle mt-1'>"
			    		    		+"<div class='media-body mt-1 ml-3'>"
			    		    		+"<p class='small text-muted'>"+writer+"</p>"
			    		    		+"<div class='bg-light rounded py-2 px-3 mb-2'>"
			    		    		+"<p class='text-small mb-0 text-muted'>"+ms+"</p>"
			    		    		+"</div>"
			    		    		+"<p class='small text-muted'>"+date+"</p>"
			    		    		+"</div>"
			    		    		+"</div>");
			    					$('#chat-container').prepend($chat);
			    					$('#chat-container').scrollTop($('#chat-container')[0].scrollHeight+20);
						}
					}
				},
				error : function(){
					console.log("error");							
				}
			});
		})
		<%}%>
	</script>
</body>
</html>