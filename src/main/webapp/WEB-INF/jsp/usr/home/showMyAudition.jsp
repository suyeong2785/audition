<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../part/head.jspf"%>

<script src="http://www.youtube.com/player_api"></script>
<div class="con mx-auto">
	<div class=" my-4">
		<div class="flex justify-center border-2 border-black box-border p-4">
			<div class="text-center ">지원결과 알림</div>
		</div>
	</div>
	<div>
		<c:forEach items="${applymentResults}" var="applymentResult">
			<div>
				<div class="p-4">
					<div class="">${applymentResult.forPrintApplymentResult}</div>

				</div>
			</div>
		</c:forEach>
	</div>
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