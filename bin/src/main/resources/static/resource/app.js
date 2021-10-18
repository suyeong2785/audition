// 오직 이 프로그램에서만 사용되는 자바스크립트
var $html = $('html');

function MobileTopBar__init() {
	$('.mobile-top-bar .btn-toggle-mobile-side-bar').click(function() {
		$html.toggleClass('mobile-side-bar-actived');
	});
}

$(function() {
	MobileTopBar__init();
})

var nowLoading = false;

function startLoading() {
	nowLoading = true;

	$html.addClass('loading-box-actived');
}

function endLoading() {
	nowLoading = false;

	$html.removeClass('loading-box-actived');
}

function isNowLoading() {
	return nowLoading;
}

// 아이폰 용 끄기
// 1) Pinch Zoom 끄기
document.documentElement.addEventListener('touchstart', function(event) {
	if (event.touches.length > 1) {
		event.preventDefault();
	}
}, false);

// 아이폰 용 끄기
// Double tab Zoom 끄기
var lastTouchEnd = 0;
document.documentElement.addEventListener('touchend', function(event) {
	var now = (new Date()).getTime();
	if (now - lastTouchEnd <= 300) {
		event.preventDefault();
	}
	lastTouchEnd = now;
}, false);

//alert대신 사용할 toastr api
function setPositionOfToastr(targetType, targetName, msg) {

	toastr.options = {
		closeButton: true,
		showMethod: 'slideDown',
		timeOut: 2000,
		extendedTimeOut: 1,
		positionClass: "toast-top-center"
	};
	
	var loginIdCoordinate = null;

	if (targetType == "input" || targetType == "select" || targetType == "textarea") {
		loginIdCoordinate = $(targetType + '[name=' + targetName + ']').offset();
	} else if(targetType == "class"){
		loginIdCoordinate = $( '.' + targetName).offset();
	
	} else if(targetType == "id"){
		loginIdCoordinate = $( '#' + targetName).offset();
	}

	toastr.options.onShown = function() {

		$('.toast').addClass(targetName);
		$('#toast-container').css("display", "block");
		$('.toast').css({ "display": "block", "position": "absolute" });
		var height = loginIdCoordinate.top - $("." + targetName).outerHeight();
		$("." + targetName).offset({ left: loginIdCoordinate.left, top: height });

	}

	toastr.warning(msg);

}
