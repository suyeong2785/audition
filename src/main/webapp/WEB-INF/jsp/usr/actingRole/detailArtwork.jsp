<%@ page import="com.quantom.audition.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

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
				<div class="font-bold pb-4 text-xl">${artwork.name}</div>
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
					<c:forEach var="i" begin="0"
						end="${fn:length(actingRoles)-1 > 0 ? fn:length(actingRoles)-1 : 0}">
						<div class="flex items-center">
							<span id="share-search-button" class="text-2xl" 
								onclick="showShareModal('${actingGenders[i]}','${actingRoles[i]}','${actingAges[i]}')">
								<i class="fas fa-info-circle"></i>
							</span>
							<span class="pl-2.5">${actingGenders[i]} -
								${actingRoles[i]} ${actingAges[i]}</span>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="detailArtwork-share-modal" class="modal-background">
	<div class="modal-content rounded-2xl">
		<div class="border-t-2 border-b-2 border-gray-300">
			<div>하하하하하</div>
		</div>
	</div>
</div>

<script>
	var artworkId = '<c:out value="${artwork.id}"/>';

	//회원모달창 켜졌을경우 외부영역 클릭 시 팝업 닫기
	$('.modal-background').mouseup(
			function(e) {
				if ($('.modal-content').has(e.target).length === 0
						&& $('.modal-content').has(e.target).length === 0) {
					$('.modal-background').css("display", "none");
				}
			});

	function showShareModal(gender, role, age) {
		$('#detailArtwork-share-modal').css("display", "flex");

		$.get('getActingRoleByArtworkIdAndNameAndAgeAndGenderAjax',{
			artworkId : artworkId,
			gender : gender,
			name : role,
			age : age
			},function(data){
			
			},'json'	
		);
		
	}
</script>
<%@ include file="../part/foot.jspf"%>