<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}else{
			response.sendRedirect("/login");
		}
		String img = null;
		if(session.getAttribute("userImg") != null){
			img = (String) session.getAttribute("userImg");
		}
		int goodsID = 0;
		if(request.getAttribute("goodsID") != null){
			goodsID = Integer.parseInt(request.getParameter("goodsID"));
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
		var click=0;
		function insRow() {
			  click += 1;
			  if(click < 3){
				  oTbl = document.getElementById("addTable");
				  var oRow = oTbl.insertRow(); //tr 생성
				  oRow.onmouseover=function(){oTbl.clickedRowIndex=this.rowIndex}; //clickedRowIndex - 클릭한 Row의 위치를 확인;
				  var oCell = oRow.insertCell();//td 생성
				  var frmTag = "<tr>";
				  frmTag +="<td><h5>이미지</h5></td>";
				  frmTag += "<td><input class='form-control' type='file' id='goodsIMG' name='goodsIMG'></td>";
				  frmTag += "<td><input class='btn btn-danger' type=button value='삭제' onClick='removeRow()' style='cursor:hand'></td>";
				  frmTag +=  "</tr>";
				  oRow.innerHTML = frmTag;
				  return;
			  }else{
				  alert("더 이상 이미지를 추가 할 수 없습니다.")
				  return;
			  }
			  //삽입될 Form Tag
			}
		function removeRow() {
			  click -= click
			  oTbl.deleteRow(oTbl.clickedRowIndex);
			}
		/* function frmCheck()
		{
		  var frm = document.form;
		  
		  for( var i = 0; i <= frm.elements.length - 1; i++ ){
		     if( frm.elements[i].name == "addText" )
		     {
		         if( !frm.elements[i].value ){
		             alert("텍스트박스에 값을 입력하세요!");
		                 frm.elements[i].focus();
			 return;
		          }
		      }
		   }
		 } */
			function frmCheck(){
				var check_num = /[0-9]/;//숫자
				var check_eng = /[a-zA-Z]/; // 문자 
				var check_spc = /[~!@#$%^&*()_+|<>?:{}]/;//특수문자 
				var check_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글체크
				
				var city1 = $('#city1').val();
				var city2 = $('#city2').val();
				var goodsNAME = $('#goodsNAME').val();
				var goodsPRICE = $('#goodsPRICE').val();
				var goodsCONTENT = $('#goodsCONTENT').val();
				var goodsCATE = $('#goodsCATE').val();

				if(city1 == ''|| city2 == '' || city1 == null || city2 == null){
					$('#checkMessage').html('지역을 입력해주세요.');
					$('#checkType').attr('class', 'modal-content panel-warning');
					$('#checkModal').modal("show");
					return false;
				}
				if(goodsNAME == ''){
					$('#checkMessage').html('제품이름을 입력해주세요.');
					$('#checkType').attr('class', 'modal-content panel-warning');
					$('#checkModal').modal("show");
					return false;
				}
				if(goodsPRICE == ''){
					$('#checkMessage').html('가격을 입력해주세요.');
					$('#checkType').attr('class', 'modal-content panel-warning');
					$('#checkModal').modal("show");
					return false;
				}
				if(!check_num.test(goodsPRICE)){
					$('#checkMessage').html('숫자만 입력해주세요.');
					$('#checkType').attr('class', 'modal-content panel-warning');
					$('#checkModal').modal("show");
					return false;
				}
				if(goodsCONTENT == ''){
					$('#checkMessage').html('내용을 입력해주세요.');
					$('#checkType').attr('class', 'modal-content panel-warning');
					$('#checkModal').modal("show");
					obj.userPostCode.focus();
					return false;
				}
				if(goodsCATE == ''){
					$('#checkMessage').html('카테고리를 선택해주세요.');
					$('#checkType').attr('class', 'modal-content panel-warning');
					$('#checkModal').modal("show");
					return false;
				}
			}
		$(function() {
            $("#goodsIMG").on('change', function(){
                readURL(this);
            });
        });

        function readURL(input) {
            if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                    $('#blah').attr('src', e.target.result);
                }

              reader.readAsDataURL(input.files[0]);
            }
        }
        $(function() {
            $("#userImg").on('change', function(){
                readURL(this);
            });
        });

        function readURL(input) {
            if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                    $('#blah').attr('src', e.target.result);
                }

              reader.readAsDataURL(input.files[0]);
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
		<form id="modifyForm" name="modifyForm" method="post" action="/modifyGoods" enctype="multipart/form-data" onsubmit="return frmCheck();">
			<table id="addTable" class="table table-bordered table-hover" style="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>상품 수정</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="3">
							<img id="blah" src="/resources/img/${info.goodsIMG1}" style="width:200px; height:200px;"/>
							<input type="hidden" id="goodsID" name="goodsID" value="${info.goodsID}">
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>지역</h5></td>
						<td>
							<select id="city1" name="city1" onclick="getCity();" class="form-select" aria-label=".form-select-sm example">
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
						<td style="width: 110px;"><h5>상품이름</h5></td>
						<td colspan="2"><input id="goodsNAME" class="form-control" type="text" name="goodsNAME" maxlength="20" value=""></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>가격</h5></td>
						<td colspan="2"><input id="goodsPRICE" class="form-control" type="text" name="goodsPRICE" maxlength="15" value=""></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>내용</h5></td>
						<td colspan="2"><input id="goodsCONTENT" class="form-control" type="text" name="goodsCONTENT" maxlength="20" value=""></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>구분</h5></td>
						<td colspan="2">
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="goodsCATE" id="goodsCATE" value="가전제품">
							  <label class="form-check-label" for="가전제품">가전제품</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  <input class="form-check-input" type="radio" name="goodsCATE" id="goodsCATE" value="가구">
							  <label class="form-check-label" for="가구">가구</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  <input class="form-check-input" type="radio" name="goodsCATE" id="goodsCATE" value="운동기구">
							  <label class="form-check-label" for="운동기구">운동기구</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  <input class="form-check-input" type="radio" name="goodsCATE" id="goodsCATE" value="책">
							  <label class="form-check-label" for="책">책</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  <input class="form-check-input" type="radio" name="goodsCATE" id="goodsCATE" value="문구">
							  <label class="form-check-label" for="문구">문구</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  <input class="form-check-input" type="radio" name="goodsCATE" id="goodsCATE" value="잡화">
							  <label class="form-check-label" for="잡화">잡화</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td><h5>이미지</h5></td>
						<td><input class="form-control" type="file" id="goodsIMG" name="goodsIMG"></td>
						<td><input class="btn btn-primary" name="addButton" type="button" style="cursor:hand" onClick="insRow()" value="추가"></td>
					</tr>
				</tbody>
			</table>
			<input class="btn btn-primary pull-right" type="submit" value="수정">
		</form>
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
		</script>
		<%
			session.removeAttribute("messageContent");
			session.removeAttribute("messageType");
			}
		%>
		<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog vertical-align-center">
					<div id="checkType" class="modal-content panel-info">
						<div class="modal-header panel-heading">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times</span>
								<span class="sr-only">close</span>
							</button>
							<h4 class="modal-title">
								확인 메시지
							</h4>
						</div>
						<div id="checkMessage" class="modal-body">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
</body>
</html>