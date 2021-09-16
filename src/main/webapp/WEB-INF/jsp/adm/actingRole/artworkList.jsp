<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../../usr/part/head.jspf"%>

<div class="grid justify-center grid-column-auto-800 mx-4 ">
	<div class="flex justify-between">
		<div class="flex justify-center items-center flex-4">
			<div class="text-center py-8 text-xl font-bold">진행중인 캐스팅</div>
			<div class="flex-grow"></div>
			<div class="flex items-center justify-center">
				<a
					class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
					href="./writeArtwork">
					<i class="fas fa-plus"></i>
					<span>Add</span>
				</a>
			</div>
		</div>
	</div>
	<c:forEach items="${artworks}" var="artwork">
		<div class="relative flex flex-col mt-4 ">
			<div
				class="z-20 grid grid-columns-adm-artworkList grid-row-adm-artworkList gap-x-2.5 bg-gray-100 place-content-stretch bg-gray-200 rounded-full place-content-stretch">
				<a href="../../usr/actingRole/${artwork.getDetailLink()}">
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
							<div class="relative padding-bottom-50 overlow-hidden">
								<img
									class="absolute top-0 left-0 text-white w-full h-full flex justify-center items-center rounded-full"
									src="${artwork.forPrintGenUrlForArtwork}" alt="" />
							</div>
						</c:when>
						<c:when
							test="${artwork.forPrintGenUrlForArtwork == null || artwork.forPrintGenUrlForArtwork == ''}">
							<div class="relative padding-bottom-50 overlow-hidden">
								<div
									class="${bgColor} absolute top-0 left-0 text-white w-full h-full rounded-full flex justify-center items-center">${artwork.genre}</div>
							</div>
						</c:when>
					</c:choose>
				</a>

				<div class="grid items-center">
					<div class="overflow-ellipsis overflow-hidden whitespace-nowrap ">
						<a href="../../usr/actingRole/${artwork.getDetailLink()}">${artwork.title}</a>
					</div>
					<div class="flex items-start">
						<a href="modifyArtwork?id=${artwork.id}">
							<div
								class="py-1 bg-gray-500 hover:bg-gray-700 text-white text-sm rounded-full px-4">내용수정</div>
						</a>
					</div>
				</div>
				<div class="flex items-center p-3">
					<c:choose>
						<c:when
							test="${artwork.forPrintGenUrlForMember != null && artwork.forPrintGenUrlForMember != ''}">
							<div class="relative padding-bottom-50 overlow-hidden">
								<img
									class="absolute top-0 left-0 text-white w-full h-full flex justify-center items-center rounded-full"
									src="${artwork.forPrintGenUrlForMember}" alt="" />
							</div>
						</c:when>
						<c:when
							test="${artwork.forPrintGenUrlForMember == null || artwork.forPrintGenUrlForMember == ''}">
							<div
								class="flex justify-center items-center w-14 h-14 mr-2 text-5xl text-gray-600">
								<i class="fas fa-user-circle"></i>
							</div>
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>
	</c:forEach>
</div>
<%@ include file="../part/foot.jspf"%>