<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<!-- rollingBanner -->
<div class="h-full con my-8">
	<div class="swiper-container rollingBanner w-full h-full mx-auto">
		<div class="swiper-wrapper">
			<div class="swiper-slide flex items-center justify-center">
				<img src="/resource/img/banner1.jpg" alt="" />
			</div>
			<div class="swiper-slide flex items-center justify-center">
				<img src="/resource/img/banner2.jpg" alt="" />
			</div>
			<div class="swiper-slide flex items-center justify-center">
				<img src="/resource/img/banner3.jpg" alt="" />
			</div>
		</div>
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
		<div class="swiper-pagination"></div>
	</div>

	<h1 class="font-bold text-xl py-4 pl-4">Casting Call</h1>
	<!-- Swiper -->
	<div class="swiper-container castingCall mx-auto max-height-360">
		<div class="swiper-wrapper">
			<div class="swiper-slide flex-col ">
				<img class="min-width-120" src="/resource/img/castingCall_1.png"
					alt="" />
				<span class="text-sm">영화내용</span>
			</div>
			<div class="swiper-slide flex-col">
				<img class="min-width-120" src="/resource/img/castingCall_2.png"
					alt="" />
				<span class="text-sm">영화내용</span>
			</div>
			<div class="swiper-slide flex-col">
				<img class="min-width-120" src="/resource/img/castingCall_3.png"
					alt="" />
				<span class="text-sm">영화내용</span>
			</div>
			<div class="swiper-slide flex-col">
				<img class="min-width-120" src="/resource/img/castingCall_4.png"
					alt="" />
				<span class="text-sm">영화내용</span>
			</div>
			<div class="swiper-slide flex-col ">
				<img class="min-width-120" src="/resource/img/castingCall_5.png"
					alt="" />
				<span class="text-sm">영화내용</span>
			</div>
		</div>
		<div class="swiper-pagination"></div>
	</div>

	<h1 class="font-bold text-xl py-4 pl-4">Auditions</h1>
	<!-- Swiper -->
	<div class="swiper-container auditions mx-auto max-height-360">
		<div class="swiper-wrapper">
			<div class="swiper-slide flex-col ">
				<img class="min-width-120" src="/resource/img/auditions_1.png"
					alt="" />
				<span class="text-sm">영화내용</span>
			</div>
			<div class="swiper-slide flex-col">
				<img class="min-width-120" src="/resource/img/auditions_2.png"
					alt="" />
				<span class="text-sm">영화내용</span>
			</div>
			<div class="swiper-slide flex-col">
				<img class="min-width-120" src="/resource/img/auditions_3.png"
					alt="" />
				<span class="text-sm">영화내용</span>
			</div>
			<div class="swiper-slide flex-col">
				<img class="min-width-120" src="/resource/img/auditions_4.png"
					alt="" />
				<span class="text-sm">영화내용</span>
			</div>
			<div class="swiper-slide flex-col ">
				<img class="min-width-120" src="/resource/img/auditions_5.png"
					alt="" />
				<span class="text-sm">영화내용</span>
			</div>
		</div>
		<div class="swiper-pagination"></div>
	</div>
</div>

<div class="news-box bg-gray-100 p-4 ">
	<div class="con">
	<h1 class="font-bold text-xl py-4">News</h1>
	<hr />
	<div class="overflow-ellipsis whitespace-nowrap overflow-hidden py-2">내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보</div>
	<hr />
	<div class="overflow-ellipsis whitespace-nowrap overflow-hidden py-2">내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보</div>
	<hr />
	<div class="overflow-ellipsis whitespace-nowrap overflow-hidden py-2">내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보</div>
	<hr />
	<div class="overflow-ellipsis whitespace-nowrap overflow-hidden py-2">내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보</div>
	<hr />
	<div class="overflow-ellipsis whitespace-nowrap overflow-hidden py-2">내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보</div>
	<hr />
	</div>
</div>

<!-- Initialize Swiper -->
<script>
	var rollingBanner = new Swiper(".rollingBanner", {
		slidesPerView : 1,
		loop : true,
		mousewheel : true,
		autoplay : {
			delay : 2500,
			disableOnInteraction : false,
		},
		pagination : {
			el : ".swiper-pagination",
			clickable : true,
		},
		navigation : {
			nextEl : ".swiper-button-next",
			prevEl : ".swiper-button-prev",
		},
	});

	var swiper = new Swiper(".castingCall", {
		slidesPerView : 3,
		spaceBetween : 30,
		mousewheel : true,
	});

	var swiper = new Swiper(".auditions", {
		slidesPerView : 3,
		spaceBetween : 30,
		mousewheel : true,
	});
</script>

<%@ include file="../part/foot.jspf"%>