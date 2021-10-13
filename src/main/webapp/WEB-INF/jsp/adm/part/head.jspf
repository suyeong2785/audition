<%@ page import="com.quantom.audition.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${logoText}-관리자-${pageTitle}</title>
<!-- 모바일에서 사이트가 PC에서의 픽셀크기 기준으로 작동하게 하기(반응형 하려면 필요) -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<!-- 구글 폰트 불러오기 -->
<!-- rotobo(400/700), notosanskr(400/700) -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&family=Roboto:wght@400;700&display=swap"
	rel="stylesheet">
<!-- 폰트어썸 불러오기 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css">
<!-- 제이쿼리 불러오기 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- lodash 불러오기 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.20/lodash.min.js"></script>
<!-- 테일윈드 불러오기 -->
<link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">
<!-- swiper 불러오기 -->
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<!-- Swiper JS -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<!-- DaisyUI CSS Tailwind라이브러리 -->
<link href="https://cdn.jsdelivr.net/npm/daisyui@1.13.0/dist/full.css">
<!-- toastr css 라이브러리 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- toastr js 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- 공통(라이브러리) CSS -->
<link rel="stylesheet" href="/resource/common.css" />
<!-- 공통(라이브러리) JS -->
<script src="/resource/common.js"></script>
<!-- 공통 CSS -->
<link rel="stylesheet" href="/resource/app.css" />
<link rel="stylesheet" href="/resource/keyframes.css" />
<!-- 공통 JS -->
<script src="/resource/app.js"></script>
<%="<script>"%>
var activeProfile = '${activeProfile}';
<%="</script>"%>
<%="<script>"%>
var param = ${paramJson};
<%="</script>"%>
</head>
<body>
	<!-- 로딩화면 -->
	<div
		class="loader-background bg-gray-200 bg-opacity-20 w-full h-full z-50 fixed">
		<img class="loader-img absolute " src="/resource/img/logo_1@3x.png"
			alt="" />
		<div class="loader"></div>
	</div>
	<script>
		$(window).on('load', function() {
			$('.loader').fadeOut();
			$('.loader-img').fadeOut();
			$('.loader-background').fadeOut();
		});
	</script>

	<div class="outer-box pt-14">
		<div
			class="mobile-top-bar h-14 flex flex-ai-c justify-center relative">
			<a class="btn-toggle-mobile-side-bar absolute left-4">
				<i class="fas fa-times"></i>
				<i class="fas fa-bars"></i>
			</a>
			<a href="/usr/home/main" class="logo img-box">
				<img src="/resource/img/mobile_header.svg" alt="" />
			</a>
			<!-- 
			<c:if test="${isLogined}">
				<a href="/usr/member/doLogout" class="absolute right-12">
					<i class="fas fa-sign-out-alt"></i>
				</a>
			</c:if>
			 -->
			<c:if test="${isLogined == false}">
				<a href="/usr/member/login" class="absolute right-4">
					<i class="fas fa-user"></i>
				</a>
			</c:if>

			<c:if test="${isLogined}">
				<a href="/usr/home/showMyPage" class="absolute right-2">
					<c:choose>
						<c:when test="${not empty fileForProfile}">
							<img class="profile w-10 h-10"
								src="${fileForProfile.forPrintGenUrl}" alt="" />
						</c:when>
						<c:otherwise>
							<span class="profile text-4xl md:text-8xl text-green-500">
								<i class="fas fa-user-circle"></i>
							</span>
						</c:otherwise>
					</c:choose>
				</a>
			</c:if>
		</div>
		<div class="mobile-side-bar flex flex-ai-c">
			<nav class="menu-box-1 flex-1-0-0">
				<ul>
					<c:if test="${isLogined}">
						<li>
							<a class="flex flex-jc-c" href="/usr/home/main">유저</a>
						</li>
						<li>
							<a class="flex flex-jc-c" href="/adm/actor/getActor">배우검색</a>
						</li>
						<li>
							<a class="flex flex-jc-c" href="/adm/actor/join">배우추가</a>
						</li>
						<li>
							<a class="flex flex-jc-c" href="/adm/home/showMyPage">마이페이지</a>
						</li>
						<li>
							<a class="flex flex-jc-c"
								href="/usr/member/checkPassword?redirectUri=${Util.getUriEncoded('/usr/member/modify')}">내
								정보수정</a>
						</li>
						<li>
							<a class="flex flex-jc-c" href="/usr/member/doLogout">로그아웃</a>
						</li>
					</c:if>
					<li>
						<a class="flex flex-jc-c" href="/adm/actingRole/list">배역리스트</a>
					</li>
					<li>
						<a class="flex flex-jc-c" href="/adm/actingRole/artworkList">작품리스트</a>
					</li>
				</ul>
			</nav>
		</div>
		<c:if test="${pageTitle != null && pageTitle.length() != 0}">
			<h1 class="page-title-box con">${pageTitle}</h1>
		</c:if>
		
