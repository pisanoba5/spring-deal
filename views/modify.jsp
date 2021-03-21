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
		function passwordCheckFunction(){
			var userPassword1 = $('#userPassword1').val();
			var userPassword2 = $('#userPassword2').val();
			if(userPassword1 != userPassword2){
				$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
				document.getElementById('infoSubmit').disabled=true;
			}else{
				$('#passwordCheckMessage').html('');
				document.getElementById('infoSubmit').disabled=false;
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
        function checkFunction(){
			var obj = document.joinForm;
			var userPassword1 = obj.userPassword1.value;
			var userPassword2 = obj.userPassword2.value;
			
			if(obj.userPassword1.value == ''){
				$('#checkMessage').html('비밀번호를 입력해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userPassword1.focus();
				return false;
			}
			if(obj.userPassword2.value == ''){
				$('#checkMessage').html('확인 비밀번호를 입력해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userPassword2.focus();
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
		<form method="post" action="/setModify" enctype="multipart/form-data" name="joinForm" onsubmit="return checkFunction();">
			<table class="table table-bordered table-hover" style="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="4"><h4>회원 등록</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan="5">
							<img id="blah" src="/resources/img/${info.userImg}" class="rounded float-start" alt="..." style="width:150px;height:150px;"><br>
  							<input class="form-control" type="file" id="userImg" name="userImg">
						</td>
						<tr>
							<td style="width: 110px;"><h5>아이디</h5></td>
							<td><input class="form-control" type="text" id="userID" name="userID" maxlength="20" placeholder="아이디" value="${info.userID}" readonly></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>비밀번호</h5></td>
							<td colspan="2"><input id="userPassword1" onkeyup="passwordCheckFunction();" class="form-control" type="password" name="userPassword" maxlength="20" placeholder="비밀번호 "></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>비밀번호 확인</h5></td>
							<td colspan="2"><input id="userPassword2" onkeyup="passwordCheckFunction();" class="form-control" type="password" name="userPassword2" maxlength="20" placeholder="비밀번호 확인"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>이름</h5></td>
							<td colspan="2"><input id="userName" class="form-control" type="text" name="userName" maxlength="20" placeholder="이름" value="${info.userName}" disabled></td>
						</tr>
					</tr>
					<tr>
						<td style="width: 110px;"><h5 style="margin-top: 45px;">주소</h5></td>
						<td colspan="3" style="text-align:center;">
							<div class="col-xs-3" style="text-align:right;">
								<input class="form-control" type="text" id="userPostCode" name="userPostCode" placeholder="우편번호" style="display:inline;" value="${info.userPostCode}" disabled>
								<button class="btn btn-primary" type="button" onclick="sample6_execDaumPostcode()" style="width:70px;background:#006DCC;">우편번호</button>
							</div>
							 <div class="col-xs-6">
								<input class="form-control" type="text" id="userAddress" name="userAddress" placeholder="주소" value="${info.userAddress}" disabled>
								<input class="form-control" type="text" id="userDetailAddress" name="userDetailAddress" placeholder="상세주소" value="${info.userDetailAddress}" disabled>
								<input class="form-control" type="text" id="userExtraAddress" name="userExtraAddress" placeholder="참고항목" value="${info.userExtraAddress}" disabled>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>전화번호</h5></td>
						<td colspan="3">
						<select id="userPhone" name="userPhone1" style="display:inline;" value="${info.userPhone1}" disabled>
							<option value="010">010</option>
							<option value="015">015</option>
							<option value="016">016</option>
							<option value="069">069</option>
							<option value="070">070</option>
							<option value="081">081</option>
							<option value="086">086</option>
							<option value="087">087</option>
							<option value="093">093</option>
							<option value="098">098</option>
							<option value="096">096</option>
						</select>-
						<input id="userPhone" class="form-control" style="width:100px;display:inline;" type="text" name="userPhone2" maxlength="4" placeholder="전화번호" value="${info.userPhone2}" disabled>-
						<input id="userPhone" class="form-control" style="width:100px;display:inline;" type="text" name="userPhone3" maxlength="4" placeholder="전화번호" value="${info.userPhone3}" disabled>
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td colspan="3"><input id="userEmail" class="form-control" type="email" name="userEmail" maxlength="20" placeholder="이메일" value="${info.userEmail}" disabled></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>나이</h5></td>
						<td colspan="3"><input id="userAge" class="form-control" type="text" name="userAge" maxlength="20" placeholder="나이" value="${info.userAge}" disabled></td>
					</tr>
					<tr>
						<td colspan="3">
							<div class="form-group" style="text-align:center; margin: 0 auto;">
								<div class="btn-group" data-toggle="buttons">
									<c:if test="${info.userGender == '남자'}">
										<label class="btn btn-primary active">
											<input type="radio" name="userGender" autocimple="off" value="남자" checked>남자
										</label>
									</c:if>
									<c:if test="${info.userGender == '여자'}">
										<label class="btn btn-primary active">
											<input type="radio" name="userGender" autocimple="off" value="여자" checked>여자
										</label>
									</c:if>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="text-align:left;" colspan="4"><h5 style="color:red;" id="passwordCheckMessage"></h5><input id="infoSubmit" class="btn btn-primary pull-right" type="submit" value="등록"></td>
					</tr>
				</tbody>
			</table>
		</form>
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
		             <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        <input type="submit" class="btn btn-primary" value="확인">
		          </div>
		        </form>
		      </div>
		      <div class="modal-footer">
		       
		      </div>
		    </div>
		  </div>
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
				<div class="modal-dialog vertical-align-conter">
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