<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="/resources/css/bootstrap.css">
	<link rel="stylesheet" href="/resources/css/custom.css">
	<title>파란마켓</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="/resources/js/bootstrap.js"></script>
	<script type="text/javascript">
		function getNewGoodsList(){
			$.ajax({
				type:"POST",
				url:"/getNewGoodsList",
				data:{
				},
				success:function(data){
					if(data == null) return;
					var list = data.list
					for(var i=0; i<list.length; i++){
						newGoodsList(list[i].goodsID,list[i].goodsNAME, list[i].goodsPRICE, list[i].city1, list[i].city2, list[i].goodsIMG1);	
					}
				}
			});
		}
		/* function newGoodsList(id,name,price,city1,city2,img){
			$('#newGoods').append(
			'<a href="/detail?goodsID='+id+'">' +
			  '<div class="col-sm-6 col-md-4">' +
			    '<div class="thumbnail">' +
			      '<img class="img-rounded" src="/resources/img/'+img+'"alt="..." style="width:200px;height:200px;">' +
			      '<div class="caption">' +
			        '<h3>'+name+'</h3>' +
			        '<h4 style="color:#006DCC;">'+price+'원'+'</h4>' +
			        '<h5>'+city1+'&nbsp;'+city2+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<svg xmlns="http://www.w3.org/2000/svg" style="color:#006DCC" width="19" height="19" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16"><path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.964.22.817.533 2.512.062 4.51a9.84 9.84 0 0 1 .443-.05c.713-.065 1.669-.072 2.516.21.518.173.994.68 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.162 3.162 0 0 1-.488.9c.054.153.076.313.076.465 0 .306-.089.626-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.826 4.826 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.616.849-.231 1.574-.786 2.132-1.41.56-.626.914-1.279 1.039-1.638.199-.575.356-1.54.428-2.59z"/>' +
					'</svg></h5>' + 
			      '</div>' +
			    '</div>' +
			    '</div>' +
			 '</a>'
			 );
		} */
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
		function getCity(){
			var city1 = $('#city1').val();
			$.ajax({
				type:"POST",
				url:"/getCity",
				data:{
					city1: city1
				},
				success:function(data){
					if(data == null) return;
					$('#city2').html("");
					var list = data.list;
					for(var i=0; i<list.length; i++){
						addCity(list[i].city2);
					}
				}
			});
		}
		function addCity(city){
			$('#city2').append(
				'<option value="'+ city +'">'+ city + '</option>'
			);
		}
		function chkForm(form){
			var city1 = document.getElementsByName('city1');
			var city2 = document.getElementsByName('city2');
			var allchk = document.getElementsByName('allGoodsCATE');
			var chkbox = document.getElementsByName('goodsCATE');
			var num = 0;
			if(city1==null||city1=="null"||city2 == null||city2=="null"){
				alert("지역을 설정해 주세요");
				return false;
			}
			for(var i=0;i<chkbox.length; i++){
				if(chkbox[i].checked){
					num++;
				}
			}
			if(!num){
				alert("카테고리를 하나이상 선택해주세요.");
				return false;
			}
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
	<div class="container">
		<table class="table" style="margin:0 auto;">
			<thead>
				<tr>
					<th><h4>상세조회</h4></th>
				</tr>
			</thead>
			<div style="overflow-y: auto; width:100%; max-height:450px;">
				<form action="/detailsearch" method="get" onsubmit="return chkForm(this);">
				<table class="table table-bordered table-hover" style="text-align:center; border:1px solid #dddddd; margin: 0 auto;">
					<tbody>
						<tr style="text-align:center;">
							<td>
								<select id="city1" name="city1" onclick="getCity();"  class="form-select form-select-lg mb-3" aria-label=".form-select-sm example">
									<option value="경기">경기</option>
									<option value="서울">서울</option>
									<option value="강원">강원</option>
									<option value="충북">충북</option>
									<option value="충남">충남</option>
									<option value="경북">경북</option>
									<option value="경남">경남</option>
									<option value="전북">전북</option>
									<option value="전남">전남</option>
									<option value="세종">세종</option>
									<option value="인천">인천</option>
									<option value="대구">대구</option>
									<option value="대전">대전</option>
									<option value="광주">광주</option>
									<option value="제주">제주</option>
								</select>
							</td>
							<td>
								<select id="city2" name="city2" class="form-select form-select-sm" aria-label=".form-select-sm example">
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:center;">
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="checkbox" id="allGoodsCATE" name="allGoodsCATE" value="전체" checked>
								  <label class="form-check-label" for="inlineCheckbox1" >전체</label>&nbsp;&nbsp;&nbsp;
								  <input class="form-check-input" type="checkbox" id="goodsCATE1" name="goodsCATE" value="가전제품" checked>
								  <label class="form-check-label" for="inlineCheckbox1" >가전제품</label>&nbsp;&nbsp;&nbsp;
								  <input class="form-check-input" type="checkbox" id="goodsCATE2" name="goodsCATE" value="가구" checked>
								  <label class="form-check-label" for="inlineCheckbox1" >가구</label>&nbsp;&nbsp;&nbsp;
								  <input class="form-check-input" type="checkbox" id="goodsCATE3" name="goodsCATE" value="운동기구" checked>
								  <label class="form-check-label" for="inlineCheckbox1" >운동기구</label>&nbsp;&nbsp;&nbsp;
								  <input class="form-check-input" type="checkbox" id="goodsCATE4" name="goodsCATE" value="책" checked>
								  <label class="form-check-label" for="inlineCheckbox1" >책</label>&nbsp;&nbsp;&nbsp;
								  <input class="form-check-input" type="checkbox" id="goodsCATE5" name="goodsCATE" value="문구" checked>
								  <label class="form-check-label" for="inlineCheckbox1" >문구</label>&nbsp;&nbsp;&nbsp;
								  <input class="form-check-input" type="checkbox" id="goodsCATE6" name="goodsCATE" value="잡화" checked>
								  <label class="form-check-label" for="inlineCheckbox1" >잡화</label>&nbsp;&nbsp;&nbsp;
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="btn-group" data-toggle="buttons">
								  <label class="btn btn-default active" >
								    <input type="radio" id="option1" name="goodsPRICE" value="1" checked> <h5>10만원 이하</h5>
								  </label>
								  <label class="btn btn-default" >
								    <input type="radio"id="option2" name="goodsPRICE"  value="2"> <h5>10~20만원</h5>
								  </label>
								  <label class="btn btn-default" >
								    <input type="radio" id="option3" name="goodsPRICE" value="3"> <h5>20~30만원</h5>
								  </label>
								   <label class="btn btn-default" >
								    <input type="radio" id="option4" name="goodsPRICE" value="4"> <h5>30~40만원</h5>
								  </label>
								   <label class="btn btn-default">
								    <input type="radio" id="option5" name="goodsPRICE" value="5"> <h5>40~50만원</h5>
								  </label>
								  <label class="btn btn-default" >
								    <input type="radio" id="option5" name="goodsPRICE" value="6"> <h5>50만원 이상</h5>
								  </label>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:right;">
								<button class="btn btn-primary" style="background-color : #006DCC;" data-dismiss="modal">검색</button>
							</td>
						</tr>
					</tbody>
				</table>
				</form>
			</div>
		</table>
	</div>
	<br>
	<br>
	<div class="container">
		<h1>검색 결과</h1>
			<div id="newGoods" class="row">
				<c:if test="${empty info}">
					<div class="row">
							<div class="col" style="text-align:center;">
								<h1> - 검색결과가 없습니다. - </h1>
							</div>
						</div>
				</c:if>
				<c:forEach var="list" items="${info}" varStatus="status">
					<a href="/detail?goodsID=${list.goodsID}&&seller=${list.userID}">
					  <div class="col-sm-6 col-md-4">
					    <div class="thumbnail">
					      <img class="img-rounded" src="/resources/img/${list.goodsIMG1}" alt="..." style="width:200px;height:200px;">
					      <div class="caption">
					        <h3>${list.goodsNAME}</h3>
					        <h4 style="color:#006DCC;">${list.goodsPRICE}원</h4>
					        <h5>${list.city1}&nbsp;${list.city2}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<svg xmlns="http://www.w3.org/2000/svg" style="color:#006DCC" width="19" height="19" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16"><path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.964.22.817.533 2.512.062 4.51a9.84 9.84 0 0 1 .443-.05c.713-.065 1.669-.072 2.516.21.518.173.994.68 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.162 3.162 0 0 1-.488.9c.054.153.076.313.076.465 0 .306-.089.626-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.826 4.826 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.616.849-.231 1.574-.786 2.132-1.41.56-.626.914-1.279 1.039-1.638.199-.575.356-1.54.428-2.59z"/>' +
							</svg>${list.goodsHIT}</h5> 
					      </div>
					    </div>
					    </div>
				 	</a>
				 </c:forEach>
				 		
			</div>
	</div>
	<br>
	<br>
	<footer class="blog-footer">
		<h3>TEST</h3>
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
					<div class="modal-content <% if(messageType.equals("오류 메시지")) out.println("panel-warning"); else out.println("panel-success");%>">
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
					getUnRead();
					  $("#allGoodsCATE").click(function(){
					        //클릭되었으면
					        if($("#allGoodsCATE").prop("checked")){
					            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
					            $("input[name=goodsCATE]").prop("checked",true);
					            //클릭이 안되있으면
					        }
					    })
					     $("#goodsCATE1").click(function(){
					            $("input[name=allGoodsCATE]").prop("checked",false);
					    })
					     $("#goodsCATE2").click(function(){
					            $("input[name=allGoodsCATE]").prop("checked",false);
					    })
					     $("#goodsCATE3").click(function(){
					            $("input[name=allGoodsCATE]").prop("checked",false);
					    })
					     $("#goodsCATE4").click(function(){
					            $("input[name=allGoodsCATE]").prop("checked",false);
					    })
					     $("#goodsCATE5").click(function(){
					            $("input[name=allGoodsCATE]").prop("checked",false);
					    })
					     $("#goodsCATE6").click(function(){
					            $("input[name=allGoodsCATE]").prop("checked",false);
					    })
				});
			</script>
		<%
			}
		%>
</body>
</html>