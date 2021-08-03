<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="오디션 신청관리페이지" />
<%@ include file="../part/head.jspf"%>

<div class="con mx-auto mb-4">
	<div
		class="relative flex justify-center items-center text-white text-center h-12 md:h-14 text-2xl md:text-4xl mb-4">
		<!-- 검색 상자 -->
		<div class="search-box flex-grow h-full ">
			<input id="actor-search-input"
				class="bg-gray-200 block w-full h-full text-xl px-4 text-black"
				type="text" placeholder="지원자를 공유할 캐스팅디렉터님의 아이디를 입력해주세요" />
		</div>
		<!-- 검색 버튼 -->
		<button onclick="getActorListByName()"
			class="flex justify-center items-center h-full bg-green-400 text-white text-center h-full px-4 text-2xl md:text-3xl hover:bg-green-500">
			<i class="fas fa-search"></i>
		</button>
		<!-- 검색 닫기버튼 -->
		<button onclick="closeActorList()" id="search-close-button"
			class=" hidden justify-center items-center h-full bg-green-400 text-white text-center h-full px-4 text-2xl md:text-3xl hover:bg-green-500">
			<i class="fas fa-times"></i>
		</button>
	</div>
	
	<div id="search-result"></div>
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
	
	function closeActorList() {

		$('#search-close-button').css("display", "none");
		$('#search-result').empty();
	}

	function getActorListByName(sort) {

		//양쪽 공백제거
		var $actor_search_input = $.trim($('#actor-search-input').val());

		if ($actor_search_input == "") {
			alert('검색어를 입력해주세요.');
			return;
		}

		$.get('../../adm/actor/getActorListByNameAjax', {
			name : $actor_search_input
		},function(data){
			if(sort != null && sort != ''){
				data.body.sort = sort;
				
				getSortedActorListBy(data);
			}else{
				CastingDirectorList(data);
			}
			
		}, 'json');

	}
	
	function getSortedActorListBy(data){
		var actors = data.body.actors;
		var sort = data.body.sort;
		
		if(sort != null && sort != ''){
			if(sort == "ascendingSortByName" ){
				actors = actors.sort(function(a, b){
					return a.name < b.name ? -1 : a.name > b.name ? 1 : 0;
				});
				
				data.body.actors = actors;
				
			}else if(sort == "descendingSortByName"){
				actors = actors.sort(function(a, b){
					return a.name > b.name ? -1 : a.name < b.name ? 1 : 0;
				});
				
				data.body.actors = actors;
			}else if(sort == "ascendingSortByAge"){
				actors = actors.sort(function(a, b){
					return a.age < b.age ? -1 : a.age > b.age ? 1 : 0;
				});
				
				data.body.actors = actors;
			}else if(sort == "descendingSortByAge"){
				actors = actors.sort(function(a, b){
					return a.age > b.age ? -1 : a.age < b.age ? 1 : 0;
				});
				
				data.body.actors = actors;
			}else if(sort == "ascendingSortByGender"){
				actors = actors.sort(function(a, b){
					return a.gender < b.gender ? -1 : a.gender > b.gender ? 1 : 0;
				});
				
				data.body.actors = actors;
			}else if(sort == "descendingSortByGender"){
				actors = actors.sort(function(a, b){
					return a.gender > b.gender ? -1 : a.gender < b.gender ? 1 : 0;
				});
				
				data.body.actors = actors;
			}
		}
		
		CastingDirectorList(data);
	}

	function CastingDirectorList(data) {
		var $search_result = $('#search-result');

		//값 초기화
		$('#search-result').empty();

		if (data.resultCode.startsWith('F') == true) {
			$('#search-close-button').css("display", "none");
		}
		
		drawActorHeader();

		var actors = null;
		var sort = data.body.sort;

		if (data && data.body && data.body.actors) {
			actors = data.body.actors;
			
			if(sort != null && sort != ''){

				if(sort == "ascendingSortByName"){
					$('#ascending-sortByName-button').css("display", "none");
					$('#descending-sortByName-button').css("display", "inline-block");
					
				}else if(sort == "descendingSortByName"){
					$('#ascending-sortByName-button').css("display", "inline-block");
					$('#descending-sortByName-button').css("display", "none");
					
				}else if(sort == "ascendingSortByGender"){
					$('#ascending-sortByGender-button').css("display", "none");
					$('#descending-sortByGender-button').css("display", "inline-block");
					
				}else if(sort == "descendingSortByGender"){
					$('#ascending-sortByGender-button').css("display", "inline-block");
					$('#descending-sortByGender-button').css("display", "none");
					
				}else if(sort == "ascendingSortByAge"){
					$('#ascending-sortByAge-button').css("display", "none");
					$('#descending-sortByAge-button').css("display", "inline-block");
					
				}else if(sort == "descendingSortByAge"){
					$('#ascending-sortByAge-button').css("display", "inline-block");
					$('#descending-sortByAge-button').css("display", "none");
				}
			}	
		}

		var $search_result = $('#search-result');

		var html = '';

		$.each(actors,function(index, actor) {

				html += '<div class="flex justify-center text-center border-2 border-black box-border p-4" onclick="showActorInfoModal({actor.id}'
						+ ',' + '{actor.youTubeUrl}' + ',' + '{actor.careerId} )">';
				html += '<div class="flex-1">' + actor.id + '</div>';
				html += '<div class="flex-1">' + actor.name + '</div>';
				html += '<div class="flex-1">' + actor.nickname + '</div>';
				html += '<div class="flex-1">' + actor.gender + '</div>';
				html += '<div class="flex-1">' + actor.age + '</div>';
				html += '</div>';

				//item.name을 변수로 인식해서 uncaught reference error에러 발생 아래처럼 정규식으로 찾아서 값을 넣어줘야함
				html = html.replace(/{actor.id}/gi, "'" + actor.id + "'")
						.replace( /{actor.youTubeUrl}/gi, "'" + actor.youTubeUrl + "'")
						.replace(/{actor.careerId}/gi, "'" + actor.careerId + "'");
			});

		$('#search-result').append(html);

	}

	function drawActorHeader() {
		
		var $search_result = $('#search-result');
		
		html = '';

		html += '<div class="flex justify-center text-center border-2 border-black box-border p-4">';
		html += '<div class="flex-1">번호</div>';
		html += '<div class="flex-1">';
		html += '<span class="pr-2">이름</span>';
		html += '<button onclick="getActorListByName({ascendingSortByName})" id="ascending-sortByName-button" class="text-lg">';
		html += '<i class="fas fa-caret-down"></i>';
		html += '<button>';
		html += '<button onclick="getActorListByName({descendingSortByName})" id="descending-sortByName-button" class="text-lg hidden">';
		html += '<i class="fas fa-caret-up"></i>';
		html += '<button>';
		html += '</div>';
		html += '<div class="flex-1">활동명</div>';
		html += '<div class="flex-1">';
		html += '<span class="pr-2">성별</span>';
		html += '<button onclick="getActorListByName({ascendingSortByGender})" id="ascending-sortByGender-button" class="text-lg">';
		html += '<i id="sort-icon" class="fas fa-caret-down"></i>';
		html += '<button>';
		html += '<button onclick="getActorListByName({descendingSortByGender})" id="descending-sortByGender-button" class="text-lg hidden">';
		html += '<i class="fas fa-caret-up"></i>';
		html += '<button>';
		html += '</div>';
		html += '<div class="flex-1">';
		html += '<span class="pr-2">나이</span>';
		html += '<button onclick="getActorListByName({ascendingSortByAge})" id="ascending-sortByAge-button" class="text-lg">';
		html += '<i id="sort-icon" class="fas fa-caret-down"></i>';
		html += '<button>';
		html += '<button onclick="getActorListByName({descendingSortByAge})" id="descending-sortByAge-button" class="text-lg hidden">';
		html += '<i class="fas fa-caret-up"></i>';
		html += '<button>';
		html += '</div>';
		html += '</div>';
		
		html = html.replace(/{ascendingSortByName}/gi, "'ascendingSortByName'")
		.replace( /{descendingSortByName}/gi, "'descendingSortByName'")
		.replace(/{ascendingSortByGender}/gi, "'ascendingSortByGender'")
		.replace(/{descendingSortByGender}/gi, "'descendingSortByGender'")
		.replace(/{ascendingSortByAge}/gi, "'ascendingSortByAge'")
		.replace(/{descendingSortByAge}/gi, "'descendingSortByAge'");
		
		$search_result.prepend(html);
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
	
	function showForPrintActorinfo(data){
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
		
		if(actor.extra != null ){
			joinedDates = actor.extra.careerDate;
			careerDates = joinedDates.split("_");
			joinedArtworks = actor.extra.careerArtwork;
			careerArtworks = joinedArtworks.split("_");
			
			careerhtml = '';
			careerhtml += '<div>';
			
			for(var i = 0; i < careerDates.length; i++){
				careerhtml += '<div class="flex">';
				careerhtml += '<div class="w-24">' + (careerDates[i].indexOf('-') != -1 ? careerDates[i] : '' ) + '</div>';
				careerhtml += '<div>' + careerArtworks[i] + '</div>';	
				careerhtml += '</div>';
			}
			
			careerhtml += '</div>'; 
			
			$('#career-box').html(careerhtml);
			
		}else{
			$('#career-box').empty();
		}
		
	}
	
	function showProfileImage(data){
		
		var profile = null;
		var html = '';
		
		if(data.body.fileForProfile != null){
			profile = data.body.fileForProfile;
			
			html += '<div class="profile"><img src="'+ profile.forPrintGenUrl +'" alt="" /></div>';
			
			$('#profile').html(html);
		}else{
			
			html += '<div class="profile text-9xl text-green-500">';
			html += '<i class="fas fa-user-circle"></i>';
			html += '</div>';
			
			$('#profile').html(html);
		}
		
	}
</script>


<%@ include file="../part/foot.jspf"%>