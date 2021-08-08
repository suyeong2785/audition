<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/head.jspf"%>
<%@ include file="../../part/toastuiEditor.jspf"%>

<script>
	function ArtworkWriteForm__submit(form) {
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		startLoading();

		form.submit();
	}
</script>
<div class="con p-4">
	<span class="font-bold text-xl">Casting Call 등록</span>
</div>

<form method="POST" class="bg-gray-200 p-4 w-full h-full"
	action="doWriteArtwork"
	onsubmit="ArtworkWriteForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="detailArtwork?id=#id">
	<div class="con">
		<div class="text-sm font-bold">캐스팅콜 등록에 관한설명</div>
		<div class="text-xs pb-4">캐스팅 콜 등록에 관한 설명 설명 설명 설명 설명 설명 설명 설명
			설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명</div>

		<label>
			<input class="text-sm cursor-pointer hidden" type="file" multiple>
			<div
				class=" mb-4 w-full text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600">
				대표 이미지를 선택해주세요</div>
		</label>
		<div class="form-control-box pb-4 flex-grow">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="text" placeholder="장르/종류" name="genre" maxlength="100" />
		</div>
		<div class="form-control-box pb-4 flex-grow">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="text" placeholder="영화제목" name="name" maxlength="100" />
		</div>
		<div class="form-control-box w-full pb-4">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="text" placeholder="영화사" name="productionName"
				maxlength="100" />
		</div>
		<div class="pb-4 text-center">모집일정</div>
		<div class="form-control-box w-full pb-4 flex items-center">
			<input
				class="border rounded-full flex-grow py-2 pl-2 focus:outline-none focus:shadow-outline"
				type="date" name="castingStart" />
			<span>~</span>
			<input
				class="border rounded-full flex-grow py-2 pl-2 focus:outline-none focus:shadow-outline"
				type="date" name="castingEnd" />
		</div>
		<div class="form-control-box w-full pb-4">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="text" placeholder="감독명을 입력해주세요." name="directorName"
				maxlength="100" />
		</div>
		<div class="form-control-box w-full pb-4">
			<textarea
				class="shadow appearance-none border rounded-lg w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline h-72"
				maxlength="300" name="etc" placeholder="기타를 입력해주세요."></textarea>
		</div>

		<button class="btn btn-primary" type="submit">작성</button>
		<a class="btn btn-info" href="${listUrl}">리스트</a>
	</div>
</form>


<%@ include file="../part/foot.jspf"%>