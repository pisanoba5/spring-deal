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
		String goodsID = null;
		if(request.getParameter("goodsID") != null){
			goodsID = (String) request.getParameter("goodsID");
		}
		String seller = null;
		if(request.getParameter("seller") != null){
			seller = request.getParameter("seller");
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
	/* function gmodify(id){
		$.ajax({
			type:"POST",
			url:"/gmodify"
			data:{
				goodsID : Nimber(id)
			}
			success
		});
		location.href="/gmodify?goodsID="+id;
	} */
	function getGoodsDetail(){
		$.ajax({
			type:"POST",
			url:"/getGoods",
			data:{
				goodsID : Number('<%=goodsID%>'),
				userID : '<%=seller%>'
			},
			success:function(data){
				if(data == null) return;
				var list = data.list;
				//alert(JSON.stringify(data));
				if(list.goodsIMG2 == null){
					getDetail1(list.userID,list.goodsID,list.goodsNAME, list.goodsPRICE, list.city1, list.city2, list.goodsCONTENT, list.goodsHIT,list.goodsIMG1,list.userImg);	
				}else if(list.goodsIMG3 == null){
					getDetail2(list.userID,list.goodsID,list.goodsNAME, list.goodsPRICE, list.city1, list.city2, list.goodsCONTENT, list.goodsHIT,list.goodsIMG1,list.goodsIMG2,list.userImg);
				}else{
					getDetail3(list.userID,list.goodsID,list.goodsNAME, list.goodsPRICE, list.city1, list.city2, list.goodsCONTENT, list.goodsHIT,list.goodsIMG1,list.goodsIMG2,list.goodsIMG3,list.userImg);
				}
			}
		});
	}
	function getDetail1(userid,goodsid,name,price,city1,city2,content,hit,img1,userimg){
		var userID = '<%=userID%>';
		var seller = '<%=seller%>';
		if(userID == "null" || userID == seller){
			$('#buttonList').append(
					'<button class="btn btn-primary" style="background-color:#006DCC;" onclick="hit('+goodsid+');"><h5>좋아요'+hit+'</h5></button>&nbsp;'			
				);
		}else{
			$('#buttonList').append(
					'<button class="btn btn-primary" style="background-color:#006DCC;" onclick="hit('+goodsid+');"><h5>좋아요'+hit+'</h5></button>&nbsp;'+
					'<button class="btn btn-primary" style="background-color:#006DCC;" onclick="jjim('+goodsid+');"><h5>찜하기</h5></button>&nbsp;' +
					'<a id="messageSubmit" class="btn btn-primary" style="background-color:#006DCC;" href="/chat?toID='+userid+'&goodsID='+goodsid+'"><h5>메시지 보내기</h5></a>' 
				);
		}
		$('#goodsDetail').append(
				'<div class="row">' +
				'<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">' +
				  '<ol class="carousel-indicators">' +
				    '<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>' +
				  '</ol>' +
				  '<div class="carousel-inner" role="listbox">' +
				    '<div class="item active" style="">' +
				      '<img class="img-responsive center-block" src="/resources/img/'+img1+'" alt="..." style="width:40%; height:400px;">' +
				      '<div class="carousel-caption">' +
				      '</div>' +
				    '</div>' +
				  '</div>' + 
				  '<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev" style="background-image: none">' +
				    '<span class="glyphicon glyphicon-chevron-left" aria-hidden="true" style="color:#006DCC"></span>' +
				    '<span class="sr-only">Previous</span>' +
				  '</a>' +
				  '<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next" style="background-image: none">' +
				    '<span class="glyphicon glyphicon-chevron-right" aria-hidden="true" style="color:#006DCC"></span>' +
				    '<span class="sr-only">Next</span>'+
				  '</a>' +
				'</div>' +
			'</div>' +
			'<hr style="border: solid 1px #dddddd;">' +
			'<img src="/resources/img/'+userimg+'" class="img-circle" style="width:40px;height:40px; border:3px solid #006DCC;display:inline;">&nbsp;<h3 style="display:inline;">'+userid+'</h3>'+
			'<h2>'+name+'</h2>' + 
			'<h3 style="color:#006DCC">'+price +'원'+'</h3>' +
			'<strong><h5>'+city1+'</strong>&nbsp;<strong>'+city2+'</h5></strong>' +
			'<br>'+
			'<h5>'+content+'</h5>' +
			'<hr style="border: solid 1px #dddddd;">'
		 );
	}
	function getDetail2(userid,goodsid,name,price,city1,city2,content,hit,img1,img2,userimg){
		var userID = '<%=userID%>';
		var seller = '<%=seller%>';
		if(userID == "null" || userID == seller){
			$('#buttonList').append(
					'<button class="btn btn-primary" style="background-color:#006DCC;" onclick="hit('+goodsid+');"><h5>좋아요'+hit+'</h5></button>&nbsp;'			
				);
		}else{
			$('#buttonList').append(
					'<button class="btn btn-primary" style="background-color:#006DCC;" onclick="hit('+goodsid+');"><h5>좋아요'+hit+'</h5></button>&nbsp;'+
					'<button class="btn btn-primary" style="background-color:#006DCC;" onclick="jjim('+goodsid+');"><h5>찜하기</h5></button>&nbsp;' +
					'<a id="messageSubmit" class="btn btn-primary" style="background-color:#006DCC;" href="/chat?toID='+userid+'&goodsID='+goodsid+'"><h5>메시지 보내기</h5></a>' 
				);
		}
		$('#goodsDetail').append(
				'<div class="row">' +
				'<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">' +
				  '<ol class="carousel-indicators">' +
				    '<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>' +
				    '<li data-target="#carousel-example-generic" data-slide-to="1"></li>' +
				  '</ol>' +
				  '<div class="carousel-inner" role="listbox">' +
				    '<div class="item active">' +
				      '<img class="img-responsive center-block" src="/resources/img/'+img1+'" alt="..." style="width:50%; height:100%;">' +
				      '<div class="carousel-caption">' +
				      '</div>' +
				    '</div>' +
				    '<div class="item">' +
				      '<img class="img-responsive center-block" src="/resources/img/'+img2+'" alt="..." style="width:50%; height:100%;">' +
				      '<div class="carousel-caption">' +
				      '</div>' +
				     '</div>' +
					'</div>' + 
				  '<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev" style="background-image: none">' +
				    '<span class="glyphicon glyphicon-chevron-left" aria-hidden="true" style="color:#006DCC"></span>' +
				    '<span class="sr-only">Previous</span>' +
				  '</a>' +
				  '<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next" style="background-image: none">' +
				    '<span class="glyphicon glyphicon-chevron-right" aria-hidden="true" style="color:#006DCC"></span>' +
				    '<span class="sr-only">Next</span>'+
				  '</a>' +
				'</div>' +
			'</div>' +
			'<br>' +
			'<hr style="border: solid 1px #dddddd;">' +
			'<img src="/resources/img/'+userimg+'" class="img-circle" style="width:40px;height:40px; border:3px solid #006DCC;display:inline;">&nbsp;<h3 style="display:inline;">'+userid+'</h3>'+
			'<h2>'+name+'</h2>' + 
			'<h3 style="color:#006DCC">'+price +'원'+'</h3>' +
			'<h5>'+city1+'</strong>&nbsp;<strong>'+city2+'</h5>' +
			'<br>'+
			'<h5>'+content+'</h5>' +
			'<hr style="border: solid 1px #dddddd;">'
		 );
	}
	function getDetail3(userid,goodsid,name,price,city1,city2,content,hit,img1,img2,img3,userimg){
		var userID = '<%=userID%>';
		var seller = '<%=seller%>';
		if(userID == "null" || userID == seller){
			$('#buttonList').append(
					'<button class="btn btn-primary" style="background-color:#006DCC;" onclick="hit('+goodsid+');"><h5>좋아요'+hit+'</h5></button>&nbsp;'			
				);
		}else{
			$('#buttonList').append(
					'<button class="btn btn-primary" style="background-color:#006DCC;" onclick="hit('+goodsid+');"><h5>좋아요'+hit+'</h5></button>&nbsp;'+
					'<button class="btn btn-primary" style="background-color:#006DCC;" onclick="jjim('+goodsid+');"><h5>찜하기</h5></button>&nbsp;' +
					'<a id="messageSubmit" class="btn btn-primary" style="background-color:#006DCC;" href="/chat?toID='+userid+'&goodsID='+goodsid+'"><h5>메시지 보내기</h5></a>' 
				);
		}
		$('#goodsDetail').append(
				'<div class="row">' +
				'<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">' +
				  '<ol class="carousel-indicators">' +
				    '<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>' +
				    '<li data-target="#carousel-example-generic" data-slide-to="1"></li>' +
				    '<li data-target="#carousel-example-generic" data-slide-to="2"></li>' +
				  '</ol>' +
				  '<div class="carousel-inner" role="listbox">' +
				    '<div class="item active">' +
				      '<img class="img-responsive center-block" src="/resources/img/'+img1+'" alt="..." style="width:40%; height:400px;">' +
				      '<div class="carousel-caption">' +
				      '</div>' +
				    '</div>' +
				    '<div class="item">' +
				      '<img class="img-responsive center-block" src="/resources/img/'+img2+'" alt="..." style="width:40%; height:400px;">' +
				      '<div class="carousel-caption">' +
				      '</div>' +
				     '</div>' +
				     '<div class="item">' +
				      '<img class="img-responsive center-block" src="/resources/img/'+img3+'" alt="..." style="width:40%; height:400px;">' +
				      '<div class="carousel-caption">' +
				      '</div>' +
				     '</div>' +
					'</div>' + 
				  '<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev" style="background-image: none">' +
				    '<span class="glyphicon glyphicon-chevron-left" aria-hidden="true" style="color:#006DCC"></span>' +
				    '<span class="sr-only">Previous</span>' +
				  '</a>' +
				  '<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next" style="background-image: none">' +
				    '<span class="glyphicon glyphicon-chevron-right" aria-hidden="true" style="color:#006DCC"></span>' +
				    '<span class="sr-only">Next</span>'+
				  '</a>' +
				'</div>' +
			'</div>' +
			'<hr style="border: solid 1px #dddddd;">' +
			'<img src="/resources/img/'+userimg+'" class="img-circle" style="width:40px;height:40px; border:3px solid #006DCC;display:inline;">&nbsp;<h3 style="display:inline;">'+userid+'</h3>'+
			'<h2>'+name+'</h2>' + 
			'<h3 style="color:#006DCC">'+price +'원'+'</h3>' +
			'<h5>'+city1+'&nbsp;'+city2+'</h5>' +
			'<br>'+
			'<h5>'+content+'</h5>' +
			'<hr style="border: solid 1px #dddddd;">'
		 );
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
		function hit(id){
			var goodsID = id;
			var userID = '<%=userID%>'; 
			if(userID === null || userID === "" || userID == "null"){
				alert("로그인 해주세요.");
				location.href="/login";
			}else{
				$.ajax({
					type:"POST",
					url:"/addHit",
					data:{goodsID:goodsID,
						  userID:userID
					},
					success:function(data){
						if(data == 1){
							alert("좋아요! 감사합니다.");
							$('#buttonList').html('');
							$('#goodsDetail').html('');
							getGoodsDetail();
						}else{
							alert("좋아요는 한번만 가능합니다.");
							return;
						}
					}
				});
			}	
		}
		function jjim(id){
			var goodsID = id;
			var userID = '<%=userID%>'; 
			if(userID === null || userID === "" || userID == "null"){
				alert("로그인 해주세요.");
				location.href="/login";
			}else{
				$.ajax({
					type:"POST",
					url:"/addJjim",
					data:{goodsID:goodsID,
						  userID:userID
					},
					success:function(data){
						if(data == 1){
							alert("찜한 목록은 마이페이지에서 확인할 수 있습니다.");
							$('#buttonList').html('');
							$('#goodsDetail').html('');
							getGoodsDetail();
						}else{
							alert("이미 찜한 상품입니다.");
							return;
						}
					}
				});
			}	
		}
		function getJjimGoodsList(){
			$.ajax({
				type:"POST",
				url:"/getJjimGoodsList",
				data:{
				},
				success:function(data){
					if(data == null) return;
					var list = data.list
					for(var i=0; i<list.length; i++){
						GoodsList(list[i].goodsID,list[i].userID,list[i].goodsNAME, list[i].goodsPRICE, list[i].city1, list[i].city2, list[i].goodsIMG1,list[i].goodsHIT);	
					}
				}
			});
		}
		function GoodsList(id,userid,name,price,city1,city2,img,hit){
			$('#goodGoods').append(
			'<a href="/detail?goodsID='+id+'&&seller='+userid+'">' +
			  '<div class="col-sm-6 col-md-4">' +
			    '<div class="thumbnail">' +
			      '<img class="img-rounded" src="/resources/img/'+img+'"alt="..." style="width:200px;height:200px;">' +
			      '<div class="caption">' +
			        '<h3>'+name+'</h3>' +
			        '<h4 style="color:#006DCC;">'+price+'원'+'</h4>' +
			        '<h5>'+city1+'&nbsp;'+city2+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<svg xmlns="http://www.w3.org/2000/svg" style="color:#006DCC" width="19" height="19" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16"><path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.964.22.817.533 2.512.062 4.51a9.84 9.84 0 0 1 .443-.05c.713-.065 1.669-.072 2.516.21.518.173.994.68 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.162 3.162 0 0 1-.488.9c.054.153.076.313.076.465 0 .306-.089.626-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.826 4.826 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.616.849-.231 1.574-.786 2.132-1.41.56-.626.914-1.279 1.039-1.638.199-.575.356-1.54.428-2.59z"/>' +
					'</svg>'+hit+'</h5>' + 
			      '</div>' +
			    '</div>' +
			    '</div>' +
			 '</a>'
			 );
		}
		function chat(id){
			alert(id);
			location.href="/chat?toID="+id;
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
	<div id="goodsDetail" class="container">
	</div>
	<div id="buttonList" class="container" style="text-align:right;">
	</div>
	<div class="container">
		<h1>인기상품</h1>
		<div id="goodGoods" class="row">
		</div>
		<div class="row" style="text-align:center;">
				<div class="col-sm-12">
					<a href="/getAllNewGoodsList" class="btn btn-primary" style="background-color : #006DCC;padding-top: 0px;padding-bottom: 0px;"><h5><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
					  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
					  <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
					</svg>&nbsp;더보기</h5></a>
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
		<%
			session.removeAttribute("messageContent");
			session.removeAttribute("messageType");
			}
		%>
		</script>
		<%
			if(userID != null){
				
		%>
			<script type="text/javascript">
				$(document).ready(function(){
					/* getInfiniteUnRead(); */
					getGoodsDetail();
					getUnRead();
					getJjimGoodsList();
				});
			</script>
		<%
			}else{
		%>
			<script type="text/javascript">
				$(document).ready(function(){
					/* getInfiniteUnRead(); */
					getGoodsDetail();
					getJjimGoodsList();
				});
			</script>
		<%
			}
		%>
</body>
</html>