<script>
$(function() {
	notifyUserOfApplymentResult();
	setInterval(function() { notifyUserOfApplymentResult()}, 10000);
});
	
	function showNotificationModal(){
		if($('#applyment-notification-modal').data("displayStatus") == "-1"){
			$('#applyment-notification-modal').css("display", "flex");
			$('#applyment-notification-modal').data("displayStatus","1");
		}else{
			$('#applyment-notification-modal').css("display", "none");
			$('#applyment-notification-modal').data("displayStatus","-1");
		}
		
	}

	//외부영역 클릭 시 팝업 닫기
	$(document).mouseup(
		function(e) {
			if ($('.mobile-side-bar').has(e.target).length === 0 && $(e.target).hasClass( 'mobile-side-bar') == false
					&& $('.btn-toggle-mobile-side-bar').has(e.target).length === 0) {
				$html.removeClass('mobile-side-bar-actived');
			}
			if ($('.casting-call-category-button').has(e.target).length === 0) {
				$('.casting-call-category').css("display","none");
			}
			if ($('.actors-DB-category-button').has(e.target).length === 0) {
				$('.actors-DB-category').css("display", "none");
			}
			if($('.modal-background-no-bg').has(e.target).length === 0){
				$('#applyment-notification-modal').css("display", "none");
				$('#applyment-notification-modal').data("displayStatus","-1");
			}
	});

	
	
	function changeAlarmStatus( notificationId, actingRoleId, actingRole, artworkId ){
		$.ajax({
			url : "../../usr/notification/changeNotificationAlarmStatusAjax",
			data : { id : notificationId,
				alarmStatus : 1},
			method : "POST",
			dataType : "json"
		}).done(function(data){
			location.href='./showMyAudition?roleId='+ actingRoleId + '&role='+ actingRole + '&artworkId='+ artworkId  ;
		});		
	}

	function notifyUserOfApplymentResult(){

		$.ajax({
			url : "../../usr/notification/getNotificationsRelatedToUserAjax",
			data : { getterId : loginedMemberId },
			method : "GET",
			dataType : "json"
		}).done(function(data) {
			
			let notifications = data.body.notifications;
			let notificationsSize = 0;
			
			if(data.body.notificationsSize != 0){
				
				notificationsSize = data.body.notificationsSize;
				
				let html = '<div class="p-4">';
				
				$.each( notifications, function(index, notification){
					
					html += '<div>';
					html += '<a href="javascript:changeAlarmStatus('+ notification.id ',' + notification.relId + ',\'' + notification.relName + '\',' + notification.extraId + ')" >'+ notification.relName + '에 대한 지원결과알림</a>';
					html += '</div>';
				});
				
				html += '</div>';
		
				$("#alarm-count").html(notificationsSize);
				$("#alarm-count").css({"display" : "flex"});
				
				$("#applyment-notification").html(html);
			}
			
		});
	}
	
	function showCastingCallCategory() {
		$('.casting-call-category').fadeToggle();
	}
	function showActorsDBCategory() {
		$('.actors-DB-category').fadeToggle();
	}

	function setPositionOfAlarm(targetType, targetName, msg) {

		toastr.options = {
			closeButton : true,
			showMethod : 'slideDown',
			timeOut : 2000,
			extendedTimeOut : 1,
			positionClass : "toast-bottom-left"
		};

		var loginIdCoordinate = null;

		if (targetType == "input" || targetType == "select"
				|| targetType == "textarea") {
			loginIdCoordinate = $(
					targetType + '[name=' + targetName + ']').offset();
		} else if (targetType == "class") {
			loginIdCoordinate = $('.' + targetName).offset();

		} else if (targetType == "id") {
			loginIdCoordinate = $('#' + targetName).offset();
		}

		toastr.options.onShown = function() {

			$('.toast').addClass(targetName);
			$('#toast-container').css("display", "block");
			$('.toast').css({
				"display" : "block",
				"position" : "absolute"
			});
			var height = loginIdCoordinate.top
					- $("." + targetName).outerHeight();
			var left = loginIdCoordinate.left
					- $("." + targetName).outerWidth();
			$("." + targetName).offset({
				left : left,
				top : height + 60
			});

		}

		toastr.warning(msg);

	}
</script>