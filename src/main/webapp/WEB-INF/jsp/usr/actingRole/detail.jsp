<%@ page import="com.quantom.audition.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jsp"%>


<div class="con">
	<div class=" flex flex-col">
		<div class="max-height-360 relative overflow-hidden">
			<div class="padding-bottom-50">
				<c:choose>
					<c:when test="${artwork.genre == 'action'}">
						<c:set var="bgColor" value="bg-red-200"></c:set>
					</c:when>
					<c:when test="${artwork.genre == 'SF'}">
						<c:set var="bgColor" value="bg-indigo-600"></c:set>
					</c:when>
					<c:when test="${artwork.genre == 'comedy'}">
						<c:set var="bgColor" value="bg-yellow-500"></c:set>
					</c:when>
					<c:when test="${artwork.genre == 'thriller'}">
						<c:set var="bgColor" value="bg-purple-300"></c:set>
					</c:when>
					<c:when test="${artwork.genre == 'war'}">
						<c:set var="bgColor" value="bg-gray-700"></c:set>
					</c:when>
					<c:when test="${artwork.genre == 'sports'}">
						<c:set var="bgColor" value="bg-blue-500"></c:set>
					</c:when>
					<c:when test="${artwork.genre == 'fantasy'}">
						<c:set var="bgColor" value="bg-purple-600"></c:set>
					</c:when>
					<c:when test="${artwork.genre == 'music'}">
						<c:set var="bgColor" value="bg-green-500"></c:set>
					</c:when>
					<c:when test="${artwork.genre == 'romance'}">
						<c:set var="bgColor" value="bg-pink-400"></c:set>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when
						test="${artwork.forPrintGenUrlForArtwork != null && artwork.forPrintGenUrlForArtwork != ''}">
						<img
							class="absolute top-2/4 left-2/4 transform -translate-x-1/2 -translate-y-1/2 h-full"
							src="${artwork.forPrintGenUrlForArtwork}" alt="" />
					</c:when>
					<c:when
						test="${artwork.forPrintGenUrlForArtwork == null || artwork.forPrintGenUrlForArtwork == ''}">
						<div
							class="flex justify-center items-center absolute text-7xl h-full w-full ${bgColor} text-white top-2/4 left-2/4 transform -translate-x-1/2 -translate-y-1/2 capitalize">${artwork.genre}</div>
					</c:when>

				</c:choose>
			</div>
		</div>
		<div class="p-6 text-sm">
			<div class="flex">
				<div class="font-bold pb-4 text-xl">${artwork.title}</div>
			</div>
			<div class="flex">
				<div class="font-bold text-green-600 pb-4 capitalize text-xl">${artwork.genre}</div>
			</div>
			<div class="grid grid-rows-detailArtwork">
				<div class="flex items-stretch">
					<div class="flex items-center min-width-93 border-t border-black">제공(배급)</div>
					<div
						class="flex items-center flex-grow border-t border-gray-300 ml-2.5">${artwork.investor}</div>
				</div>
				<div class="flex items-stretch">
					<div class="flex items-center min-width-93 border-t border-black">제작사(제작자)</div>
					<div
						class="flex items-center flex-grow border-t border-gray-300 ml-2.5">${artwork.productionName}</div>
				</div>
				<div class="flex items-stretch">
					<div class="flex items-center min-width-93 border-t border-black">감독</div>
					<div
						class="flex items-center flex-grow border-t border-gray-300 ml-2.5">${artwork.directorName}</div>
				</div>
				<div class="flex items-stretch">
					<div class="flex items-center min-width-93 border-t border-black">주연(출연)</div>
					<div
						class="flex items-center flex-grow border-t border-gray-300 ml-2.5">${artwork.leadActor}</div>
				</div>
				<div class="flex items-stretch">
					<div class="flex items-center min-width-93 border-t border-black">오디션일정</div>${fn:split(actingRole.startDate,' ')[0]}
					<div
						class="flex items-center flex-grow border-t border-gray-300 ml-2.5">${fn:split(artwork.startDate,' ')[0]}
						- ${fn:split(artwork.endDate,' ')[0]} (예정)</div>
				</div>
			</div>
			<div class="flex border-t border-b border-black">
				<div class="text-sm pt-2.5 pb-2.5">${artwork.etc}</div>
			</div>
			<div class="flex font-black border-b border-black pt-2.5 pb-2.5">
				<div class="min-width-93">출연배역</div>
				<div>
					<c:forEach items="actingRoles" var="actingRole">
						<div class="flex items-center">
							<span id="share-search-button" class="text-2xl">
								<i class="fas fa-info-circle"></i>
							</span>
							<span class="pl-2.5">${actingRole.gender} ${actingRole.role} -
								${actingRole.age}</span>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>

