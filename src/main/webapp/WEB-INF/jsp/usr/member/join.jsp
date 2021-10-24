<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jsp"%>

<!-- iamport.payment.js -->
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
	function MemberJoinForm__submit(form) {
		if ($('.toast')) {
			window.toastr.remove();
		}

		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		form.loginId.value = form.loginId.value.trim();
		form.loginId.value = form.loginId.value.replaceAll('-', '');
		form.loginId.value = form.loginId.value.replaceAll('_', '');
		form.loginId.value = form.loginId.value.replaceAll(' ', '');

		if (form.loginId.value.length == 0) {
			form.loginId.focus();

			var msg = "로그인 아이디를 입력해주세요.";
			var targetName = "loginId";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		if (form.loginId.value.length < 4) {
			form.loginId.focus();

			var msg = "로그인 아이디 4자 이상 입력해주세요.";
			var targetName = "loginId";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length == 0) {
			var targetOffset = $('input[name="loginPw"]').offset();
			window.scrollTo({
				top : targetOffset.top - 500,
				behavior : 'auto'
			});

			form.loginPw.focus();

			var msg = "로그인 비밀번호를 입력해주세요.";
			var targetName = "loginPw";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		if (form.loginPw.value.length < 5) {
			var targetOffset = $('input[name="loginPw"]').offset();
			window.scrollTo({
				top : targetOffset.top - 500,
				behavior : 'auto'
			});

			form.loginPw.focus();

			var msg = "로그인 비밀번호를 5자 이상 입력해주세요.";
			var targetName = "loginPw";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		if (form.loginPwConfirm.value.length == 0) {
			var targetOffset = $('input[name="loginPwConfirm"]').offset();
			window.scrollTo({
				top : targetOffset.top - 500,
				behavior : 'auto'
			});

			form.loginPwConfirm.focus();

			var msg = "로그인 비밀번호 확인을 입력해주세요.";
			var targetName = "loginPwConfirm";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		if (form.loginPw.value != form.loginPwConfirm.value) {
			var targetOffset = $('input[name="loginPwConfirm"]').offset();
			window.scrollTo({
				top : targetOffset.top - 500,
				behavior : 'auto'
			});

			form.loginPwConfirm.focus();

			var msg = "로그인 비밀번호 확인이 일치하지 않습니다.";
			var targetName = "loginPwConfirm";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			form.name.focus();

			var msg = "이름을 입력해주세요.";
			var targetName = "name";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		form.age.value = form.age.value.trim();

		if (form.age.value.length == 0) {
			form.age.focus();

			var msg = "나이를 입력해주세요.";
			var targetName = "age";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		form.nickname.value = form.nickname.value.trim();

		if (form.nickname.value.length == 0) {
			form.nickname.focus();

			var msg = "활동명을 입력해주세요.";
			var targetName = "nickname";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		//이메일 형식 정규식으로 검사해야함....
		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			form.email.focus();

			var msg = "이메일을 입력해주세요.";
			var targetName = "email";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);
			return;

		} else if (form.email.value.length != 0
				&& $('#email').data("authentication") == "-1") {
			form.email.focus();

			var msg = "'이메일 인증을 완료해주세요.";
			var targetName = "email";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);
			return;
		}

		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		form.cellphoneNo.value = form.cellphoneNo.value.replaceAll('-', '');
		form.cellphoneNo.value = form.cellphoneNo.value.replaceAll(' ', '');

		if (form.cellphoneNo.value.length == 0) {
			form.cellphoneNo.focus();

			var msg = "휴대전화번호를 입력해주세요.";
			var targetName = "cellphoneNo";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		if (form.cellphoneNo.value.length < 10) {
			form.cellphoneNo.focus();

			var msg = "휴대폰번호를 10자 이상 입력해주세요.";
			var targetName = "cellphoneNo";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		if (isCellphoneNo(form.cellphoneNo.value) == false) {
			form.cellphoneNo.focus();

			var msg = "휴대전화번호를 정확히 입력해주세요.";
			var targetName = "cellphoneNo";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);

		var startUploadFiles = function(onSuccess) {
			var needToUpload = false;

			if (needToUpload == false
					&& form.file__member__0__common__attachment__1) {
				needToUpload = form.file__member__0__common__attachment__1
						&& form.file__member__0__common__attachment__1.value.length > 0;
			}

			if (needToUpload == false) {
				onSuccess();
				return;
			}

			var fileUploadFormData = new FormData(form);

			$.ajax({
				url : './../file/doUploadAjax',
				data : fileUploadFormData,
				processData : false,
				contentType : false,
				dataType : "json",
				type : 'POST',
				success : onSuccess
			});
		}

		var startWriteApplyment = function(fileIdsStr) {

			form.fileIdsStr.value = fileIdsStr;

			form.submit();
		};

		startUploadFiles(function(data) {

			var idsStr = '';
			if (data && data.body && data.body.fileIdsStr) {
				idsStr = data.body.fileIdsStr;
			}

			startWriteApplyment(idsStr);
		});

	}
</script>
<div class="m-auto p-4" style="max-width: 400px">
	<span class="font-bold text-xl">회원가입</span>
</div>
<form method="POST" class="bg-gray-200 p-4 w-full h-full"
	action="doJoin"
	onsubmit="javascript:MemberJoinForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/">
	<input type="hidden" name="loginPwReal">
	<input type="hidden" name="fileIdsStr">
	<div class="m-auto" style="max-width: 400px">
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input id="loginId"
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="text" placeholder="로그인 아이디" name="loginId" maxlength="30" />
				<div id="loginId-duple-result"></div>
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="password" placeholder="로그인 비밀번호" name="loginPw"
					maxlength="30" />
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="password" placeholder="로그인 비밀번호확인" name="loginPwConfirm"
					maxlength="30" />
			</div>
		</div>

		<div class="flex justify-center">
			<label class="flex-grow">
				<input id="join-file" type="file"
					class="text-sm cursor-pointer hidden "
					accept="${appConfig.getAttachemntFileInputAccept('img')}"
					name="file__member__0__common__attachment__1" />
				<div
					class="member-file-status mb-4 w-full text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600">
					프로필 사진을 선택해주세요</div>
			</label>
		</div>
		<div id="join-profile-box" class="flex justify-center">
			<img id="join-profile" class="max-w-xs" src="" alt="" />
		</div>


		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="text" placeholder="이름" name="name" maxlength="20" />
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="number" placeholder="나이" name="age" maxlength="20" />
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<label>
					<input type="radio" name="gender" value="woman" checked>
					여성
				</label>
				<label>
					<input type="radio" name="gender" value="man">
					남성
				</label>
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="text" placeholder="활동명" name="nickname" maxlength="20" />
			</div>
		</div>
		<div>
			<div class="form-control-box mb-4 flex-grow relative">
				<select name="authority"
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
					<option value="1">캐스팅디렉터</option>
					<option value="2">배우</option>
				</select>
				<div
					class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
					<i class="fas fa-chevron-down"></i>
				</div>
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex flex-col flex-grow">
				<div class="flex flex-grow rounded-full shadow appearance-none">
					<input id="email" data-authentication="-1"
						class="leading-tight appearance-none rounded-full flex-grow py-2 pl-2 text-gray-700 border-t border-l border-b focus:outline-none focus:shadow-outline"
						type="email" placeholder="이메일" name="email" maxlength="50" />
					<button type="button" id="email-button"
						class="hidden bg-gray-500 appearance-none rounded-r-full px-4 text-white hover:bg-gray-700 border-t border-r border border-b border-gray-500"
						onclick="sendEmailAuthenticationVal()">인증번호발송</button>
				</div>
				<div id="email-duple-result"></div>
				<div id="email-verify-box" class="hidden flex-grow pt-4">
					<div class="flex flex-grow relative">
						<input type="text" id="email-verify"
							class="shadow appearance-none border rounded-l-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" />
						<div id="authentication-timer" class="absolute top-2/4 right-0 transform -translate-x-1/2 -translate-y-1/2 text-opacity-60 text-gray-600"></div>
					</div>
					<button type="button" id="email-verify-button"
						class="whitespace-nowrap bg-gray-500 appearance-none rounded-r-full px-4 text-white hover:bg-gray-700 border-t border-r border border-b border-gray-500"
						onclick="verifyAuthenticationCode()">인증확인</button>

				</div>
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="tel" placeholder="휴대전화번호" name="cellphoneNo" maxlength="12" />
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow flex">
				<input
					class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
					type="submit" value="가입">
				<button
					class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
					type="button" onclick="history.back();">취소</button>
			</div>
		</div>
	</div>
</form>

<script>
	//프로필사진 업로드 유무 화면에 표시해줌
	$('#join-file').on('change', function() {

		var memberFileStatus = $('.member-file-status');

		const files = $("#join-file")[0].files;
		const file = $("#join-file")[0].files[0];

		if (files.length != 0) {
			const imgurl = URL.createObjectURL(file);
			$('#join-profile').attr("src", imgurl);
			$('#join-profile-box').css("padding", "0 0 10px");

			//파일의 이름을 '프로필사진을 선택해주세요' 대신에 보여준다.
			var fileName = file.name;
			memberFileStatus.html("파일이름 : " + fileName);

			URL.revokeObjectURL(file);

		} else {
			//파일이 없는 경우 내용을 지워준다.
			$('#join-profile').attr("src", "");
			$('#join-profile-box').css("padding", "0");

			memberFileStatus.html("프로필 사진을 선택해주세요");
		}
	});

	//로그인 아이디 실시간 체크
	$('#loginId').on(
			"propertychange change keyup paste",
			function() {

				let loginId = $('#loginId').val();

				if (loginId.length == 0) {
					$('#loginId-duple-result').empty();
				} else {
					$.ajax({
						url : '../../usr/member/loginIdDupleAjax',
						data : {
							loginId : loginId
						},
						dataType : "json",
						type : 'GET',
						success : function(data) {
							if (data && data.msg) {
								if (data.fail == false) {
									$('#loginId-duple-result').html(
											'<div class="text-green-500 pt-4">'
													+ data.msg + '</span>');
								} else {
									$('#loginId-duple-result').html(
											'<div class="text-red-500 pt-4">'
													+ data.msg + '</span>');
								}
							}
						}
					});
				}

			});

	//이메일 실시간 체크
	$('#email').on("propertychange change keyup paste",
					function() {

						//이메일 체크 정규식
						//(21-10-24) 이메일에 . / - /_ 허용
						var regExp = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i;

						//이메일 인증박스 안보이게함
						$('#email-verify-box').css("display", "none");
						
						//타이머를 없애줌
						$('#authentication-timer').html("");
						
						//이메일 인풋에 인증안되어있음으로 변경 
						$("#email").data("authentication", "-1");

						//이메일 값 가져오기
						let email = $('#email').val();
						
						//타이머 삭제 및 타임 초기화
						clearInterval(timer);
						time = 299

						if (email.length == 0) {
							$('#email-duple-result').empty();
							$('#email').css("border-radius", "9999px");
							$('#email-button').css("display", "none");

						} else if (email.length != 0
								&& regExp.test(email) == false) {

							$('#email-duple-result').empty();
							$('#email').css("border-radius", "9999px");
							$('#email-button').css("display", "none");

						} else if (email.length != 0 && regExp.test(email)) {
							$
									.ajax({
										url : '../../usr/member/emailDupleAjax',
										data : {
											email : email
										},
										dataType : "json",
										type : 'GET',
										success : function(data) {
											if (data && data.msg) {
												if (data.fail == false) {
													$('#email-duple-result')
															.html(
																	'<div class="text-green-500 pt-4">'
																			+ data.msg
																			+ '</span>');
													$('#email')
															.css(
																	{
																		"border-top-right-radius" : "0px",
																		"border-bottom-right-radius" : "0px"
																	});
													$('#email-button').css(
															"display", "block");
												} else {
													$('#email-duple-result')
															.html(
																	'<div class="text-red-500 pt-4">'
																			+ data.msg
																			+ '</span>');
													$('#email').css(
															"border-radius",
															"9999px");
													$('#email-button').css(
															"display", "none");
												}
											}
										}
									});
						}
					});
	
	//이메일 인증번호 전송함수
	function sendEmailAuthenticationVal() {
		
		if ($('.toast')) {
			window.toastr.remove();
		}
		
		let email = $('#email').val();
		
		if(typeof timer == "undefined"){
			$('#email-duple-result').empty();

			$.ajax({
				url : '../../usr/member/sendCodeAjax',
				data : {
					email : email
				},
				dataType : "json",
				type : 'GET',
				success : function(data) {
					if (data && data.msg) {
						if (data.fail == false) {
							
							var msg = data.msg;
							var targetName = "email";
							var targetType = "id";
							var toastr = setPositionOfToastr(targetType,
									targetName, msg);

							$('#email-verify-box').css("display", "flex");
							
							startAuthentiactionTimer();

						} else {
							var msg = data.msg;
							var targetName = "email";
							var targetType = "id";
							var toastr = setPositionOfToastr(targetType,
									targetName, msg);

						}
					}
				}
			});
			
		} else{
			if(time == 299){
				$('#email-duple-result').empty();
				
				$.ajax({
					url : '../../usr/member/sendCodeAjax',
					data : {
						email : email
					},
					dataType : "json",
					type : 'GET',
					success : function(data) {
						if (data && data.msg) {
							if (data.fail == false) {
								
								var msg = data.msg;
								var targetName = "email";
								var targetType = "id";
								var toastr = setPositionOfToastr(targetType,
										targetName, msg);

								$('#email-verify-box').css("display", "flex");
								
								time = 299;
								startAuthentiactionTimer();
								
								html = '';
								html += '<span>인증확인</span>';

								$("#email-verify-button").html(html);

							} else {
								var msg = data.msg;
								var targetName = "email";
								var targetType = "id";
								var toastr = setPositionOfToastr(targetType,
										targetName, msg);

							}
						}
					}
				});
				
			}else{
				var msg = "인증번호 재발송까지 " + min + "분 " + sec + "초 남았습니다.";
				var targetName = "email";
				var targetType = "id";
				var toastr = setPositionOfToastr(targetType,
						targetName, msg);
			}
		}

	}
	
	//타이머(setInterval)를 담을 함수 -> 나중에 clearInterval(timer)를 통해서 타이머를 없앨수있음
	var timer;
	
	//타이머 시간설정
	var time = 299;
	var min = "";
	var sec = "";
	
	//인증시간 타이머 함수
	function startAuthentiactionTimer() {
		clearInterval(timer);
		
		timer = setInterval(function(){
			
			min = parseInt(time/60);
			sec = time%60;
			
			if(min != 0 ){
				$('#authentication-timer').html('<span>'+ min + "분 " + sec + "초" +'</span>');	
			}else{
				$('#authentication-timer').html('<span>' + sec + "초" +'</span>');
			}
			
			if(time == 0){
				clearInterval(timer);
				$('#authentication-timer').html('<span>인증실패</span>');
			}else{
				time--;
			}
			
		}, 1000);
		
	}

	//인증번호 일치하는지 확인하는 함수
	function verifyAuthenticationCode() {
		if ($('.toast')) {
			window.toastr.remove();
		}

		let email = $('#email').val();
		let emailAuthenCode = $('#email-verify').val();

		if (emailAuthenCode.length == 0) {
			var msg = "인증번호를 입력해주세요.";
			var targetName = "email-verify";
			var targetType = "id";
			var toastr = setPositionOfToastr(targetType, targetName, msg);
			return;

		} else {

			$.ajax({
				url : '../../usr/member/verifyCheck',
				data : {
					email : email,
					code : emailAuthenCode
				},
				dataType : "json",
				type : 'GET',
				success : function(data) {
					if (data && data.msg) {
						if (data.fail == false) {

							var msg = "인증번호가 일치합니다.";
							var targetName = "email-verify";
							var targetType = "id";
							var toastr = setPositionOfToastr(targetType,
									targetName, msg);

							html = '';
							html += '<span>인증완료</span>';
							html += '<i class="fas fa-check"></i>';

							$("#email-verify-button").html(html);
							$("#email").data("authentication", "1");
							clearInterval(timer);
							$('#authentication-timer').empty();

						} else {

							var msg = "인증번호가 잘못입력되었습니다.";
							var targetName = "email-verify";
							var targetType = "id";
							var toastr = setPositionOfToastr(targetType,
									targetName, msg);

						}
					}
				}
			});
		}

	}
</script>
<%@ include file="../part/foot.jsp"%>