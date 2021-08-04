<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="오디션 신청관리페이지" />
<%@ include file="../part/head.jspf"%>

<script>
	let DoSearchActors__submited = false;

	function DoSearchActors__submit(form) {

		if (DoSearchActors__submited) {
			alert('처리중입니다.');
			return;
		}

		form.searchKeyword.value = form.searchKeyword.value.trim();

		if (form.searchKeyword.value.length == 0) {
			alert('검색어를 입력해주세요.');
			form.searchKeyword.focus();
			return;
		}

		form.submit();
		DoSearchActors__submited = true;
	}
</script>
<div class="con mx-auto mb-4">
	<form action="../../adm/actor/showActorListBySearch"
		onsubmit="DoSearchActors__submit(this); return false;">
		<input type="hidden" name="page" value="1" />
		<div
			class="relative flex justify-center items-center text-center h-12 md:h-14 text-2xl md:text-4xl mb-4">
			<c:set var="searchType" value="${param.searchType}" />
			<select name="searchType">
				<option value="name" selected>이름</option>
				<option value="nickname">활동명</option>
				<option value="email">이메일</option>
				<option value="phone">전화번호</option>
			</select>
			<c:set var="itemsInAPage" value="${param.itemsInAPage}" />
			<select name="itemsInAPage">
				<option selected="selected">5</option>
				<option>6</option>
				<option>7</option>
				<option>8</option>
				<option>9</option>
				<option>10</option>
			</select>
			<script>
				const param__searchType = '${param.searchType}';

				if (param__searchType) {
					$('select[name="searchType"]').val(param__searchType);
				}

				const param__itemsInAPage = '${param.itemsInAPage}';

				if (param__itemsInAPage) {
					$('select[name="itemsInAPage"]').val(param__itemsInAPage);
				}
			</script>
			<!-- 검색 상자 -->
			<div class="search-box flex-grow h-full ">
				<c:set var="searchKeyword" value="${param.searchKeyword}" />
				<input name="searchKeyword"
					class="bg-gray-200 block w-full h-full text-xl px-4 text-black"
					type="text" placeholder="지원자를 공유할 캐스팅디렉터님의 아이디를 입력해주세요"
					value="${param.searchKeyword}" />
			</div>

			<!-- 검색 버튼 -->
			<button type="submit"
				class="flex justify-center items-center h-full bg-green-400 text-white text-center h-full px-4 text-2xl md:text-3xl hover:bg-green-500">
				<i class="fas fa-search"></i>
			</button>

			<!-- 검색 닫기버튼 -->
			<button onclick="closeActorList()" id="search-close-button"
				class=" hidden justify-center items-center h-full bg-green-400 text-white text-center h-full px-4 text-2xl md:text-3xl hover:bg-green-500">
				<i class="fas fa-times"></i>
			</button>
		</div>
		<div
			class="flex justify-center text-center border-2 border-black box-border p-4">
			<c:set var="sort" value="${param.sort}" />
			<input type="hidden" name="sort" />
			<script>
				const param__sort = '${param.sort}';

				if (param__sort) {
					$('input[name="sort"]').val(param__sort);
				}
			</script>
			<div class="flex-1">번호</div>
			<div class="flex-1">
				<span class="pr-2">이름</span>
				<button id="ascending-sortByName-button" class="text-lg"
					onclick="doSortActorList('ascendingSortByName')" type="submit">
					<i class="fas fa-caret-down"></i>
				</button>
				<button id="descending-sortByName-button" class="text-lg hidden"
					onclick="doSortActorList('descendingSortByName')" type="submit">
					<i class="fas fa-caret-up"></i>
				</button>
			</div>
			<div class="flex-1">활동명</div>
			<div class="flex-1">
				<span class="pr-2">성별</span>
				<button id="ascending-sortByGender-button" class="text-lg"
					onclick="doSortActorList('ascendingSortByGender')" type="submit">
					<i id="sort-icon" class="fas fa-caret-down"></i>
				</button>
				<button id="descending-sortByGender-button" class="text-lg hidden"
					onclick="doSortActorList('descendingSortByGender')" type="submit">
					<i class="fas fa-caret-up"></i>
				</button>
			</div>
			<div class="flex-1">
				<span class="pr-2">나이</span>
				<button id="ascending-sortByAge-button" class="text-lg"
					onclick="doSortActorList('ascendingSortByAge')" type="submit">
					<i id="sort-icon" class="fas fa-caret-down"></i>
				</button>
				<button id="descending-sortByAge-button" class="text-lg hidden"
					onclick="doSortActorList('descendingSortByAge')" type="submit">
					<i class="fas fa-caret-up"></i>
				</button>
			</div>
		</div>
	</form>

	<div id="search-result">
		<c:forEach items="${actors}" var="actor">
			<div
				class="flex justify-center text-center border-2 border-black box-border p-4"
				onclick="showActorInfoModal( '${actor.id}' , '${actor.youTubeUrl}' , '${actor.careerId}' )">
				<div class="flex-1">${actor.id}</div>
				<div class="flex-1">${actor.name}</div>
				<div class="flex-1">${actor.nickname}</div>
				<div class="flex-1">${actor.gender}</div>
				<div class="flex-1">${actor.age}</div>
			</div>
		</c:forEach>
	</div>

	<!-- pagination -->
	<div
		class="bg-white px-4 py-3 flex items-center justify-center border-t border-gray-200 sm:px-6">
		<div class="flex items-center justify-between">
			<div>
				<nav
					class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px"
					aria-label="Pagination">
					<c:set var="url"
						value="../../adm/actor/showActorListBySearch?searchType=${searchType}&searchKeyword=${searchKeyword}&itemsInAPage=${itemsInAPage}&sort=${sort}" />
					<a href="${url}&page=1"
						class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
						<i class="fas fa-angle-double-left"></i>
					</a>
					<a href="${url}&page=${param.page - 1}"
						class="relative inline-flex items-center px-2 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
						<i class="fas fa-chevron-left"></i>
					</a>
					<c:forEach begin="${pageMenuStart}" end="${pageMenuEnd}" var="i">
						<c:set var="pageStyle"
							value="bg-white border-gray-300 relative items-center px-4 py-2 border text-sm font-medium" />
						<c:if test="${param.page == i}">
							<a href="${url}&page=${i}" aria-current="page"
								class="${pageStyle} text-red-500 hover:bg-red-50 inline-flex">
								${i} </a>
						</c:if>
						<c:if test="${param.page != i}">
							<c:set var="reactivePagination" value="3"></c:set>
							<c:choose>
								<c:when test="${(param.page - reactivePagination) >= i || (param.page + reactivePagination) <= i}">
									<a href="${url}&page=${i}" aria-current="page"
										class="${pageStyle} text-gray-500 hover:bg-gray-50 hidden sm:inline-flex">
										${i} </a>
								</c:when>
								<c:when test="${(param.page - reactivePagination) <= i && (param.page + reactivePagination) >= i}">
									<a href="${url}&page=${i}" aria-current="page"
										class="${pageStyle} text-gray-500 hover:bg-gray-50 inline-flex">
										${i} </a>
								</c:when>
							</c:choose>

						</c:if>
					</c:forEach>
					<a href="${url}&page=${param.page + 1}"
						class="relative inline-flex items-center px-2 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
						<i class="fas fa-chevron-right"></i>
					</a>
					<a href="${url}&page=${totalPage}"
						class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
						<i class="fas fa-angle-double-right"></i>
					</a>
				</nav>
			</div>
		</div>
	</div>
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
		<div class="flex items-center">
			<div id="profile" class="box w-32 h-32 mr-8"></div>
			<div id="actorInfo"></div>
		</div>
		<div id="career-box"></div>
		<div id="button-box" class="button-box flex justify-center">
			<button
				class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow"
				onclick="hideApplicantDecisonModal()">닫기</button>
		</div>
	</div>
