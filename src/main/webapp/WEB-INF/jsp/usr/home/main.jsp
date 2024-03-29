<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jsp"%>

<!-- rollingBanner -->
<div class="con overflow-hidden">
	<div class="header w-full banner-height max-h-96 ">
		<div class="swiper-container rollingBanner mx-auto h-full relative ">
			<!-- 
			<div
				class="absolute bottom-0 right-0 padding-banner-uppper-font-left text-4xl font-banner text-white z-10">FREE</div>
			<div
				class="absolute opacity-50 bottom-0 right-0 padding-banner-uppper-font-right text-4xl font-banner text-white z-10">&</div>
			<div
				class="absolute bottom-0 right-0 padding-banner-font text-4xl font-banner text-white z-10">PRIVATE</div>
				 -->
			<div class="swiper-wrapper ">
				<div class="swiper-slide castingCall-image h-full ">
					<img class="mx-auto h-full" src="/resource/img/banner1.jpg" alt="" />
				</div>
				<div class="swiper-slide relative castingCall-image h-full">
					<img class=" mx-auto h-full" src="/resource/img/banner2.jpg" alt="" />
				</div>
				<div class="swiper-slide relative castingCall-image h-full">
					<img class=" mx-auto h-full" src="/resource/img/banner3.jpg" alt="" />
				</div>
				<div class="swiper-slide relative castingCall-image h-full">
					<img class=" mx-auto h-full" src="/resource/img/banner5.png" alt="" />
				</div>
				<div class="swiper-slide relative castingCall-image h-full">
					<img class=" mx-auto h-full" src="/resource/img/banner11.jpg"
						alt="" />
				</div>
				<div class="swiper-slide relative castingCall-image h-full">
					<img class=" mx-auto h-full" src="/resource/img/banner12.jpg"
						alt="" />
				</div>
				<div class="swiper-slide relative castingCall-image h-full">
					<img class=" mx-auto h-full" src="/resource/img/banner13.jpg"
						alt="" />
				</div>
				<div class="swiper-slide relative castingCall-image h-full">
					<img class=" mx-auto h-full" src="/resource/img/banner14.png"
						alt="" />
				</div>

			</div>
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
			<div class="swiper-pagination"></div>
		</div>
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
								<a href="../../usr/actingRole/${artwork.getDetailLink()}">
									<div
										class="relative castingCall-image padding-bottom-50 top-0 left-0 rounded-xl">
										<img class="absolute top-0 left-0 w-full h-full rounded-xl"
											src="${artwork.forPrintGenUrlForArtwork}" alt="" />
									</div>
								</a>
							</c:when>
							<c:when
								test="${artwork.forPrintGenUrlForArtwork == null || artwork.forPrintGenUrlForArtwork == ''}">
								<a href="../../usr/actingRole/${artwork.getDetailLink()}">
									<div
										class="${bgColor} text-white rounded-xl padding-bottom-50 top-0 left-0 relative">
										<span
											class="absolute font-catingCall top-2/4 left-2/4 transform -translate-x-1/2 -translate-y-1/2 capitalize">${artwork.genre}</span>
									</div>
								</a>
							</c:when>
						</c:choose>
						<a href="../../usr/actingRole/${artwork.getDetailLink()}">
							<div>
								<div
									class="text-sm text-left font-bold py-2 overflow-ellipsis overflow-hidden whitespace-nowrap ">${artwork.title}</div>
								<div class="text-xs text-left h-8 overflow-hidden line-clamp-2">${artwork.etc}</div>
								<div class="text-xs text-left">${fn:split(artwork.startDate,' ')[0]}
									~ ${fn:split(artwork.endDate,' ')[0]}</div>
							</div>
						</a>
					</div>
				</c:forEach>
				<div class="swiper-slide relative">
					<a href="../../usr/actingRole/artworkList">
						<div
							class="relative castingCall-image padding-bottom-50 top-0 left-0 rounded-xl">
							<img class="absolute top-0 left-0 w-full h-full rounded-xl"
								src="/resource/img/castingCall_5.png" alt="" />
						</div>
					</a>
				</div>
			</div>
			<div class="swiper-pagination"></div>
		</div>
	</div>

	<h1 class="font-bold text-xl py-4 pl-4">Auditions</h1>
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
								<a
									href="../../usr/actingRole/${artwork.getDetailLinkForAuditions()}">
									<div
										class="relative castingCall-image padding-bottom-50 top-0 left-0 rounded-xl">
										<img class="absolute top-0 left-0 w-full h-full rounded-xl"
											src="${artwork.forPrintGenUrlForArtwork}" alt="" />
									</div>
								</a>
							</c:when>
							<c:when
								test="${artwork.forPrintGenUrlForArtwork == null || artwork.forPrintGenUrlForArtwork == ''}">
								<a
									href="../../usr/actingRole/${artwork.getDetailLinkForAuditions()}">
									<div
										class="${bgColor} text-white rounded-xl padding-bottom-50 top-0 left-0 relative">
										<span
											class="absolute font-catingCall top-2/4 left-2/4 transform -translate-x-1/2 -translate-y-1/2 capitalize">${artwork.genre}</span>
									</div>
								</a>
							</c:when>
						</c:choose>
						<a
							href="../../usr/actingRole/${artwork.getDetailLinkForAuditions()}">
							<div>
								<div
									class="text-sm text-left font-bold py-2 overflow-ellipsis overflow-hidden whitespace-nowrap ">${artwork.title}</div>
								<div class="text-xs text-left h-8 overflow-hidden line-clamp-2">${artwork.etc}</div>
								<div class="text-xs text-left">${fn:split(artwork.startDate,' ')[0]}
									~ ${fn:split(artwork.endDate,' ')[0]}</div>
							</div>
						</a>
					</div>
				</c:forEach>
				<div class="swiper-slide relative">
					<a href="../../usr/actingRole/artworkListForAuditions">
						<div
							class="relative castingCall-image padding-bottom-50 top-0 left-0 rounded-xl">
							<img class="absolute top-0 left-0 w-full h-full rounded-xl"
								src="/resource/img/auditions_5.png" alt="" />
						</div>
					</a>
				</div>
			</div>
			<div class="swiper-pagination"></div>
		</div>
	</div>
