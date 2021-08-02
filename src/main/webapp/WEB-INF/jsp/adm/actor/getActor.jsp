<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="오디션 신청관리페이지" />
<%@ include file="../part/head.jspf"%>

<div class="con mx-auto mb-4">
	<div class="flex border-2 border-black box-border p-2 mb-2">
		<div class="text-center flex-grow">캐스팅 검색</div>
	</div>
	<div
		class="relative flex justify-center items-center text-white text-center h-12 md:h-14 text-2xl md:text-4xl mb-4">
		<!-- 검색 상자 -->
		<div class="search-box flex-grow h-full ">
			<input id="actor-search-input"
				class="bg-gray-200 block w-full h-full text-xl px-4 text-black"
				type="text" placeholder="지원자를 공유할 캐스팅디렉터님의 아이디를 입력해주세요" />
		</div>
		<!-- 검색 버튼 -->
		<button onclick="getCastingDirectorList()"
			class="flex justify-center items-center h-full bg-green-400 text-white text-center h-full px-4 text-2xl md:text-3xl hover:bg-green-500">
			<i class="fas fa-search"></i>
		</button>
		<!-- 검색 닫기버튼 -->
		<button onclick="closeCastingDirectorList()" id="search-close-button"
			class=" hidden justify-center items-center h-full bg-green-400 text-white text-center h-full px-4 text-2xl md:text-3xl hover:bg-green-500">
			<i class="fas fa-times"></i>
		</button>
	</div>
	<div id="search-result"></div>
</div>
<div class="popup-1" id="actor-decision-form-modal">
	<div class="content mx-auto ">
		<div
			class="profile-box con border-2 border-black box-border bg-gray-300 text-center">
			<div id="player" class="w-full h-80 md:h-96"></div>
			<div id="no-player" class="w-full h-full ">
				<a
					href="/usr/member/checkPassword?redirectUri=${Util.getUriEncoded('/adm/actor/modify')}">자기소개
					영상 youTubeUrl을 올려주세요</a>
			</div>
		</div>
		<div id="profile"></div>
		<div id="button-box" class="button-box flex justify-center">
			<button
				class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow"
				onclick="hideApplicantDecisonModal()">닫기</button>
		</div>
	</div>

</div>

<script>
	function closeCastingDirectorList() {

		$('#search-close-button').css("display", "none");
		$('#search-result').empty();
	}

	function getCastingDirectorList() {

		//양쪽 공백제거
		var $actor_search_input = $.trim($('#actor-search-input').val());

		if ($actor_search_input == "") {
			alert('검색어를 입력해주세요.');
			return;
		}

		$.get('../../adm/actor/getActorListByNameAjax', {
			name : $actor_search_input
		}, CastingDirectorList, 'json');

	}

	function CastingDirectorList(data) {
		var $search_result = $('#search-result');

		//값 초기화
		$('#search-result').empty();

		if (data.resultCode.startsWith('F') == true) {
			$('#search-close-button').css("display", "none");
		}

		var actors = null;

		if (data && data.body && data.body.actors) {
			actors = data.body.actors;

			$('#search-close-button').css("display", "flex");
		}

		drawActorHeader();

		var $search_result = $('#search-result');

		var html = '';

		$.each(actors,function(index, actor) {

				html += '<div class="flex justify-center text-center border-2 border-black box-border p-4" onclick="showActorInfoModal({actor.id}'
						+ ',' + '{actor.youTubeUrl}' + ',' + '{actor.careerId} )">';
				html += '<div class="flex-1">' + actor.id + '</div>';
				html += '<div class="flex-1">' + actor.name + '</div>';
				html += '<div class="flex-1">' + actor.nickname + '</div>';
				html += '<div class="flex-1">' + actor.gender + '</div>';
				html += '<div class="flex-1">' + actor.age + '</div>';
				html += '</div>';

				//item.name을 변수로 인식해서 uncaught reference error에러 발생 아래처럼 정규식으로 찾아서 값을 넣어줘야함
				html = html.replace(/{actor.id}/gi, "'" + actor.id + "'")
						.replace( /{actor.youTubeUrl}/gi, "'" + actor.youTubeUrl + "'")
						.replace(/{actor.careerId}/gi, "'" + actor.careerId + "'");

			});

		$('#search-result').append(html);

	}

	function drawActorHeader() {

		var $search_result = $('#search-result');

		html = '';

		html += '<div class="flex justify-center text-center border-2 border-black box-border p-4">';
		html += '<div class="flex-1">번호</div>';
		html += '<div class="flex-1">이름</div>';
		html += '<div class="flex-1">활동명</div>';
		html += '<div class="flex-1">성별</div>';
		html += '<div class="flex-1">나이</div>';
		html += '</div>';

		$search_result.prepend(html);
	}

	function hideApplicantDecisonModal() {
		$("#actor-decision-form-modal").css("display", "none");
	}

	//유튜브 url에서 videoid추출하는 함수 stackoverflow에서 찾음 제일간단...
	function YouTubeGetID(url) {
		url = (url || '').split(/(vi\/|v=|\/v\/|youtu\.be\/|\/embed\/)/);
		return (url[2] !== undefined) ? url[2].split(/[^0-9a-z_\-]/i)[0]
				: url[0];
	}

	// 2. This code loads the IFrame Player API code asynchronously.
	var tag = document.createElement('script');

	tag.src = "https://www.youtube.com/iframe_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

	// 3. This function creates an <iframe> (and YouTube player)
	//    after the API code downloads.
	var player;

	function onYouTubeIframeAPIReady() {
		player = new YT.Player('player', {});
	}

	function showActorInfoModal(actorId, actorYouTubeUrl, actorCareerId) {

		$.get('../../adm/actor/getForPrintActorByIdAjax', {
			id : actorId
		}, function(data) {
			alert(data.msg);
		}, 'json');
		
		if (actorYouTubeUrl != "" && actorYouTubeUrl != null) {
			$('#player').css("display", "block");
			$('#no-player').css("display", "none");
			player.cueVideoById(YouTubeGetID(actorYouTubeUrl));
			
		} else {
			$('#no-player').css("display", "block");
			$('#player').css("display", "none");
		}

		$("#actor-decision-form-modal").css("display", "block");

	}
</script>


<%@ include file="../part/foot.jspf"%>