<%@ page import="com.quantom.audition.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${logoText}-${pageTitle}</title>
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
<!-- 테일윈드 불러오기 -->
<link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css"
	rel="stylesheet">
<!-- swiper 불러오기 -->
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<!-- Swiper JS -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<!-- 제이쿼리 불러오기 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- lodash 불러오기 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.20/lodash.min.js"></script>
<!-- toastr css 라이브러리 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css"
	integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- toastr js 라이브러리 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"
	integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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
var param = ${paramJson}; var loginedMemberId = ${loginedMemberId};
<%="</script>"%>

<script>
	
	// 사파리 브라우저의 경우 history.back()을 했을 때 브라우저가 리프레시 되지 않는다.
	$(window).bind("pageshow", function(event) {
		//back 이벤트 일 경우
		if (event.originalEvent && event.originalEvent.persisted) {
			endLoading();
		}
	});
</script>

<!-- 구글 웹 마스터 인증코드 
<meta name="google-site-verification"
	content="f18pCJNXQZFxWyHdwR1NI63OBAIGqNcL-ZywOncwNIM" />
	-->

<!-- 애드센스 인증용 코드 
<script data-ad-client="ca-pub-1005451568380744" async
	src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
-->
</head>

<body>
	<!-- 로딩화면 -->
	<div
		class="loader-background bg-gray-200 bg-opacity-20 w-full h-full absolute z-40">
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
		<div class="mobile-top-bar h-14 flex flex-ai-c justify-between px-3">
			<a class="btn-toggle-mobile-side-bar ">
				<i class="fas fa-bars"></i>
			</a>
			<a href="/usr/home/main" class="logo img-box">
				<img src="/resource/img/mobile_header.svg" alt="" />
			</a>
			<c:if test="${isLogined == false}">
				<a href="/usr/member/login">
					<i class="fas fa-user"></i>
				</a>
			</c:if>

			<c:if test="${isLogined}">
				<div class="flex items-center">
					<div class="alarm-box flex relative mr-4"
						onclick="showNotificationModal()">
						<div id="alarm" class="text-2xl "
							style="animation:alarm 1s linear 0.5s infinite alternate both;">
							<i class="far fa-bell"></i>
						</div>
						<div id="alarm-count"
							class="hidden items-center justify-center absolute bg-red-500 rounded-full w-4 h-4 text-white ml-2"></div>
					</div>
					<a href="/usr/home/showCommonMyPage">
						<c:choose>
							<c:when test="${not empty fileForProfile}">
								<img class="profile w-10 h-10"
									src="${fileForProfile.forPrintGenUrl}" alt="" />
							</c:when>
							<c:otherwise>
								<span class="profile text-4xl text-green-500">
									<i class="fas fa-user-circle"></i>
								</span>
							</c:otherwise>
						</c:choose>
					</a>
				</div>
			</c:if>
		</div>
		<div class="mobile-side-bar p-14">
			<nav class="menu-box-1 text-xl">
				<ul class="grid gap-4">
					<li class="casting-call-category-button">
						<span onclick="showCastingCallCategory()">Casting Call</span>
						<div class="casting-call-category hidden text-base">
							<a href="/usr/actingRole/artworkList">
								<div class="py-4">List</div>
							</a>
							<a href="../../adm/actingRole/writeArtwork">
								<div class="pb-4">Write</div>
							</a>
						</div>
					</li>
					<li>
						<a href="/usr/actingRole/artworkListForAuditions">Auditions</a>
					</li>
					<li>
						<a href="">News</a>
					</li>
					<li class="actors-DB-category-button">
						<span onclick="showActorsDBCategory()">Actors DB</span>
						<div class="actors-DB-category hidden text-base">
							<a href="/adm/actor/getActor">
								<div class="py-4">Search</div>
							</a>
							<a href="/adm/actor/join">
								<div>Add</div>
							</a>
						</div>
					</li>
					<c:if test="${isLogined == false}">
						<li>
							<a href="/usr/member/login?redirectUri=${encodedAfterLoginUri}">로그인</a>
						</li>
						<li>
							<a href="/usr/member/findLoginInfo">아이디/비번 찾기</a>
						</li>
						<li>
							<a href="/usr/member/join">회원가입</a>
						</li>
					</c:if>
					<c:if test="${isLogined}">
						<li>
							<span>${loginedMember.name}</span>
							<a class="ml-8" href="/usr/member/doLogout">로그아웃</a>
						</li>
						<li>
							<a href="/usr/home/showCommonMyPage">마이페이지</a>
						</li>
						<li>
							<a
								href="/usr/member/checkPassword?redirectUri=${Util.getUriEncoded('/usr/member/modify')}">내
								정보수정</a>
						</li>
					</c:if>
				</ul>
			</nav>
		</div>

		<c:if test="${pageTitle != null && pageTitle.length() != 0}">
			<h1 class="page-title-box con">${pageTitle}</h1>
		</c:if>

		<div id="applyment-notification-modal"
			class="modal-background-no-bg pt-8 items-center hidden" data-display-status="-1">
			<div id="applyment-notification" class="modal-content-no-bg absolute top-10 right-16 bg-white z-20 rounded-lg"></div>
		</div>
		
<script>

$(function() {
	if(loginedMemberId > 0 && loginedMemberId && loginedMemberId != null ){
		notifyUserOfApplymentResult();
		setInterval(function() { notifyUserOfApplymentResult()}, 30000);
	}
});
	
	function showNotificationModal(){
		
		if($('#applyment-notification').children().length > 0){
			if($('#applyment-notification-modal').data("displayStatus") == "-1"){
				$('#applyment-notification-modal').css("display", "flex");
				$('#applyment-notification-modal').data("displayStatus","1");
			}else{
				$('#applyment-notification-modal').css("display", "none");
				$('#applyment-notification-modal').data("displayStatus","-1");
			}	
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
			
			if(data && data.body && data.body.notifications){
				let notifications = data.body.notifications;
				let notificationsSize = 0;
				
				if(data.body.notificationsSize != 0){
					
					notificationsSize = data.body.notificationsSize;
					
					let html = '<div class="p-4">';
					
					$.each( notifications, function(index, notification){
						
						html += '<div>';
						html += '<a href="javascript:changeAlarmStatus('+ notification.id + ',' + notification.relId + ',\'' + notification.relName + '\',' + notification.extraId + ')" >'+ notification.relName + '에 대한 지원결과알림</a>';
						html += '</div>';
					});
					
					html += '</div>';
			
					$("#alarm-count").html(notificationsSize);
					$("#alarm-count").css({"display" : "flex"});
					
					$("#applyment-notification").html(html);
				}else{
					$('#alarm').attr("style","");
				}
				
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