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

// 경력박스확인 체크
var checkCareerBoxResult = function(form) {
	var dateNeedToStop = 0;
	let dates = $("input[name='careerDate']").each(function(index, item) {
		if ($.trim($(this).val()) != "" && $.trim($(this).val()) != null) {
			return true;
		}

		alert('경력날짜의 ' + (index + 1) + '번째 칸이 비어있습니다.');
		dateNeedToStop = 1;
		$(this).focus();
		return false;
	});

	if (dateNeedToStop == 1) {
		return -1;
	}

	var dateSize = dates.length;

	var artworkNeedToStop = 0;
	let artworks = $("input[name='careerArtwork']").each(
		function(index, item) {
			if ($.trim($(this).val()) != ""
				&& $.trim($(this).val()) != null) {
				return true;
			}

			alert('경력내용의 ' + (index + 1) + '번째 칸이 비어있습니다.');
			artworkNeedToStop = 1;
			$(this).focus();
			return false;
		});

	if (artworkNeedToStop == 1) {
		return -1;
	}

	dates = $("input[name='careerDate']").map(function(index, element) {
		if ($.trim($(this).val()) != "" && $.trim($(this).val()) != null) {
			return $.trim($(this).val());
		}
	}).get().join(",");

	artworks = $("input[name='careerArtwork']").map(
		function(index, element) {
			if ($.trim($(this).val()) != ""
				&& $.trim($(this).val()) != null) {
				return $.trim($(this).val());
			}
		}).get().join(",");

	form.careerDates.value = dates;
	form.careerArtworks.value = artworks;

	alert('form.careerDates.value : ' + form.careerDates.value);
	alert('form.careerArtworks.value : ' + form.careerArtworks.value);

}