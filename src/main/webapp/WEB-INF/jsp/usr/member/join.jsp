<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jsp"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
	function MemberJoinForm__submit(form) {
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
			alert('로그인 아이디를 입력해주세요.');

			return;
		}

		if (form.loginId.value.length < 4) {
			form.loginId.focus();
			alert('로그인 아이디 4자 이상 입력해주세요.');

			return;
		}

		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length == 0) {
			form.loginPw.focus();
			alert('로그인 비밀번호를 입력해주세요.');

			return;
		}

		if (form.loginPw.value.length < 5) {
			form.loginPw.focus();
			alert('로그인 비밀번호를 5자 이상 입력해주세요.');

			return;
		}

		if (form.loginPwConfirm.value.length == 0) {
			form.loginPwConfirm.focus();
			alert('로그인 비밀번호 확인을 입력해주세요.');

			return;
		}

		if (form.loginPw.value != form.loginPwConfirm.value) {
			form.loginPwConfirm.focus();
			alert('로그인 비밀번호 확인이 일치하지 않습니다.');

			return;
		}

		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			form.name.focus();
			alert('이름을 입력해주세요.');

			return;
		}

		form.nickname.value = form.nickname.value.trim();

		if (form.nickname.value.length == 0) {
			form.nickname.focus();
			alert('활동명을 입력해주세요.');

			return;
		}

		//이메일 형식 정규식으로 검사해야함....
		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			form.email.focus();
			alert('이메일을 입력해주세요.');

			return;
		}

		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		form.cellphoneNo.value = form.cellphoneNo.value.replaceAll('-', '');
		form.cellphoneNo.value = form.cellphoneNo.value.replaceAll(' ', '');

		if (form.cellphoneNo.value.length == 0) {
			form.cellphoneNo.focus();
			alert('휴대전화번호를 입력해주세요.');

			return;
		}

		if (form.cellphoneNo.value.length < 10) {
			form.cellphoneNo.focus();
			alert('휴대폰번호를 10자 이상 입력해주세요.');

			return;
		}

		if (isCellphoneNo(form.cellphoneNo.value) == false) {
			form.cellphoneNo.focus();
			alert('휴대전화번호를 정확히 입력해주세요.');

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
<div class="m-auto p-4" style="max-width: 600px">
	<span class="font-bold text-xl">회원가입</span>
</div>
<form method="POST" class="bg-gray-200 p-4 w-full h-full"
	action="doJoin"
	onsubmit="javascript:MemberJoinForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/">
	<input type="hidden" name="loginPwReal">
	<input type="hidden" name="fileIdsStr">
	<div class="m-auto" style="max-width: 600px">
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="text" placeholder="로그인 아이디" name="loginId" maxlength="30" />
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
					<input type="radio" name="gender" value="woman">
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
		<!-- 권한 분리 없애야함... -->
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
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="email" placeholder="이메일" name="email" maxlength="50" />
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
	
	$('#join-file').on('change', function() {

		var memberFileStatus = $('.member-file-status');
		
		const files = $("#join-file")[0].files;
		const file = $("#join-file")[0].files[0];

		if (files.length != 0) {
			const imgurl = URL.createObjectURL(file);
			$('#join-profile').attr("src", imgurl);
			$('#join-profile-box').css("padding", "0 0 10px");
			
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
	
</script>
<%@ include file="../part/foot.jsp"%>