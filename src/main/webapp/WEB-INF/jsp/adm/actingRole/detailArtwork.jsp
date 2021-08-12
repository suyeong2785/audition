<%@ page import="com.quantom.audition.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<div class="con">
	<div class=" flex flex-col">
		<div class="flex items-center justify-center max-h-96 overflow-hidden">
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
					<img src="${artwork.forPrintGenUrlForArtwork}" alt="" />
				</c:when>
				<c:when
					test="${artwork.forPrintGenUrlForArtwork == null || artwork.forPrintGenUrlForArtwork == ''}">
					<div class="${bgColor} text-white h-44 md:h-96 flex-grow text-7xl md:text-9xl flex justify-center items-center">${artwork.genre}</div>
				</c:when>

			</c:choose>
		</div>
		<div class="p-6">
			<div>
				<span>번호</span>
				<span>${artwork.id}</span>
			</div>
			<div>
				<span>등록날짜</span>
				<span>${artwork.regDate}</span>
			</div>
			<div>
				<span>작품이름</span>
				<span>${artwork.name}</span>
			</div>
			<div>
				<span>장르</span>
				<span>${artwork.genre}</span>
			</div>
			<div>
				<span>투자사</span>
				<span>${artwork.investor}</span>
			</div>
			<div>
				<span>제작사</span>
				<span>${artwork.productionName}</span>
			</div>
			<div>
				<span>주연</span>
				<span>${artwork.leadActor}</span>
			</div>

			<div>
				<span>감독</span>
				<span>${artwork.directorName}</span>
			</div>

			<div class="pt-4 text-sm">
				<span>모집기간</span>
				<span>${artwork.startDate} ~ ${artwork.endDate}</span>
			</div>

		</div>
	</div>
</div>
<div class="bg-gray-100">
	<div class="con p-6">
		<span>줄거리</span>
		<span class="text-sm">${artwork.etc}</span>
	</div>
</div>


<div class="btn-box con margin-top-20">
	<a class="btn btn-info"
		href="modifyArtwork?id=${artwork.id}&listUrl=${Util.getUriEncoded(listUrl)}">수정</a>
	<a class="btn btn-danger"
		href="doDeleteArtwork?id=${artwork.id}&listUrl=${Util.getUriEncoded(listUrl)}"
		onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;">삭제</a>

	<a href="${listUrl}" class="btn btn-info">목록</a>
</div>


<%@ include file="../part/foot.jspf"%>