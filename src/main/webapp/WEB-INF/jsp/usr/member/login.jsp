<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	function MemberLoginForm__submit(form) {
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

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';

		form.submit();
		startLoading();
	}
</script>
<form method="POST" class="table-box-vertical con form1 pt-20"
	action="doLogin"
	onsubmit="javascript:MemberLoginForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="${param.redirectUri}">
	<input type="hidden" name="loginPwReal">
	<div class="flex justify-center pb-12">
		<img src="/resource/img/logoForLogin.svg" alt="" />
	</div>
	<div class="form-control-box px-8 pb-4">
		<input type="text"
			class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
			placeholder="아이디" name="loginId" maxlength="30"
			autofocus="autofocus" />
	</div>
	<div class="form-control-box px-8 pb-4">
		<input type="password"
			class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
			placeholder="패스워드" name="loginPw" maxlength="30" />
	</div>
	<div class="px-8">
		<button
			class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full"
			type="submit">로그인</button>
	</div>
	<!--  
	<button class="btn btn-info" onclick="history.back();" type="button">취소</button>
	-->
</form>

<%@ include file="../part/foot.jspf"%>