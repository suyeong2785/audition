<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>
<div class="con flex-col ">
	<div class="flex items-center justify-center">
		<div class="flex-grow"></div>
		<div class="flex justify-center items-center max-w-screen-sm flex-4">
			<div class="text-center py-8 text-xl font-bold">Artwork List</div>
			<div class="flex-grow"></div>
			<div class="flex items-center justify-center">
				<a class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
					href="./writeArtwork">
					<i class="fas fa-plus"></i>
					<span>Add</span>
				</a>
			</div>
		</div>
		<div class="flex-grow"></div>
	</div>
	<c:forEach items="${artworks}" var="artwork">
		<div class="flex justify-center mb-4 ">
			<div class="flex-grow"></div>
			<div
				class="bg-gray-200 h-20 py-4 max-w-screen-sm rounded-full flex items-center justify-center flex-4">
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
							<img class="object-cover w-20 h-20 rounded-full"
								src="${artwork.forPrintGenUrlForArtwork}" alt="" />
						</c:when>
						<c:when
							test="${artwork.forPrintGenUrlForArtwork == null || artwork.forPrintGenUrlForArtwork == ''}">
							<div
								class="${bgColor} text-white object-cover w-20 h-20 rounded-full flex justify-center items-center">${artwork.genre}</div>
						</c:when>
					</c:choose>

				</a>
				<a href="${artwork.getDetailLink()}">
					<div class="px-4">
						<div class="title flex-1-0-0 text-overflow-el">${artwork.name}</div>
						<div class="writer">${artwork.extra.writer}</div>
						<div class="flex items-center">
							<div>지원자 : 000명</div>
							<div class="flex-grow"></div>
						</div>
					</div>
				</a>
				<div class="flex-grow"></div>
				<div>
					<c:choose>
						<c:when
							test="${artwork.forPrintGenUrlForMember != null && artwork.forPrintGenUrlForMember != ''}">
							<img class="inline object-cover w-14 h-14 mr-2 rounded-full"
								src="${artwork.forPrintGenUrlForMember}" alt="" />
						</c:when>
						<c:when
							test="${artwork.forPrintGenUrlForMember == null || artwork.forPrintGenUrlForMember == ''}">
							<div class="flex justify-center items-center w-14 h-14 mr-2 text-5xl text-gray-600">
								<i class="fas fa-user-circle"></i>
							</div>
						</c:when>
					</c:choose>
				</div>
			</div>
			<div class="flex-grow"></div>
		</div>
	</c:forEach>
</div>
<%@ include file="../part/foot.jspf"%>