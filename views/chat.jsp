<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		String toID = null;
		if(request.getParameter("toID") != null){
			toID = (String) request.getParameter("toID");
		}
		String img = null;
		if(session.getAttribute("userImg") != null){
			img = (String) session.getAttribute("userImg");
		}
		int goodsID = 0;
		if(request.getParameter("goodsID") != null){
			goodsID = Integer.parseInt(request.getParameter("goodsID"));
		}
		if(userID == null){
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messsageContent", "현재 로그인이 되어 있지 않습니다.");
			response.sendRedirect("/index");
			return;
		}
		if(toID == null){
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messsageContent", "대화 상대가 지정되지 않았습니다.");
			response.sendRedirect("/index");
			return;
		}
	%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="/resources/css/bootstrap.css">
	<link rel="stylesheet" href="/resources/css/custom.css">
	<title>파란마켓</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="/resources/js/bootstrap.js"></script>
	<script type="text/javascript">
		function autoClosingAlert(selector, delay){
			var alert = $(selector).alert();
			alert.show();
			window.setTimeout(function(){alert.hide()}, delay);
		}
		function getChatGoods(){
			var goodsID = '<%= goodsID%>';
			$.ajax({
				type:"POST",
				url: "/getChatGoods",
				data : {
					goodsID : goodsID
				},
				success : function(data){
					if(data==null || data=="null") return;
					var list = data.list;
					addGoods(list.goodsNAME,list.goodsPRICE,list.city1,list.city2,list.goodsIMG1)
				}
			});
			$('#chatContent').val('');
		}
		function addGoods(name,price,city1,city2,img){
			$('#goodsInfo').append(
					'<tr>'+
					'<td style="text-align:center;width:150px;"><img class="img-rounded" src="/resources/img/'+img+'" style="width:90px; height:90px;"></td>'+
					'<td style="text-align:left;"><h3>'+name+'</h3><h4 style="color:#006DCC;">'+price+'원</h4><h5>'+city1+'&nbsp'+city2+'</h5></td>'	+			
					'</tr>'
			);
		}
		function submitFunction(){
			var fromID = '<%= userID %>';
			var toID = '<%= toID %>';
			var goodsID = '<%= goodsID%>';
			var chatContent = $('#chatContent').val();
			$.ajax({
				type:"POST",
				url: "/chatSubmit",
				data : {
					fromID : fromID,
					toID : toID,
					goodsID : goodsID,
					chatContent : chatContent,
				},
				success : function(result){
					if(result == 1){
						autoClosingAlert('#successMessage', 200);
					}else if(result == 0){
						autoClosingAlert('#dangerMessage', 200);
					}else{
						autoClosingAlert('#warningMessage', 200);
					}
				}
			});
			$('#chatContent').val('');
		}
		var chatID;
		function chatListFunction(lastID){
			var fromID = '<%= userID %>';
			var toID = '<%= toID %>';
			var goodsID = '<%= goodsID%>';
			$.ajax({
				type:"POST",
				url : "/userChatList",
				data : {
					fromID : fromID,
					toID : toID,
					goodsID : goodsID,
					chatID : Number(lastID)
				},
				success: function(obj){
					if(obj == "") return;
					var list = obj.list;
					//alert(JSON.stringify(list));
					var lastID = obj.lastID;
					for(var i = 0; i < list.length; i++){
						addChat(list[i].fromID,list[i].chatContent,list[i].chatTIme,list[i].userImg);
					}
					chatID = lastID;
				}
			});
		}
		function addChat(chatName,chatContent,chatTime,img){
			var userID = '<%=userID%>';
			if(userID==chatName){
				$('#chatList').append(
						'<div class="chat">'+
				         '<div class="chat-avatar">'+
				           '<a class="avatar avatar-online" data-toggle="tooltip" href="#" data-placement="right" title="" data-original-title="June Lane">'+
				           '<img src="/resources/img/'+img+'" alt="...">'+
				              '<i></i>'+
				            '</a>'+
				          '</div>'+
				          '<div class="chat-body">'+
				            '<div class="chat-content">'+
				              '<p>'+
				                '<h5>'+chatName+'</h5>'+
				                '<h4>'+chatContent+'</h4>'+
				              '</p>'+
				             '<time class="chat-time" datetime="2015-07-01T11:37">'+chatTime+'</time>'+
				            '</div>'+
				          '</div>'+
				        '</div>'
				      
				)
			}else{
				$('#chatList').append(
						  '<div class="chat chat-left">'+
				          '<div class="chat-avatar">'+
				            '<a class="avatar avatar-online" data-toggle="tooltip" href="#" data-placement="left" title="" data-original-title="Edward Fletcher">'+
				            	'<img src="/resources/img/'+img+'" alt="...">'+
				              '<i></i>'+
				            '</a>'+
				          '</div>'+
				          '<div class="chat-body">'+
				            '<div class="chat-content">'+
				            '<h5>'+chatName+'</h5>'+
			                '<h4>'+chatContent+'</h4>'+
				              '<time class="chat-time" datetime="2015-07-01T11:39">'+chatTime+'</time>'+
				            '</div>'+
				          '</div>'+
				        '</div>'
				)
			};
			$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
		}
		function getInfiniteChat(){
			setInterval(function(){
				chatListFunction(chatID);
			}, 3000);
		}
		function getUnRead(){
			$.ajax({
				type:"POST",
				url:"/chatUnRead",
				data:{
					userID : encodeURIComponent('<%=userID%>'),
				},
				success:function(result){
					if(result >= 1){
						showUnRead(result);
					}else{
						showUnRead('');
					}
				}
			});
		}
		/* function getInfiniteUnRead(){
			setInterval(function(){
				getUnRead();
			}, 4000);
		} */
		function showUnRead(result){
			$('#unread').html(result);
		}
	</script>
	<style>
		
