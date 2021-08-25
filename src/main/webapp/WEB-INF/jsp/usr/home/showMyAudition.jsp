<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../part/head.jspf"%>

<script src="http://www.youtube.com/player_api"></script>
<div class="grid justify-center grid-column-auto-800 p-4 gap-y-4">
	<div class="flex justify-between">
		<div class="text-center ">내가지원한 오디션</div>
		<div class="text-center ">정렬</div>
	</div>
	<c:forEach items="${applymentResults}" var="applymentResult">
		<div
			class="grid grid-columns-myAudition grid-row-myAudition gap-x-2.5 bg-gray-100 place-content-stretch bg-gray-200 rounded-full place-content-stretch">
			<c:if test="${applymentResult.files != '[]'}">
				<div class="relative padding-bottom-50 overlow-hidden">
					<img
						class="absolute top-0 left-0 text-white w-full h-full flex justify-center items-center rounded-full"
						src="${applymentResult.files[0].forPrintGenUrl}" alt="" />
				</div>
			</c:if>
			<c:if test="${applymentResult.files == '[]'}">
				<div
					class="bg-gray-400 text-white object-cover w-20 h-20 rounded-full flex justify-center items-center">${applymentResult.name}</div>
			</c:if>
			<div class="grid items-center">
				<div>
					<div class="font-black text-sm">${applymentResult.extra.artworkName}</div>
					<div class="title text-overflow-el text-xs">
						${applymentResult.extra.actingName}</div>
					<div class="writer text-xs">
						${fn:split(applymentResult.extra.actingStartDate,'T')[0]} ~
						${fn:split(applymentResult.extra.actingEndDate,'T')[0]}</div>
				</div>
				<div class="flex justify-between">
					<div class="text-xs">진행중</div>
					<div class="text-xs pr-12">1차 통과</div>
				</div>
			</div>

			<div
				class=" flex justify-center items-center font-myAudition text-gray-600 pr-12">
				<i class="fas fa-bell"></i>
				<div class="pl-4">0</div>
			</div>

		</div>
	</c:forEach>
</div>
<script>
	//유튜브 url에서 videoid추출하는 함수 stackoverflow에서 찾음 제일간단...
	function YouTubeGetID(url) {
		url = (url || '').split(/(vi\/|v=|\/v\/|youtu\.be\/|\/embed\/)/);
		return (url[2] !== undefined) ? url[2].split(/[^0-9a-z_\-]/i)[0]
				: url[0];
	}

	let loginedMemberYouTubeUrl = '<c:out value="${loginedMember.youTubeUrl}" />';

	if (loginedMemberYouTubeUrl != '' && loginedMemberYouTubeUrl != null) {
		var tag = document.createElement('script');

		tag.src = "https://www.youtube.com/iframe_api";
		var firstScriptTag = document.getElementsByTagName('script')[0];
		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

		var player;

		function onYouTubeIframeAPIReady() {
			player = new YT.Player('player', {
				videoId : YouTubeGetID(loginedMemberYouTubeUrl),
				playerVars : {
					'modestbranding' : 1,
					'controls' : 1,
					'showinfo' : 1,
					'rel' : 0,
					'loop' : 1,
					'playlist' : YouTubeGetID(loginedMemberYouTubeUrl)
				},
				events : {
					'onReady' : onPlayerReady,
					'onStateChange' : onPlayerStateChange
				}
			});
		}

		function onPlayerReady(event) {
		}

		function onPlayerStateChange() {
		}
	}
</script>

<%@ include file="../part/foot.jspf"%>