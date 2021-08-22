<%@ page import="com.quantom.audition.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<div class="con">
	<div class=" flex flex-col">
		<div class="max-height-360 relative overflow-hidden">
			<div class="padding-bottom-50">
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
						<img
							class="absolute top-2/4 left-2/4 transform -translate-x-1/2 -translate-y-1/2 h-full"
							src="${artwork.forPrintGenUrlForArtwork}" alt="" />
					</c:when>
					<c:when
						test="${artwork.forPrintGenUrlForArtwork == null || artwork.forPrintGenUrlForArtwork == ''}">
						<div
							class="flex justify-center items-center absolute text-7xl h-full w-full ${bgColor} text-white top-2/4 left-2/4 transform -translate-x-1/2 -translate-y-1/2 capitalize">${artwork.genre}</div>
					</c:when>

				</c:choose>
			</div>
		</div>
		<div class="p-6">
			<div class="flex">
				<div class="min-width-96">번호</div>
				<div>${artwork.id}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">등록날짜</div>
				<div>${artwork.regDate}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">작품이름</div>
				<div>${artwork.name}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">장르</div>
				<div>${artwork.genre}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">투자사</div>
				<div>${artwork.investor}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">제작사</div>
				<div>${artwork.productionName}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">주연</div>
				<div>${artwork.leadActor}</div>
			</div>

			<div class="flex">
				<div class="min-width-96">감독</div>
				<div>${artwork.directorName}</div>
			</div>

			<div class="flex">
				<div class="min-width-96">모집배역</div>
				<div>
					<c:forEach var="i" begin="0"
						end="${fn:length(actingRoles)-1 > 0 ? fn:length(actingRoles)-1 : 0}">
						<div>
							<span>${actingRoles[i]}</span>
							<span>${actingGenders[i]}</span>
							<span>${actingAges[i]}</span>
						</div>
					</c:forEach>
				</div>
			</div>

			<div class="flex">
				<div class="min-width-96">모집기간</div>
				<div>${artwork.startDate}~${artwork.endDate}</div>
			</div>

		</div>
	</div>
</div>
<div class="bg-gray-100 ">
	<div class="con p-6">
		<div class="flex">
			<div class="min-width-96">줄거리</div>
			<div class="text-sm">${artwork.etc}</div>
		</div>
	</div>
</div>


<div class="btn-box con margin-top-20">
	<c:if test="${isAdmin == true || loginedMemberId == artwork.extra.writerId}">
		<a class="btn btn-info"
			href="modifyArtwork?id=${artwork.id}&listUrl=${Util.getUriEncoded(listUrl)}">수정</a>
		<a class="btn btn-danger"
			href="doDeleteArtwork?id=${artwork.id}&listUrl=${Util.getUriEncoded(listUrl)}"
			onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;">삭제</a>
	</c:if>
	<a href="${listUrl}" class="btn btn-info">목록</a>
</div>

<%@ include file="../part/foot.jspf"%>