body {
background:#ddd;
margin-top:10px;
}

.chat-box {
    height: 100%;
    width: 100%;
    background-color: #fff;
    overflow: hidden
}

.chats {
    padding: 30px 15px
}

.chat-avatar {
    float: right
}

.chat-avatar .avatar {
    width: 30px
        -webkit-box-shadow: 0 2px 2px 0 rgba(0,0,0,0.2),0 6px 10px 0 rgba(0,0,0,0.3);
    box-shadow: 0 2px 2px 0 rgba(0,0,0,0.2),0 6px 10px 0 rgba(0,0,0,0.3);
}

.chat-body {
    display: block;
    margin: 10px 30px 0 0;
    overflow: hidden
}

.chat-body:first-child {
    margin-top: 0
}

.chat-content {
    position: relative;
    display: block;
    float: right;
    padding: 8px 15px;
    margin: 0 20px 10px 0;
    clear: both;
    color: #fff;
    background-color: #62a8ea;
    border-radius: 4px;
        -webkit-box-shadow: 0 1px 4px 0 rgba(0,0,0,0.37);
    box-shadow: 0 1px 4px 0 rgba(0,0,0,0.37);
}

.chat-content:before {
    position: absolute;
    top: 10px;
    right: -10px;
    width: 0;
    height: 0;
    content: '';
    border: 5px solid transparent;
    border-left-color: #62a8ea
}

.chat-content>p:last-child {
    margin-bottom: 0
}

.chat-content+.chat-content:before {
    border-color: transparent
}

.chat-time {
    display: block;
    margin-top: 8px;
    color: rgba(255, 255, 255, .6)
}

.chat-left .chat-avatar {
    float: left
}

.chat-left .chat-body {
    margin-right: 0;
    margin-left: 30px
}

.chat-left .chat-content {
    float: left;
    margin: 0 0 10px 20px;
    color: #76838f;
    background-color: #dfe9ef
}

.chat-left .chat-content:before {
    right: auto;
    left: -10px;
    border-right-color: #dfe9ef;
    border-left-color: transparent
}

.chat-left .chat-content+.chat-content:before {
    border-color: transparent
}

.chat-left .chat-time {
    color: #a3afb7
}

