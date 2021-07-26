<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="마이 페이지" />
<%@ include file="../part/head.jspf"%>
<div class="con mx-auto">
	<h2 class="text-center">자기소개 영상</h2>

	<div
		class="profile-box con border-2 border-black box-border bg-gray-300 text-center">
		<c:choose>
			<c:when
				test="${loginedMember.youTubeUrl != '' && loginedMember.youTubeUrl != null }">
				<div id="player" class="w-full h-80 md:h-96"></div>
			</c:when>
			<c:otherwise>
				<div class="w-full h-full ">
					<a
						href="/usr/member/checkPassword?redirectUri=${Util.getUriEncoded('/usr/member/modify')}">자기소개
						영상 youTubeUrl을 올려주세요</a>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

	<h2 class="text-center py-2">프로필</h2>
	<div class="flex">
		<div class="profile-image">
			<a
				href="/usr/member/checkPassword?redirectUri=${Util.getUriEncoded('/usr/member/modify')}"
				class="box w-8 h-8 md:w-24 md:h-24 ">
				<c:choose>
					<c:when test="${not empty fileForProfile}">
						<img class="w-24 h-24 md:w-40 md:h-40 mr-8 md:mr-14" src="${fileForProfile.forPrintGenUrl}" alt="" />
					</c:when>
					<c:otherwise>
						<span class="profile text-8xl text-green-500">
							<i class="fas fa-user-circle"></i>
						</span>
					</c:otherwise>
				</c:choose>
			</a>
		</div>
		<div class="profile-info">
			<div>이름 : ${loginedMember.name}</div>
			<div>활동명 : ${loginedMember.nickname}</div>
			<div>나이 : ${loginedMember.age}</div>
			<div>성별 : ${loginedMember.gender}</div>
		</div>
	</div>

	<h2 class="text-center py-2">경력사항</h2>
	<div class="profile-introduction border-2 border-black box-border p-4 box-border"></div>

	<h2 class="text-center py-2">지원한 공고들</h2>

	<div class="list-box">
		<div class="flex justify-center border-2 border-black box-border p-4">
			<div class="text-center ">알림</div>
		</div>
	</div>
	<div class="list-box">
		<c:forEach items="${applymentResults}" var="applymentResult">
			<div class="toggle">
				<div class="flex border-2 border-black box-border p-4">
					<div class=" flex-1">${applymentResult.forPrintApplymentResult}</div>

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

	//alert("loginedMemberYouTubeUrl : " + loginedMemberYouTubeUrl);
	//alert("YouTubeGetID(loginedMemberYouTubeUrl) : "
	//		+ YouTubeGetID(loginedMemberYouTubeUrl));

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