<!--  
		<div class="p-6">
			<div class="flex">
				<div class="font-black">${actingRole.extra.artworkName}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">배역명</div>
				<div>${actingRole.name}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">연령/성별</div>
				<div>${actingRole.age}/${actingRole.gender}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">직업</div>
				<div>${actingRole.job}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">촬영일정</div>
				<div>${actingRole.schedule}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">촬영횟수</div>
				<div>${actingRole.shootingsCount}회</div>
			</div>
			<div class="flex">
				<div class="min-width-96">촬영지역</div>
				<div>${actingRole.region}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">출연료</div>
				<div>${actingRole.pay}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">모집기간</div>
				<div>${fn:split(actingRole.startDate,' ')[0]}~
					${fn:split(actingRole.endDate,' ')[0]}</div>
			</div>
			<c:choose>
				<c:when test="${actingRole.files != '[]'}">
					<c:forEach items="${actingRole.files}" var="file">
						<c:choose>
							<c:when test="${file.typeCode == 'script'}">
								<div class="flex">
									<div class="min-width-96">지정연기 대본</div>
									<div>
										<a href="${file.forPrintGenUrl}" download>오디션 대본 다운로드</a>
									</div>
								</div>
							</c:when>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>
		</div>
		-->

<div class="bg-gray-100 ">
	<div class="con p-6">
		<div class="flex">
			<div class="min-width-96">주요사항</div>
			<div>${actingRole.feature}</div>
		</div>
		<c:if
			test="${actingRole.guideVideoUrl != null && actingRole.guideVideoUrl != ''}">
			<div class="min-width-96">오디션 가이드영상</div>
			<div class="relative h-0 padding-bottom-video">
				<div id="player" class="absolute top-0 left-0 w-full h-full "></div>
			</div>
		</c:if>
	</div>
</div>

<a href="/usr/applyment/write?id=${actingRole.id}">
	<div class="text-xl flex justify-center items-center py-8">지원하기</div>
</a>

<div class="grid grid-cols-2 py-8">
	<div class="flex justify-center items-center">관심오디션저장</div>
	<div class="flex justify-center items-center">리스트보기</div>
</div>

<script>
	function YouTubeGetID(url) {
		url = (url || '').split(/(vi\/|v=|\/v\/|youtu\.be\/|\/embed\/)/);
		return (url[2] !== undefined) ? url[2].split(/[^0-9a-z_\-]/i)[0]
				: url[0];
	}

	let guideVideoUrl = '<c:out value="${actingRole.guideVideoUrl}" />';

	if (guideVideoUrl != '' && guideVideoUrl != null) {
		var tag = document.createElement('script');

		tag.src = "https://www.youtube.com/iframe_api";
		var firstScriptTag = document.getElementsByTagName('script')[0];
		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

		var player;

		function onYouTubeIframeAPIReady() {
			player = new YT.Player('player', {
				videoId : YouTubeGetID(guideVideoUrl),
				playerVars : {
					'modestbranding' : 1,
					'controls' : 1,
					'showinfo' : 1,
					'rel' : 0,
					'loop' : 1,
					'playlist' : YouTubeGetID(guideVideoUrl)
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