</div>

<div class="news-box bg-gray-100 p-4 mt-8">
	<div class="con">
		<h1 class="font-bold text-xl py-4">News</h1>
		<hr />
		<div
			class="text-sm overflow-ellipsis whitespace-nowrap overflow-hidden py-2">
			<a
				href="https://sports.chosun.com/news/ntype.htm?id=202108270100203960013161&servicedate=20210827 
				">[공식]
				김새론·정다은·서은영·이하영 '그녀들' 출연 확정</a>
		</div>
		<hr />
		<div
			class="text-sm overflow-ellipsis whitespace-nowrap overflow-hidden py-2">
			<a href="https://kstar.kbs.co.kr/list_view.html?idx=157393">배우
				애주, '더 맨션' 정씨 역 출연 확정!</a>
		</div>
		<hr />
		<div
			class="text-sm overflow-ellipsis whitespace-nowrap overflow-hidden py-2">
			<a
				href="http://www.spotvnews.co.kr//?mod=news&act=articleView&idxno=438937">[단독]500억
				대작 '무빙', 23일 크랭크인…한국형 판타지 히어로물</a>
		</div>
		<hr />
		<div
			class="text-sm overflow-ellipsis whitespace-nowrap overflow-hidden py-2">
			<a
				href="https://www.mcst.go.kr/kor/s_notice/notice/noticeView.jsp?pSeq=15279">공연예술분야
				인력지원 사업 공고</a>
		</div>
		<hr />
		<div
			class="text-sm overflow-ellipsis whitespace-nowrap overflow-hidden py-2">
			<a href="https://news.seoul.go.kr/culture/archives/513548">2021
				서울미래유산 역사사진 공모전 공고</a>
		</div>
		<hr />
	</div>
</div>

<!-- Initialize Swiper -->
<script>
	var rollingBanner = new Swiper(".rollingBanner", {
		slidesPerView : 1,
		loop : true,
		autoplay : {
			delay : 2500,
			disableOnInteraction : false
		},
		mousewheel : true,
		navigation : {
			nextEl : ".swiper-button-next",
			prevEl : ".swiper-button-prev",
		},
	});

	var swiper = new Swiper(".castingCall", {
		slidesPerView : 2,
		spaceBetween : 10,
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
		slidesPerView : 2,
		spaceBetween : 10,
		mousewheel : true,
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
</script>

<%@ include file="../part/foot.jsp"%>