<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jsp"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	function MemberFindLoginIdForm__submit(form) {
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		form.name.value = form.name.value.trim();
		form.name.value = form.name.value.replaceAll('-', '');
		form.name.value = form.name.value.replaceAll('_', '');
		form.name.value = form.name.value.replaceAll(' ', '');

		if (form.name.value.length == 0) {
			form.name.focus();
			alert('이름을 입력해주세요.');

			return;
		}

		form.email.value = form.email.value.trim();
		form.email.value = form.email.value.replaceAll(' ', '');

		if (form.email.value.length == 0) {
			form.email.focus();
			alert('이메일을 입력해주세요.');

			return;
		}

		$('.loader').show();
		$('.loader-img').show();
		$('.loader-background').show();
		form.submit();
		startLoading();
	}
	
	
</script>
<div class="m-auto p-4" style="max-width: 400px">
	<span class="font-bold text-xl">아이디 찾기</span>
</div>
<form method="POST" class="bg-gray-200 p-4 w-full h-full"
	action="doFindLoginId"
	onsubmit="MemberFindLoginIdForm__submit(this); return false;">
	<div class="m-auto" style="max-width: 400px">
		<div class="pb-4 flex flex-col flex-grow">
			<div class="bg-gray-500 text-white font-bold py-2 rounded-full px-4">이름(실명)</div>
			<input type="text" placeholder="이름을 입력해주세요. 입력해주세요." name="name"
				class="shadow appearance-none border rounded-full flex-grow py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline flex-grow"
				maxlength="30" autofocus="autofocus" />
		</div>
		<div class="pb-4 flex flex-col flex-grow">
			<div class="bg-gray-500 text-white font-bold py-2 rounded-full px-4">이메일주소</div>
			<input type="email" placeholder="이메일을 입력해주세요." name="email"
				class="shadow appearance-none border rounded-full flex-grow py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline flex-grow"
				maxlength="50" />
		</div>
		<div class="pb-4 flex flex-grow">
			<button
				class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
				type="submit">찾기</button>
			<button
				class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
				onclick="history.back();" type="button">취소</button>
		</div>
	</div>
</form>
<script>
	function MemberFindLoginPwForm__submit(form) {
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

		form.email.value = form.email.value.trim();
		form.email.value = form.email.value.replaceAll(' ', '');

		if (form.email.value.length == 0) {
			form.email.focus();
			alert('이메일을 입력해주세요.');

			return;
		}

		$('.loader').show();
		$('.loader-img').show();
		$('.loader-background').show();
		form.submit();
		startLoading();
	}
</script>
<div class="m-auto p-4" style="max-width: 400px">
	<span class="font-bold text-xl">비밀번호 찾기</span>
</div>
<form method="POST" class="bg-gray-200 p-4 w-full h-full"
	action="doFindLoginPw"
	onsubmit="MemberFindLoginPwForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/usr/member/login">
	<div class="m-auto" style="max-width: 400px">
		<div class="pb-4 flex flex-col flex-grow">
			<div class="bg-gray-500 text-white font-bold py-2 rounded-full px-4">로그인
				아이디</div>
			<input type="text" placeholder="로그인 아이디 입력해주세요." name="loginId"
				class="shadow appearance-none border rounded-full flex-grow py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline flex-grow"
				maxlength="30" autofocus="autofocus" />
		</div>
		<div class="pb-4 flex flex-col flex-grow">
			<div class="bg-gray-500 text-white font-bold py-2 rounded-full px-4">이메일주소</div>
			<input type="email" placeholder="이메일을 입력해주세요." name="email"
				class="shadow appearance-none border rounded-full flex-grow py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline flex-grow"
				maxlength="50" />
		</div>
		<div class="pb-4 flex flex-grow">
			<button
				class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
				type="submit">찾기</button>
			<button
				class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
				onclick="history.back();" type="button">취소</button>
		</div>
	</div>
</form>
<%@ include file="../part/foot.jsp"%>