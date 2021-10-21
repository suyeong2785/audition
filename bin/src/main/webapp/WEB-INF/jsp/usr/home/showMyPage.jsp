<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../part/head.jsp"%>

<div class="grid grid-rows-layout-myPage con mx-auto">
	<div class="flex items-center px-4">
		<div class="font-black">마이 프로필</div>
		<div class="flex-grow"></div>
		<a
			href="/usr/member/checkPassword?redirectUri=${Util.getUriEncoded('/usr/member/modify')}">
			<div>프로필수정</div>
		</a>
	</div>
	<div class="profile-box text-center bg-gray-300">
		<c:choose>
			<c:when
				test="${loginedMember.youTubeUrl != '' && loginedMember.youTubeUrl != null }">
				<div class="relative h-0 padding-bottom-video">
					<div id="player" class="absolute top-0 left-0 w-full h-full "></div>
				</div>
			</c:when>
			<c:otherwise>
				<a class="flex items-center justify-center w-full h-full font-black"
					href="/usr/member/checkPassword?redirectUri=${Util.getUriEncoded('/usr/member/modify')}">
					자기소개 영상 youTubeUrl을 올려주세요 </a>

			</c:otherwise>
		</c:choose>
	</div>

	<div class="flex items-center justify-center">
		<c:choose>
			<c:when test="${not empty fileForProfile}">
				<img class="rounded-full w-40 h-40 bg-gray-100"
					src="${fileForProfile.forPrintGenUrl}" alt="" />
			</c:when>
			<c:otherwise>
				<a
					href="/usr/member/checkPassword?redirectUri=${Util.getUriEncoded('/usr/member/modify')}">
					<span class="profile text-8xl text-green-500">
						<i class="fas fa-user-circle"></i>
					</span>
				</a>
			</c:otherwise>
		</c:choose>
	</div>

	<div
		class="profile-info flex flex-col items-center justify-center bg-gray-200 font-bold">
		<div class="font-black text-2xl pb-8">${loginedMember.name}</div>
		<div>${loginedMember.cellphoneNo}</div>
		<div>${loginedMember.email}</div>
		<div>${loginedMember.age}살</div>
		<div>${loginedMember.gender}</div>
	</div>

	<div
		class="profile-introduction flex flex-col justify-center items-center items-stretch">
		<c:choose>
			<c:when test="${joinedCareer != null && joinedCareer != ''}">
				<div class="career pl-8 flex-grow py-8">
					<c:forEach items="${joinedCareer}" var="career" varStatus="status">
						<div class="flex pl-2">
							<div class="w-24">${fn:contains(career.key,'-') ? career.key : ''}</div>
							<div>${career.value}</div>
						</div>
					</c:forEach>
				</div>
			</c:when>
		</c:choose>
		<div class="flex flex-col items-center jusfity-center flex-grow py-8">
			<div class="flex-grow flex items-center font-black">관심오디션</div>
			<div class="flex-grow flex items-center">#뮤지컬#광고#실버모델</div>
		</div>
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

</div>
</body>
</html>