<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/head.jsp"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	function MemberCheckPasswordForm__submit(form) {
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length == 0) {
			form.loginPw.focus();
			
			var msg = "로그인 비밀번호를 입력해주세요.";
			var targetName = "loginPw";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		if (form.loginPw.value.length < 5) {
			form.loginPw.focus();
			
			var msg = "로그인 비밀번호를 5자 이상 입력해주세요.";
			var targetName = "loginPw";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';

		form.submit();
	}
</script>
<div class="m-auto p-4" style="max-width: 400px">
	<span class="font-bold text-xl">비밀번호 확인</span>
</div>
<form method="POST" class="bg-gray-200 p-4 w-full h-full"
	action="doCheckPassword"
	onsubmit="MemberCheckPasswordForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="${param.redirectUri}">
	<input type="hidden" name="loginPwReal">

	<div class="m-auto" style="max-width: 400px">
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input id="loginId"
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="password" placeholder="로그인 비밀번호를 입력해주세요." name="loginPw"
					maxlength="30" />
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow flex">
				<input
					class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
					type="submit" value="비밀번호 확인">
				<button
					class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
					type="button" onclick="history.back();">취소</button>
			</div>
		</div>
	</div>
</form>

<%@ include file="../part/foot.jsp"%>