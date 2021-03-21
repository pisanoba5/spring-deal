<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		String img = null;
		if(session.getAttribute("userImg") != null){
			img = (String) session.getAttribute("userImg");
		}
		if(userID == null){
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messsageContent", "현재 로그인이 되어 있지 않습니다.");
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
		function getInfiniteUnRead(){
			setInterval(function(){
				getUnRead();
			}, 4000);
		}
		function showUnRead(result){
			$('#unread').html(result);
		}
		function chatBoxFunction(){
			var userID = '<%=userID%>'
			$.ajax({
				type:"POST",
				url:"/chatBox",
				data:{
					userID : encodeURIComponent(userID),
				},
				success:function(data){
					if(data.list == ""){
						$('#boxTable').append(
								'<tr onclick="">' +
								'<td colspan="4"><h3> - 진행중인 거래 메시지가 없습니다. - </h3></td>' +
								'</tr>'
						);
						return;
					}
					var list = data.list;
					//var unRead = data.unReadList;
					for(var i=0; i < list.length; i++){
						var toID = list[i].toID;
						if(list[i].fromID == userID){
							list[i].fromID = list[i].toID; 
						}else{
							list[i].toID = list[i].fromID;
						}
						addBox(list[i].goodsID,list[i].goodsNAME,list[i].goodsIMG1,list[i].goodsPRICE,list[i].city1,list[i].city2,list[i].fromID, toID, list[i].chatContent, list[i].chatTIme, list[i].state);
					}
				}
			});
		}
		function addBox(goodsID,name,img,price,city1,city2,fromID,toID,chatContent,chatTime,state){
			var user = '<%=userID%>';
			var toID = toID;
			var UnRead=0; 
			$.ajax({
				type:"POST",
				url:"/getUnRead",
				data:{
					fromID : fromID,
					toID : toID,
					goodsID : goodsID
				},
				success:function(data){
					if(data.list == null)return;
					UnRead = data.list.unRead;
					//alert(UnRead);
					if(state == 'Y'){
						if(user == toID && UnRead > 0){
								$('#boxTable').append('<tr onclick="location.href=\'chat?toID='+fromID+'&goodsID='+goodsID+'\'">' +
									'<td style="width:150px;text-align:center;"><img src="/resources/img/'+img+'" style="width:70px;height:70px;"></td>' +
									'<td style="width:150px;text-align:left;">' +
									'<h4>'+name+'</h4>' +
									'<h4 style="color:#006DCC;">'+price+'원</h4>' +
									'<h5>'+city1+'&nbsp;'+city2+'</h5>' +
									'</td>'+
									'<td style="width:150px;text-align:center;">' +
									'<h5>&nbsp;</h5>' +
									'<h5>'+fromID+'</h5>'+
									'</td>' + 
									'<td><h5>&nbsp;</h5>' +
									'<h5><span id="unread" class="label label-info">'+UnRead+'</span>' + chatContent + '</h5>' + 
									'<div class="pull-right"><h5 style="color:#828282">' + chatTime + '</h5></div>' +
									'</td>' +
									'</tr>');
					}else{
								$('#boxTable').append('<tr onclick="location.href=\'chat?toID='+fromID+'&goodsID='+goodsID+'\'">' +
									'<td style="width:150px;text-align:center;"><img src="/resources/img/'+img+'" style="width:70px;height:70px;"></td>' +
									'<td style="width:150px;text-align:left;">' +
									'<h4>'+name+'</h4>' +
									'<h4 style="color:#006DCC;">'+price+'원</h4>' +
									'<h5>'+city1+'&nbsp;'+city2+'</h5>' +
									'</td>'+
									'<td style="width:150px;text-align:center;">' +
									'<h5>&nbsp;</h5>' +
									'<h5>'+fromID+'</h5>'+
									'</td>' + 
									'<td><h5>&nbsp;</h5>' +
									'<h5>'+ chatContent +'</h5>' + 
									'<div class="pull-right"><h5 style="color:#828282">' + chatTime + '</h5></div>' +
									'</td>' +
									'</tr>');
							}
					}else if(state == 'C'){
						$('#boxTable').append('<tr style="background-color:">'+
								'<td style="width:150px;text-align:center;transparent;opacity: 0.3;"><img src="/resources/img/'+img+'" style="width:70px;height:70px;"></td>' +
								'<td style="width:150px;text-align:left;transparent;opacity: 0.3;">' +
								'<h4>'+name+'</h4>' +
								'<h4 style="color:#006DCC;">'+price+'원</h4>' +
								'<h5>'+city1+'&nbsp;'+city2+'</h5>' +
								'</td>'+
								'<td style="width:150px;text-align:center;transparent;opacity: 0.3;">' +
								'<h5>&nbsp;</h5>' +
								'<h5>'+fromID+'</h5>'+
								'</td>' + 
								'<td style="padding-top: 0px;">' +
								'<div style="text-align:right;">'+
									'<a href="javascript:deleteBox('+goodsID+');"><svg xmlns="http://www.w3.org/2000/svg" style="color:red;" width="28" height="28" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">'+
									  '<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>'+
									'</svg></a>'+
								'</div>'+
								'<div style="text-align:center;transparent;opacity: 0.3;">'+
									'<h1 style="display:inline;">판매가</h1> <h1 style="color:#006DCC;display:inline;">완료</h1><h1 style="display:inline;">되었습니다.</h1>'+
								'</div>'+
								'</svg>' +
								'</td>' +
								'</tr>');
					}else if(state == 'N'){
						$('#boxTable').append('<tr style="background-color:">'+
								'<td style="width:150px;text-align:center;transparent;opacity: 0.3;"><img src="/resources/img/'+img+'" style="width:70px;height:70px;"></td>' +
								'<td style="width:150px;text-align:left;transparent;opacity: 0.3;">' +
								'<h4>'+name+'</h4>' +
								'<h4 style="color:#006DCC;">'+price+'원</h4>' +
								'<h5>'+city1+'&nbsp;'+city2+'</h5>' +
								'</td>'+
								'<td style="width:150px;text-align:center;transparent;opacity: 0.3;">' +
								'<h5>&nbsp;</h5>' +
								'<h5>'+fromID+'</h5>'+
								'</td>' + 
								'<td style="padding-top: 0px;">' +
								'<div style="text-align:right;">'+
									'<a href="javascript:cancelBox('+goodsID+');"><svg xmlns="http://www.w3.org/2000/svg" style="color:red;" width="28" height="28" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">'+
									  '<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>'+
									'</svg></a>'+
								'</div>'+
								'<div style="text-align:center;transparent;opacity: 0.3;">'+
									'<h1 style="display:inline;">판매자가 판매를</h1> <h1 style="color:red;display:inline;">취소</h1><h1 style="display:inline;">하였습니다.</h1>'+
								'</div>'+
								'</svg>' +
								'</td>' +
								'</tr>');
					}
				}
			});	
			
		}
		function deleteBox(goodsID){
				$.ajax({
					type:"POST",
					url:"/deleteBox",
					data:{
						goodsID:goodsID
					},
					success:function(result){
						if(result == null) return;
						if(result == 1){
							$('#boxTable').html('');
							chatBoxFunction();
						}else{
							return;
						}
					}
				});
		}
		function cancelBox(goodsID){
			$.ajax({
				type:"POST",
				url:"/cancelBox",
				data:{
					goodsID:goodsID
				},
				success:function(result){
					if(result == null) return;
					if(result == 1){
						$('#boxTable').html('');
						chatBoxFunction();
					}else{
						return;
					}
				}
			});
		}
		function goGInsert(){
			location.href="/ginsert";
		};
		function detail(goodsid,userid){
			location.href="/detail?goodsID="+goodsid+"&&seller="+userid;
		};
		function MyGoodsFunction(){
			var userID = '<%=userID%>'
			$.ajax({
				type:"POST",
				url:"/getMyGoods",
				data:{
					userID:encodeURIComponent(userID)
				},
				success:function(data){
					if(data.list == "" || data.list == null){
						$('#mygoods').append(
								'<tr onclick="">' +
								'<td colspan="3"><h3> - 등록된 상품이 없습니다. - </h3></td>' +
								'</tr>'
						);
					}
					//alert(JSON.stringify(data));
					var list = data.list;
					for(var i=0; i < list.length; i++){
						addMyGoods(list[i].goodsID,list[i].userID,list[i].goodsIMG1,list[i].goodsNAME,list[i].goodsPRICE,list[i].city1,list[i].city2);
					}
					$('#mygoods').append(
							'<tr>'+
								'<td colspan="3">' +
								'<button class="btn btn-primary" style="background-color : #006DCC;" onclick="goGInsert();"><h3>상품등록</h3></button><br>' +
							'</td>' +
						'</tr>'
						);
				}
			});
		}
		function addMyGoods(id,userid,img,name,price,city1,city2){
			$('#mygoods').append(
				'<tr>' + 
					'<td onclick="detail(\''+id+'\',\''+userid +'\');" style="width:150px"><img src="/resources/img/'+img+'"style="width:70px;height:70px;"></td>' +
					'<td onclick="detail(\''+id+'\',\''+userid +'\');" style="text-align:left;"><h4>'+name+'</h4>' +
						'<h4 style="color:#006DCC;">'+price+'원</h4>'+
						'<h5>'+city1+'&nbsp'+city2+'</h5></td>'+
					'</td>' +
					'<td style="width:100px;">'+
						'<p><button style="background-color : #006DCC;" class="confirm btn btn-primary btn-xs" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo" data-id="'+id+'">상품수정</button></p>'+
						'<p><button class="btn btn-danger btn-xs" onclick="deleteGoods('+id+');">판매취소</button></p>' +
						'<p><button class="btn btn-success btn-xs" onclick="completeGoods('+id+');">판매완료</button></p>'+
					'</td>'+
				'</tr>'
			);
		}
		function deleteGoods(goodsID){
			var result = confirm("상품을 취소 하시겠습니까?");
    		if(result){
    			$.ajax({
    				type:"POST",
    				url:"/deleteGoods",
    				data:{
    					goodsID:goodsID
    				},
    				success:function(result){
    					if(result == null) return;
    					if(result == 1){
    						$('#mygoods').html('');
    						MyGoodsFunction();
    						$('#boxTable').html('');
    						chatBoxFunction();
    					}else{
    						return;
    					}
    				}
    			});
    		}else{
    			return false;
    		}
			
		}
		function completeGoods(goodsID){
			var result = confirm("판매완료 처리를 하시겠습니까?");
    		if(result){
    			$.ajax({
    				type:"POST",
    				url:"/completeGoods",
    				data:{
    					goodsID:goodsID
    				},
    				success:function(result){
    					if(result == null) return;
    					if(result == 1){
    						$('#mygoods').html('');
    						MyGoodsFunction();
    						$('#boxTable').html('');
    						chatBoxFunction();
    						
    					}else{
    						return;
    					}
    				}
    			});
    		}else{
    			return false;
    		}
		}
		function getJjimList(){
			var userID = '<%=userID%>';
			$.ajax({
				type:"POST",
				url:"/getJjimList",
				data:{
					userID : encodeURIComponent(userID),
				},
				success:function(data){
					if(data.list == ""){
						$('#jjimBox').append(
								'<tr onclick="">' +
								'<td colspan="4"><h3> - 찜한 상품이 없습니다. - </h3></td>' +
								'</tr>'
						);
						return;
					}
					var list = data.list;
					for(var i=0; i < list.length; i++){		
						addJjimBox(list[i].userID,list[i].goodsIMG1,list[i].goodsID,list[i].goodsNAME,list[i].goodsPRICE,list[i].city1,list[i].city2,list[i].state);
					}
				}
			});
		}
		function addJjimBox(toID,img,goodsID,goodsName,price,city1,city2,state){
			if(state == 'Y'){
				$('#jjimBox').append('<tr>' +
						'<td style="width:150px;text-align:center;"><img  src="/resources/img/'+img+'" style="width:70px;height:70px;"></td>' +
						'<td style="width:150px;text-align:left;">' +
						'<h4>'+goodsName+'</h4>' +
						'<h4 style="color:#006DCC;">'+price+'원</h4>' +
						'<h5>'+city1+'&nbsp;'+city2+'</h5>' +
						'</td>'+
						'<td style="width:150px;text-align:center;">' +
						'<h5>&nbsp;</h5>' +
						'<h5>'+toID+'</h5>'+
						'</td>' + 
						'<td><div style="text-align:right;">'+
						'<a href="javascript:cancelJjimBox('+goodsID+');"><svg xmlns="http://www.w3.org/2000/svg" style="color:red;" width="28" height="28" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">'+
						  '<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>'+
						'</svg></a>'+
						'</div>'+
						'<a class="btn btn-primary" onclick="detail(\''+goodsID+'\', \''+toID +'\');"><h5>상세보기</h5></a>&nbsp;<a class="btn btn-primary" onclick="location.href=\'chat?toID='+toID+'&goodsID='+goodsID+'\'"><h5>메시지 보내기</h5></a></td>' +
						'</tr>');
			}else if(state == 'C'){
				$('#jjimBox').append('<tr style="background-color:">'+
						'<td style="width:150px;text-align:center;transparent;opacity: 0.3;"><img src="/resources/img/'+img+'" style="width:70px;height:70px;"></td>' +
						'<td style="width:150px;text-align:left;transparent;opacity: 0.3;">' +
						'<h4>'+goodsName+'</h4>' +
						'<h4 style="color:#006DCC;">'+price+'원</h4>' +
						'<h5>'+city1+'&nbsp;'+city2+'</h5>' +
						'</td>'+
						'<td style="width:150px;text-align:center;transparent;opacity: 0.3;">' +
						'<h5>&nbsp;</h5>' +
						'<h5>'+toID+'</h5>'+
						'</td>' + 
						'<td style="padding-top: 0px;">' +
						'<div style="text-align:right;">'+
							'<a href="javascript:cancelJjimBox('+goodsID+');"><svg xmlns="http://www.w3.org/2000/svg" style="color:red;" width="28" height="28" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">'+
							  '<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>'+
							'</svg></a>'+
						'</div>'+
						'<div style="text-align:center;transparent;opacity: 0.3;">'+
							'<h1 style="display:inline;">판매가</h1> <h1 style="color:#006DCC;display:inline;">완료</h1><h1 style="display:inline;">되었습니다.</h1>'+
						'</div>'+
						'</svg>' +
						'</td>' +
						'</tr>');
			}else if(state == 'N'){
				$('#jjimBox').append('<tr style="background-color:">'+
						'<td style="width:150px;text-align:center;transparent;opacity: 0.3;"><img src="/resources/img/'+img+'" style="width:70px;height:70px;"></td>' +
						'<td style="width:150px;text-align:left;transparent;opacity: 0.3;">' +
						'<h4>'+goodsName+'</h4>' +
						'<h4 style="color:#006DCC;">'+price+'원</h4>' +
						'<h5>'+city1+'&nbsp;'+city2+'</h5>' +
						'</td>'+
						'<td style="width:150px;text-align:center;transparent;opacity: 0.3;">' +
						'<h5>&nbsp;</h5>' +
						'<h5>'+toID+'</h5>'+
						'</td>' + 
						'<td style="padding-top: 0px;">' +
						'<div style="text-align:right;">'+
							'<a href="javascript:cancelJjimBox('+goodsID+');"><svg xmlns="http://www.w3.org/2000/svg" style="color:red;" width="28" height="28" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">'+
							  '<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>'+
							'</svg></a>'+
						'</div>'+
						'<div style="text-align:center;transparent;opacity: 0.3;">'+
							'<h1 style="display:inline;">판매자가 판매를</h1> <h1 style="color:red;display:inline;">취소</h1><h1 style="display:inline;">하였습니다.</h1>'+
						'</div>'+
						'</svg>' +
						'</td>' +
						'</tr>');
			}
		} 
		function cancelJjimBox(goodsID){
			var userID = '<%=userID%>';
			var goodsID = goodsID
			$.ajax({
				type:"POST",
				url:"/deleteJjim",
				data:{
					userID : userID,
					goodsID : goodsID
				},
				success:function(data){
					if(data == "" || data == null) return;
					if(data == 1){
						$('#jjimBox').html('');
						getJjimList();
					}else{
						return;
					}
				}
			});
		}
		function getInfiniteBox(){
			setInterval(function(){
				chatBoxFunction();
			}, 3000);	
		}
	</script>
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
				<li><a href="/index">메인</a></li>
				<!-- <li><a href="/find">친구찾기</a></li> -->
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
				<li class="active"><a href="/box">마이페이지<span id="unread" class="label label-info"></span></a></li>
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
	<div class="container">
		<table class="table" style="margin:0 auto;">
			<thead>
				<tr>
					<th><h4>거래 메시지 목록</h4></th>
				</tr>
			</thead>
			<div style="overflow-y: auto; width:100%; max-height:450px;">
				<table class="table table-bordered table-hover" style="text-align:center; margin: 0 auto;">
					<thead style="color:#dddddd;">
						<th style="background-color:#666666;">사진</th>
						<th style="background-color:#666666;">상품정보</th>
						<th style="background-color:#666666;">수신자</th>
						<th style="background-color:#666666;">수신내용</th>
					</thead>
					<tbody id="boxTable">
					</tbody>
				</table>
			</div>
		</table>
	</div>
	<div class="container">
		<table class="table" style="margin:0 auto;">
			<thead>
				<tr>
					<th><h4>찜 목록</h4></th>
				</tr>
			</thead>
			<div style="overflow-y: auto; width:100%; max-height:450px;">
				<table class="table table-bordered table-hover" style="text-align:center; margin: 0 auto;">
					<thead style="color:#dddddd;">
						<th style="background-color:#666666;">사진</th>
						<th style="background-color:#666666;">상품정보</th>
						<th style="background-color:#666666;">판매자</th>
						<th style="background-color:#666666;">내용</th>
					</thead>
					<tbody id="jjimBox">
					<!-- <tr onclick="">
					<td><h3> - 찜한 상품이 없습니다. - </h3></td>
					</tr> -->
					</tbody>
				</table>
			</div>
		</table>
	</div>
	<div class="container">
		<table class="table" style="margin:0 auto;">
			<thead>
				<tr>
					<th colspan="3"><h4>내가 올린 상품</h4></th>
				</tr>
			</thead>
			<div style="overflow-y: auto; width:100%; max-height:450px;">
				<table class="table table-bordered table-hover" style="text-align:center; border:1px solid #dddddd; margin: 0 auto;">
					<thead>
						<tr>
							<th style="width:150px;background-color:#666666;">사진</th>
							<th style="background-color:#666666;">상품정보</th>
							<th style="width:100px;background-color:#666666;">수정및취소</th>	
						</tr>	
				</thead>
					<tbody id="mygoods">
					</tbody>
				</table>
			</div>
		</table>
	</div>
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		 <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="exampleModalLabel">비밀번호 확인</h4>
		      </div>
		      <div class="modal-body">
		        <form action="/modifyGoodsPage" method="POST">
		            <input type="hidden" class="form-control" id="userID" name="userID" value="<%=userID%>">
		            <input type="hidden" class="form-control" id="goodsID" name="goodsID" value=""/>
		          <div class="form-group">
		            <label for="message-text" class="control-label">비밀번호</label>
		            <input type="password" class="form-control" id="userPassword" name="userPassword">
		          </div>
		          <div class="form-group">
		         	 <input type="submit" class="btn btn-primary" value="확인">
		             <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> 
		          </div>
		        </form>
		      </div>
		      <div class="modal-footer">
		       
		      </div>
		    </div>
		  </div>
		</div>
	<br>
	<br>
	<footer class="blog-footer">
		<h3>Email : tmdghks7898@naver.com</h3>
		<h3>전화번호 : 010-8811-7242</h3>
		<p>* 모든 상품들은 포트폴리오 이해를 돕기 위한 허구의 상품들입니다.</p>
	</footer>
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
		<%
			if(userID != null){
				
		%>
			<script type="text/javascript">
				$(document).ready(function(){
					getUnRead();
					getJjimList();
					MyGoodsFunction();
					chatBoxFunction();
				});
				$(document).on("click", ".confirm", function () {
					var id = $(this).data('id'); 
					$(".modal-body #goodsID").val(id); 
				});
			</script>
		<%
			}
		%>
</body>
</html>