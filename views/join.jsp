<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="/resources/css/bootstrap.css">
	<link rel="stylesheet" href="/resources/css/custom.css">
	<title>파란마켓</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="/resources/js/bootstrap.js"></script>
	<script type="text/javascript">
		function registerCheckFunction(){
			var check_num = /[0-9]/;//숫자
			var check_eng = /[a-zA-Z]/; // 문자 
			var check_spc = /[~!@#$%^&*()_+|<>?:{}]/;//특수문자 
			var check_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글체크
			var obj = document.joinForm;
			var userID = $('#userID').val();
			if(userID == ''){
				$('#checkMessage').html('아이디를 입력해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userID.focus();
				return false;
			}else if(check_spc.test(userID) || check_kor.test(userID)){
				$('#checkMessage').html('한글과 특수문자는 안됩니다.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userID.focus();
				return false;
			}else if(userID.length < 3 || userID.length > 9){
				$('#checkMessage').html('아이디는 4글자 이상 8글자 이하로 입력해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userID.focus();
				return false;
			}
			$.ajax({
				type:'post',
				url:'/userRegisterCheck',
				data:{userID : userID},
				success: function(result){
					if(result == 1){
						$('#checkMessage').html('사용할 수 있는 아이디입니다.');
						$('#checkType').attr('class', 'modal-content panel-success');
						document.getElementById('infoSubmit').disabled=false;
						$('#userID').attr('readonly',true);
						$('#passwordCheckMessage').html('');
					}else{
						$('#checkMessage').html('중복되는 아이디입니다.');
						$('#checkType').attr('class', 'modal-content panel-warning');
						document.getElementById('infoSubmit').disabled=true;
					}
					$('#checkModal').modal("show");
				}
			});
		}
		
		function checkFunction(){
			var check_num = /[0-9]/;//숫자
			var check_eng = /[a-zA-Z]/; // 문자 
			var check_spc = /[~!@#$%^&*()_+|<>?:{}]/;//특수문자 
			var check_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글체크

			var obj = document.joinForm;
			var userPassword1 = obj.userPassword1.value;
			var userPassword2 = obj.userPassword2.value;
			
			if(userPassword1.length < 5 || userPassword1.length > 13){
				$('#checkMessage').html('비밀번호는 6자 이상 12자 이하로 입력해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userID.focus();
				return false;
			}
			
			if(obj.userID.value == ''){
				$('#checkMessage').html('아이디를 입력해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userID.focus();
				return false;
			}
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
			if(userPassword1 != userPassword2){
				$('#checkMessage').html('비밀번호가 서로 일치하지 않습니다.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				return false;
			}
			if(obj.userPostCode.value == ''){
				$('#checkMessage').html('우편 번호를 입력해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userPostCode.focus();
				return false;
			}
			if(obj.userAddress.value == ''){
				$('#checkMessage').html('주소를 입력해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userAddress.focus();
				return false;
			}
			if(obj.userEmail.value == ''){
				$('#checkMessage').html('이메일을 입력해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userEmail.focus();
				return false;
			}
			if(obj.userPhone1.value == ''){
				$('#checkMessage').html('전화번호를 입력해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userPhone1.focus();
				return false;
			}
			if(obj.userPhone2.value == ''){
				$('#checkMessage').html('전화번호를 입력해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userPhone2.focus();
				return false;
			}
			if(obj.userPhone3.value == ''){
				$('#checkMessage').html('전화번호를 입력해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userPhone3.focus();
				return false;
			}
			if(obj.userAge.value == ''){
				$('#checkMessage').html('나이를 입력해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userAge.focus();
				return false;
			}
			if(obj.userGender.value == ''){
				$('#checkMessage').html('성별을 선택해주세요.');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkModal').modal("show");
				obj.userGender.focus();
				return false;
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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("userExtraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("userExtraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('userPostCode').value = data.zonecode;
	                document.getElementById("userAddress").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("userDetailAddress").focus();
	            }
	        }).open();
	    }
</script>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null){
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messsageContent", "현재 로그인이 되어있는 상태입니다.");
			response.sendRedirect("/index");
			return;
		}
	%>
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
						<li><a href="/logoutAction">회원수정</a></li>
						<li><a href="/logoutAction">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<form method="post" action="/userRegister" enctype="multipart/form-data" name="joinForm" onsubmit="return checkFunction();">
			<table class="table table-bordered table-hover" style="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="4"><h4>회원 등록</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan="5">
							<img id="blah" src="/resources/img/default.jpg" class="rounded float-start" alt="..." style="width:150px;height:150px;"><br>
  							<input class="form-control" type="file" id="userImg" name="userImg">
						</td>
						<tr>
							<td style="width: 110px;"><h5>아이디</h5></td>
							<td><input class="form-control" type="text" id="userID" name="userID" maxlength="20" placeholder="아이디"></td>
							<td style="width: 110px;"><button class="btn btn-primary" onclick="registerCheckFunction();" type="button">중복체크</button></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>비밀번호</h5></td>
							<td colspan="2"><input  id="userPassword1" class="form-control" type="password" name="userPassword" maxlength="20" placeholder="비밀번호 "></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>비밀번호 확인</h5></td>
							<td colspan="2"><input id="userPassword2" class="form-control" type="password" name="userPassword2" maxlength="20" placeholder="비밀번호 확인"></td>
						</tr>
						<tr>
							<td style="width: 110px;"><h5>이름</h5></td>
							<td colspan="2"><input id="userName" class="form-control" type="text" name="userName" maxlength="20" placeholder="이름"></td>
						</tr>
					</tr>
					<tr>
						<td style="width: 110px;"><h5 style="margin-top: 45px;">주소</h5></td>
						<td colspan="3" style="text-align:center;">
							<div class="col-xs-3" style="text-align:right;">
								<input class="form-control" type="text" id="userPostCode" name="userPostCode" placeholder="우편번호" style="display:inline;">
								<button class="btn btn-primary" type="button" onclick="sample6_execDaumPostcode()" style="width:70px;background:#006DCC;">우편번호</button>
							</div>
							 <div class="col-xs-6">
								<input class="form-control" type="text" id="userAddress" name="userAddress" placeholder="주소">
								<input class="form-control" type="text" id="userDetailAddress" name="userDetailAddress" placeholder="상세주소">
								<input class="form-control" type="text" id="userExtraAddress" name="userExtraAddress" placeholder="참고항목">
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>전화번호</h5></td>
						<td colspan="3">
						<select id="userPhone" name="userPhone1" style="display:inline;">
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
						<input id="userPhone" class="form-control" style="width:100px;display:inline;" type="text" name="userPhone2" maxlength="4" placeholder="전화번호">-
						<input id="userPhone" class="form-control" style="width:100px;display:inline;" type="text" name="userPhone3" maxlength="4" placeholder="전화번호">
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td colspan="3"><input id="userEmail" class="form-control" type="email" name="userEmail" maxlength="20" placeholder="이메일"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>나이</h5></td>
						<td colspan="3"><input id="userAge" class="form-control" type="text" name="userAge" maxlength="20" placeholder="나이" ></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>성별</h5></td>
						<td colspan="3">
							<div class="form-group" style="text-align:center; margin: 0 auto;">
								<div class="btn-group" data-toggle="buttons">
										<label class="btn btn-primary">
											<input type="radio" name="userGender" autocimple="off" value="남자">남자
										</label>
										<label class="btn btn-primary">
											<input type="radio" name="userGender" autocimple="off" value="여자">여자
										</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="text-align:left;" colspan="4"><h5 style="color:red;" id="passwordCheckMessage">아이디 중복체크 확인을 해주세요!!!</h5><input id="infoSubmit" class="btn btn-primary pull-right" type="submit" value="등록" disabled></td>
					</tr>
				</tbody>
			</table>
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
		<script type="text/javascript">
		</script>
</body>
</html>