<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="마이 페이지" />
<%@ include file="../part/head.jspf"%>

<h2 class="con">프로필</h2>


<div class="profile-box con border-2 border-black box-border">

	<div id="player" class="w-full h-80 md:h-96"></div>

</div>

<script>
	//유튜브 url에서 videoid추출하는 함수 stackoverflow에서 찾음 제일간단...
	function YouTubeGetID(url) {
		url = (url || '').split(/(vi\/|v=|\/v\/|youtu\.be\/|\/embed\/)/);
		return (url[2] !== undefined) ? url[2].split(/[^0-9a-z_\-]/i)[0]
				: url[0];
	}

	var loginedMemberYouTubeUrl = '<c:out value="${loginedMember.youTubeUrl}" />';

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
</script>

<h2 class="con">지원한 공고들</h2>

<div class="list-box con">
	<div class="flex justify-center border-2 border-black box-border p-4">
		<div class="text-center ">알림</div>
	</div>
</div>
<div class="list-box con">
	<c:forEach items="${applymentResults}" var="applymentResult">
		<div class="toggle">
			<div class="flex border-2 border-black box-border p-4">
				<div class=" flex-1">${applymentResult.forPrintApplymentResult}</div>

			</div>
		</div>
	</c:forEach>
</div>
<%@ include file="../part/foot.jspf"%>