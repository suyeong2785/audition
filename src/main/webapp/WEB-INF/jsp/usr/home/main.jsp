<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<!-- rollingBanner -->
<div class="con">
	<div class="swiper-container rollingBanner mx-auto max-h-96">
		<div class="swiper-wrapper ">
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
	<div class="mx-auto max-height-360">
		<div class="swiper-container castingCall ">
			<div class="swiper-wrapper max-height-360">
				<c:forEach items="${artworks}" var="artwork">
					<div class="swiper-slide relative">
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
								<a href="../../adm/actingRole/${artwork.getDetailLink()}">
									<div
										class="relative castingCall-image bg-no-repeat bg-center object-scale-down overflow-hidden padding-bottom-50 top-0 left-0 rounded-xl">
										<img class="absolute top-0 left-0 w-full h-full" src="${artwork.forPrintGenUrlForArtwork}" alt="" />
									</div>
								</a>
							</c:when>
							<c:when
								test="${artwork.forPrintGenUrlForArtwork == null || artwork.forPrintGenUrlForArtwork == ''}">
								<a href="../../adm/actingRole/${artwork.getDetailLink()}">
									<div
										class="${bgColor} text-white rounded-xl padding-bottom-50 top-0 left-0 relative">
										<span
											class="absolute text-4xl top-2/4 left-2/4 transform -translate-x-1/2 -translate-y-1/2 capitalize">${artwork.genre}</span>
									</div>
								</a>
							</c:when>
						</c:choose>
						<a href="../../adm/actingRole/${artwork.getDetailLink()}">
							<div>
								<div class="text-sm text-left font-bold py-2">${artwork.name}</div>
								<div class="text-xs text-left h-8 overflow-hidden line-clamp-2">${artwork.etc}</div>
								<div class="text-xs text-left">${fn:split(artwork.startDate,' ')[0]} ~
									${fn:split(artwork.endDate,' ')[0]}</div>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>
			<div class="swiper-pagination"></div>
		</div>
	</div>

	<h1 class="font-bold text-xl py-4 pl-4">Auditions</h1>
	<!-- Swiper -->
	<div class="mx-auto max-height-360 mb-4">
		<div class="swiper-container castingCall ">
			<div class="swiper-wrapper max-height-360">
				<c:forEach items="${actingRoles}" var="actingRole">
					<div class="swiper-slide relative">
						<c:choose>
							<c:when
								test="${actingRole.files != '[]'}">
								<a href="../../adm/actingRole/${actingRole.getDetailLink()}">
									<div
										class="relative castingCall-image bg-no-repeat bg-center object-scale-down overflow-hidden padding-bottom-50 top-0 left-0 rounded-xl">
										<img class="absolute top-0 left-0 w-full h-full" src="${actingRole.files[0].forPrintGenUrl}" alt="" />
									</div>
								</a>
							</c:when>
							<c:when
								 test="${actingRole.files == '[]'}">
								<a href="../../adm/actingRole/${actingRole.getDetailLink()}">
									<div
										class="bg-gray-400 text-white rounded-xl padding-bottom-50 top-0 left-0 relative">
										<span
											class="absolute text-4xl top-2/4 left-2/4 transform -translate-x-1/2 -translate-y-1/2 capitalize">${actingRole.name}</span>
									</div>
								</a>
							</c:when>
						</c:choose>
						<a href="../../adm/actingRole/${actingRole.getDetailLink()}">
							<div>
								<div class="text-sm text-left font-bold py-2">${actingRole.name}</div>
								<div class="text-xs text-left h-8 overflow-hidden line-clamp-2">${actingRole.feature}</div>
								<div class="text-xs text-left">${fn:split(actingRole.startDate,' ')[0]} ~ ${fn:split(actingRole.endDate,' ')[0]}</div>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>
			<div class="swiper-pagination"></div>
		</div>
	</div>
</div>

<div class="news-box bg-gray-100 p-4 ">
	<div class="con">
		<h1 class="font-bold text-xl py-4">News</h1>
		<hr />
		<div
			class="text-sm overflow-ellipsis whitespace-nowrap overflow-hidden py-2">내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보</div>
		<hr />
		<div
			class="text-sm overflow-ellipsis whitespace-nowrap overflow-hidden py-2">내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보</div>
		<hr />
		<div
			class="text-sm overflow-ellipsis whitespace-nowrap overflow-hidden py-2">내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보</div>
		<hr />
		<div
			class="text-sm overflow-ellipsis whitespace-nowrap overflow-hidden py-2">내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보</div>
		<hr />
		<div
			class="text-sm overflow-ellipsis whitespace-nowrap overflow-hidden py-2">내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보내용정보</div>
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
		mousewheel : true,
		autoHeight : true,
		slidesOffsetBefore : 10,
		breakpoints : {
			// when window width is >= 320px
			320 : {
				slidesPerView : 2,
				spaceBetween : 10
			},
			// when window width is >= 480px
			480 : {
				slidesPerView : 3,
				spaceBetween : 20
			},
			// when window width is >= 640px
			640 : {
				slidesPerView : 4,
				spaceBetween : 30
			}
		}
	});

	var swiper = new Swiper(".auditions", {
		slidesPerView : 3,
		mousewheel : true,
		breakpoints : {
			// when window width is >= 320px
			320 : {
				slidesPerView : 2,
				spaceBetween : 10
			},
			// when window width is >= 480px
			480 : {
				slidesPerView : 3,
				spaceBetween : 20
			},
			// when window width is >= 640px
			640 : {
				slidesPerView : 4,
				spaceBetween : 30
			}
		}
	});
</script>

<%@ include file="../part/foot.jspf"%>