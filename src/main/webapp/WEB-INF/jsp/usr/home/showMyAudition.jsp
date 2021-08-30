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
					<c:if test="${applymentResult.result != 0}">
						<div
							class="absolute top-0 left-0 w-full h-full flex justify-center items-center rounded-full text-white bg-black opacity-60 text-xl">마감</div>
					</c:if>
				</div>
			</c:if>
			<c:if test="${applymentResult.files == '[]'}">
				<div class="relative padding-bottom-50 overlow-hidden">
					<div
						class="absolute top-0 left-0 bg-gray-400 text-white w-full h-full rounded-full flex justify-center items-center">${applymentResult.extra.actingName}</div>
				</div>
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
					<c:choose>
						<c:when test="${applymentResult.result == 0 }">
							<div class="text-xs">진행중</div>
						</c:when>
						<c:when test="${applymentResult.result != 0}">
							<div class="text-xs">마감</div>
						</c:when>
					</c:choose>
				</div>
			</div>

			<div
				class=" flex justify-center items-center font-myAudition text-gray-600 pr-12">
				<c:if test="${applymentResult.result == 0}">
					<i class="fas fa-bell"></i>
					<div class="pl-4">0</div>
				</c:if>
				<c:if test="${applymentResult.result != 0}">
					<div class="flex justify-center items-center" onclick="showReplyFromDirector(${applymentResult.result})">
						<i class="fas fa-bell text-yellow-600"></i>
						<div class="pl-4">1</div>
					</div>
				</c:if>
			</div>

		</div>
	</c:forEach>
</div>

<div id="applyment-reply-modal" class="modal-background">
	<div id="applyment-reply" class="modal-content"></div>
</div>

<script>
	//회원모달창 켜졌을경우 외부영역 클릭 시 팝업 닫기
	$('.modal-background').mouseup(
			function(e) {
				if ($('.modal-content').has(e.target).length === 0
						&& $('.modal-content').has(e.target).length === 0) {
					$('.modal-background').css("display", "none");
				}
			});
	
	function showReplyFromDirector(result){
		if(result == 1){
			$('#applyment-reply').html('<div class="flex justify-center items-center py-8">저희가 찾는 이미지와는 맞는 관계로 1차 합격되었습니다.</br> 2차 면접관련해서 추후 연락드리겠습니다.</div>');
		}else{
			$('#applyment-reply').html('<div class="flex justify-center items-center py-8">이번 작품에 함께하지 못해서 아쉽습니다.</br> 지원해주셔서 진심으로 감사합니다.</div>');
		}
		
		$('#applyment-reply-modal').css("display", "flex");
	}

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