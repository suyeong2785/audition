<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>
<!-- PC용 -->
<div class="grid justify-center grid-column-auto-800 p-4 gap-y-4">
	<div class="flex justify-between">
		<div class="text-xl font-bold">Auditions</div>
		<c:if test="${actorCanWrite}">
			<div>
				<a
					class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
					href="../../adm/actingRole/write">
					<i class="fas fa-plus"></i>
					<span>신규모집</span>
				</a>
			</div>
		</c:if>
		<div>
			<a href="#" class="flex items-center justify-center">
				<img src="/resource/img/sort_icon.svg" alt="" />
				<span>정렬</span>
			</a>
		</div>
	</div>
	<c:choose>
		<c:when test="${artworks != null && artworks != ''}">
			<c:forEach items="${artworks}" var="artwork">
				<div
					class="grid grid-columns-artworkList grid-row-artworkList gap-x-2.5 bg-gray-100 place-content-stretch">
					<a href="${artwork.getDetailLink()}">
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
								<div class="relative bg-gray-300 padding-bottom-50">
									<img class="absolute top-0 left-0 text-white w-full h-full flex justify-center items-center" src="${artwork.forPrintGenUrlForArtwork}" alt="" />
								</div>
							</c:when>
							<c:when
								test="${artwork.forPrintGenUrlForArtwork == null || artwork.forPrintGenUrlForArtwork == ''}">
								<div class="relative ${bgColor} padding-bottom-50">
									<div
										class="absolute top-0 left-0 text-white w-full h-full rounded-xl flex justify-center items-center">${artwork.genre}</div>
								</div>
							</c:when>
						</c:choose>
					</a>
					<div class="grid content-between">
						<a class="font-bold overflow-hidden line-clamp-1"
							href="${artwork.getDetailLink()}" class="block">${artwork.name}</a>
						<a href="${artwork.getDetailLink()}"
							class=" text-xs text-left overflow-ellipsis overflow-hidden line-clamp-6">장르
							: ${artwork.genre}</a>
						<a href="${artwork.getDetailLink()}"
							class=" text-xs text-left overflow-ellipsis overflow-hidden line-clamp-6">주연
							: ${artwork.leadActor}</a>
						<a href="${artwork.getDetailLink()}"
							class=" text-xs 
							text-left overflow-ellipsis overflow-hidden
							line-clamp-6">제작사
							: ${artwork.productionName}</a>
						<a href="${artwork.getDetailLink()}"
							class=" text-xs text-left overflow-ellipsis overflow-hidden line-clamp-1">줄거리
							: ${artwork.etc}</a>
						<a href="${artwork.getDetailLink()}" class="text-xs text-left">모집기간
							: ${fn:split(artwork.startDate,' ')[0]} ~
							${fn:split(artwork.endDate,' ')[0]}</a>
					</div>
				</div>
			</c:forEach>
		</c:when>
		<c:when test="${artworks == null || artworks == ''}">
			<div
				class="flex justify-center items-center py-4 flex-grow padding-bottom-25s">
				<div class="">배역모집없음</div>
			</div>
		</c:when>
	</c:choose>
</div>
<%@ include file="../part/foot.jspf"%>