<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<div class="grid justify-center grid-column-auto-800 mx-4 ">
	<div class="flex justify-between">
		<a href="../home/showMyPage"><div class="text-center py-8 font-bold">목록으로가기</div></a>
		
		<div class="flex items-center justify-center font-bold">
			<a href="./writeArtwork">
				<span>평가자 추가/삭제</span>
			</a>
		</div>
	</div>

	<div>
		<div class="relative flex flex-col">
			<div
				class="z-20 w-full bg-gray-500 text-white font-bold py-2 rounded-full px-4 text-center">
				<span>${artworkName} / ${actingRoleName}</span>
			</div>
			<div id="applyment-left-background"
				class="absolute bottom-0 left-0 bg-gray-300 h-1/2 w-1/2 z-10"></div>
			<div id="applyment-right-background"
				class="absolute bottom-0 right-0 bg-gray-300 h-1/2 w-1/2 z-10"></div>
		</div>
		<div class="bg-gray-300 p-8 text-center font-bold rounded-b-3xl ">홍길동/김남길/홍순인/조철희/김영상
			평가 참여중</div>
	</div>

	<div class="flex justify-between p-4 font-bold">
		<div>추천순</div>
		<div>최신순</div>
		<div>탈락자</div>
	</div>


	<c:forEach items="${applyments}" var="applyment">
		<div class="relative flex flex-col mb-4">
			<div
				class="artworkList-box z-20 grid grid-columns-adm-myPage grid-row-adm-myPage gap-x-2.5 place-content-stretch bg-gray-200 rounded-full ">
				<c:choose>
					<c:when
						test="${applyment.forPrintGenUrlForMember != null && applyment.forPrintGenUrlForMember != ''}">
						<div class="relative padding-bottom-50 overlow-hidden">
							<img
								class="absolute top-0 left-0 text-white w-full h-full flex justify-center items-center rounded-full"
								src="${applyment.forPrintGenUrlForMember}" alt="" />
						</div>
					</c:when>
					<c:when
						test="${applyment.forPrintGenUrlForMember == null || applyment.forPrintGenUrlForMember == ''}">
						<div class="relative padding-bottom-50 overlow-hidden">
							<div
								class="${bgColor} absolute top-0 left-0 text-white w-full h-full rounded-full flex justify-center items-center">장르</div>
						</div>
					</c:when>
				</c:choose>

				<div class="flex flex-col justify-center">
					<div class="font-black text-sm">${applyment.extra.memberName}</div>
					<div class="title text-overflow-el font-bold">${applyment.extra.memberAge}살</div>
					<div class="writer text-xs">
						<div>
							<i class="fas fa-heart"></i>
							5
						</div>
					</div>
				</div>
				<div>
					<div
						class="flex justify-center items-center w-14 h-full text-5xl text-gray-600 pr-8"
						onclick="showApplicantInfoModal('${applyment.forPrintGenUrlForApplyment}','${applyment.extra.memberName}')">
						<i class="fas fa-play-circle"></i>
					</div>
				</div>
				<c:set var="actingRoleBg" value="bg-gray-300"></c:set>
			</div>
		</div>
		<div
			class="actingRoleList flex justify-center items-center text-gray-600 ">
			<!-- 각각의 작품에 해당하는 배역목록을 보여줌  -->
			<div id="actingRoleList${applyment.id}" data-display-status="-1"
				class="flex-col flex-grow hidden ${actingRoleBg} p-4 rounded-b-3xl leading-10">
			</div>
		</div>
	</c:forEach>

</div>
<div class="modal-background">
	<div class="modal-content">
		<div id="video-box" class="flex justify-center"></div>
		<div id="applicantInfo-box"></div>
		<div id="recommenderName-box" class="flex text-sm text-black">
			<div class="bg-gray-200 p-8 text-2xl">
				<i class="fas fa-heart"></i>
				5
			</div>
		</div>
		<div id="button-box" class="button-box flex justify-around p-8">
			<button id="recommendation-button"
				class="bg-gray-500 text-white rounded-full w-12 h-12 text-2xl"
				onclick="doRecommendMember()">
				<i class="fas fa-heart"></i>
			</button>
			<button
				class="bg-gray-500 text-white rounded-full w-12 h-12 text-2xl"
				onclick="hideApplicantDecisonModal()">
				<i class="far fa-circle"></i>
			</button>
			<button
				class="bg-gray-500 text-white rounded-full w-12 h-12 text-2xl"
				onclick="hideApplicantDecisonModal()">
				<i class="fas fa-times"></i>
			</button>
		</div>
	</div>

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

	function showApplicantInfoModal(videoUrl, applicantName) {
		$('#video-box').empty();
		$('#applicantInfo-box').empty();
		$('#recommender').remove();

		$('.modal-background').css("display", "flex");

		if (videoUrl == '' || videoUrl == null) {
			$('#video-box').html('<div class="p-8">오디션 영상이 등록되어 있지않습니다.</div>');
		} else {
			$('#video-box')
					.html(
							'<video id="video" controls="controls" src="'+ videoUrl +'"></video>');
		}

		$('#applicantInfo-box').html(
				'<div class="w-full bg-gray-500 text-white text-center py-2">'
						+ applicantName + '</div>');
		var recommenderHtml = '';
		$('#recommenderName-box')
				.append(
						'<div id="recommender" class="bg-gray-100 p-8 flex-grow flex justify-center">홍길동/김남길/홍순인/조철희/김영상</div>');
	}
</script>


<%@ include file="../part/foot.jspf"%>