.panel-footer {
    padding: 0 30px 15px;
    background-color: transparent;
    border-top: 1px solid transparent;
    border-bottom-right-radius: 3px;
    border-bottom-left-radius: 3px;
}
.avatar img {
    width: 100%;
    max-width: 100%;
    height: auto;
    border: 0 none;
    border-radius: 1000px;
}
.chat-avatar .avatar {
    width: 30px;
}
.avatar {
    position: relative;
    display: inline-block;
    width: 40px;
    white-space: nowrap;
    border-radius: 1000px;
    vertical-align: bottom;
}
	</style>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/index" style="font-size:30px;">파란마켓</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right">
				<li style="margin-top: 18px;margin-right: 15px;">
					<form class="form-inline" action="/search" method="GET">
					  <input type="text" id="goodsNAME" name="goodsNAME" class="form-control" placeholder="상품이름을 입력해주세요.">
					  <button class="btn btn-outline-default" type="submit" id="button-addon2"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
						  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
						</svg></button>
					</form>
				</li>
				<li class="active"><a href="/index">메인</a></li>	
			<%
				if(userID == null){
			%>
				
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="/login">로그인</a></li>
						<li><a href="/join">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else{
			%>
				<li><a href="/box">마이페이지<span id="unread" class="label label-info"></span></a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li style="text-align:center;"><img src="/resources/img/<%=img%>" class="img-circle" style="width:50px;height:50px; border:3px solid #006DCC;display:inline;"><h4 style="color:#006DCC;"><%=userID%></h4></li>
						<li><a href="/modify"><h5>회원수정</h5></a></li>
						<li><a href="/logoutAction"><h5>로그아웃</h5></a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container bootstrap snippets bootdeys" >
		<div class="col-md-7 col-xs-12 col-md-offset-2">
		  <!-- Panel Chat -->
		  <div class="panel" id="chat">
		    <table id="goodsInfo" class="table">
		     	
		    </table>
		    <div class="panel-body">
		      <div id="chatList" class="chats" style="overflow:auto; width:600px; height:500px;">
		        
		      </div> 
		    </div>
		    <div class="panel-footer">
		      <form>
		        <div class="input-group">
		          <textarea id="chatContent" class="form-control" placeholder="메시지를 입력해주세요." maxlength="100"></textarea>
		          <span class="input-group-btn">
		            <button class="btn btn-primary" type="button" onclick="submitFunction();">전송</button>
		          </span>
		        </div>
		      </form>
		    </div>
		  </div>
		  <!-- End Panel Chat -->
		</div>
	</div>
	<br>
	<br>
	<footer class="blog-footer">
		<h3>Email : tmdghks7898@naver.com</h3>
		<h3>전화번호 : 010-8811-7242</h3>
		<p>* 모든 상품들은 포트폴리오 이해를 돕기 위한 허구의 상품들입니다.</p>
	</footer>
	<div class="alert alert-success" id="successMessage" style="display:none;">
		<strong>메시지 전송에 성공했습니다.</strong>
	</div>
	<div class="alert alert-danger" id="dangerMessage" style="display:none;">
		<strong>이름과 내용을 모두 입력해주세요.</strong>
	</div>
	<div class="alert alert-warning" id="warningMessage" style="display:none;">
		<strong>데이터베이스 오류가 발생했습니다.</strong>
	</div>
	<%
		String messageContent = null;
		if(session.getAttribute("messageContent") != null){
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if(session.getAttribute("messageType") != null){
			messageType = (String) session.getAttribute("messageType");
		}
		if(messageContent != null){
	%>
		<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog vertical-align-center">
					<div class="modal-centent <% if(messageType.equals("오류 메시지")) out.println("panel-warning"); else out.println("panel-success");%>">
						<div class="modal-header panel-heading">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times</span>
								<span class="sr-only">close</span>
							</button>
							<h4 class="modal-title">
								<%= messageType %>
							</h4>
						</div>
						<div class="modal-body">
							<%= messageContent %>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			$('#messageModal').modal("show");
		</script>
		<%
			session.removeAttribute("messageContent");
			session.removeAttribute("messageType");
			}
		%>
		<script type="text/javascript">
			$(document).ready(function(){
				getChatGoods();
				chatListFunction(0);
				getInfiniteChat();
				/* getInfiniteUnRead(); */
				getUnRead();
			});
		</script>
</body>
</html>