</div>

<script>
	const sortStatus = '<c:out value="${sortStatus}" />';

	if (sortStatus != null && sortStatus != '') {

		if (sortStatus == "ascendingSortByName") {
			$('#ascending-sortByName-button').css("display", "none");
			$('#descending-sortByName-button').css("display", "inline-block");

		} else if (sortStatus == "descendingSortByName") {
			$('#ascending-sortByName-button').css("display", "inline-block");
			$('#descending-sortByName-button').css("display", "none");

		} else if (sortStatus == "ascendingSortByGender") {
			$('#ascending-sortByGender-button').css("display", "none");
			$('#descending-sortByGender-button').css("display", "inline-block");

		} else if (sortStatus == "descendingSortByGender") {
			$('#ascending-sortByGender-button').css("display", "inline-block");
			$('#descending-sortByGender-button').css("display", "none");

		} else if (sortStatus == "ascendingSortByAge") {
			$('#ascending-sortByAge-button').css("display", "none");
			$('#descending-sortByAge-button').css("display", "inline-block");

		} else if (sortStatus == "descendingSortByAge") {
			$('#ascending-sortByAge-button').css("display", "inline-block");
			$('#descending-sortByAge-button').css("display", "none");
		}
	}

	function closeActorList() {
		$('#search-close-button').css("display", "none");
	}

	function doSortActorList(sort) {
		if (sort != null && sort != '') {
			$('input[name="sort"]').val(sort);
		}

		//if (data.resultCode.startsWith('F') == true) {
		//	$('#search-close-button').css("display", "none");
		//}

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
			showForPrintActorinfo(data);
			showProfileImage(data);
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

	function showForPrintActorinfo(data) {
		var actor = data.body.forPrintactor;

		var joinedDates = null;
		var joinedArtworks = null;
		var careerDates = [];
		var careerArtworks = [];

		html = '';
		html += '<div>';
		html += '<div>이름 : ' + actor.name + '</div>';
		html += '<div>활동명 : ' + actor.nickname + '</div>';
		html += '<div>나이 : ' + actor.age + '</div>';
		html += '<div>성별 : ' + actor.gender + '</div>';
		html += '<div>키 : ' + actor.height + '</div>';
		html += '<div>몸무게 : ' + actor.weight + '</div>';
		html += '<div>전화번호 : ' + actor.phone + '</div>';
		html += '<div>이메일 : ' + actor.email + '</div>';
		html += '</div>';

		$('#actorInfo').html(html);

		if (actor.extra != null) {
			joinedDates = actor.extra.careerDate;
			careerDates = joinedDates.split("_");
			joinedArtworks = actor.extra.careerArtwork;
			careerArtworks = joinedArtworks.split("_");

			careerhtml = '';
			careerhtml += '<div>';

			for (var i = 0; i < careerDates.length; i++) {
				careerhtml += '<div class="flex">';
				careerhtml += '<div class="w-24">'
						+ (careerDates[i].indexOf('-') != -1 ? careerDates[i]
								: '') + '</div>';
				careerhtml += '<div>' + careerArtworks[i] + '</div>';
				careerhtml += '</div>';
			}

			careerhtml += '</div>';

			$('#career-box').html(careerhtml);

		} else {
			$('#career-box').empty();
		}

	}

	function showProfileImage(data) {

		var profile = null;
		var html = '';

		if (data.body.fileForProfile != null) {
			profile = data.body.fileForProfile;

			html += '<div class="profile"><img src="'+ profile.forPrintGenUrl +'" alt="" /></div>';

			$('#profile').html(html);
		} else {

			html += '<div class="profile text-9xl text-green-500">';
			html += '<i class="fas fa-user-circle"></i>';
			html += '</div>';

			$('#profile').html(html);
		}

	}
</script>


<%@ include file="../part/foot.jspf"%>