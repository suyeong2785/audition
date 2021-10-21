<%@ page import="com.quantom.audition.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/head.jsp"%>

<div class="con">
	<div class=" flex flex-col">
		<div class="max-height-360 relative overflow-hidden">
			<div class="padding-bottom-50">
				<c:choose>
					<c:when test="${actingRole.files != '[]'}">
						<c:forEach items="${actingRole.files}" var="file">
							<c:choose>
								<c:when test="${file.typeCode == 'thumbnail'}">
									<img
										class="absolute top-2/4 left-2/4 transform -translate-x-1/2 -translate-y-1/2 h-full"
										src="${file.forPrintGenUrl}" alt="" />
								</c:when>
							</c:choose>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div
							class="flex justify-center items-center absolute text-7xl h-full w-full bg-gray-300 text-white top-2/4 left-2/4 transform -translate-x-1/2 -translate-y-1/2 capitalize">
							${actingRole.name}</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="p-6">
			<div class="flex">
				<div class="min-width-96">작품이름</div>
				<div>${actingRole.extra.artworkName}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">배역명</div>
				<div>${actingRole.name}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">연령/성별</div>
				<div>${actingRole.age}/${actingRole.gender}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">직업</div>
				<div>${actingRole.job}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">주요사항</div>
				<div>${actingRole.feature}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">촬영일정</div>
				<div>${actingRole.schedule}/${actingRole.shootingsCount}회</div>
			</div>
			<div class="flex">
				<div class="min-width-96">촬영지역</div>
				<div>${actingRole.region}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">출연료</div>
				<div>${actingRole.pay}</div>
			</div>
			<div class="flex">
				<div class="min-width-96">모집기간</div>
				<div>${fn:split(actingRole.startDate,' ')[0]}~
					${fn:split(actingRole.endDate,' ')[0]}</div>
			</div>
			<c:choose>
				<c:when test="${actingRole.files != '[]'}">
					<c:forEach items="${actingRole.files}" var="file">
						<c:choose>
							<c:when test="${file.typeCode == 'script'}">
								<div class="flex">
									<div class="min-width-96">지정연기 대본</div>
									<div>
										<a href="${file.forPrintGenUrl}" download>오디션 대본 다운로드</a>
									</div>
								</div>
							</c:when>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>

		</div>
	</div>
</div>

<c:choose>
	<c:when test="${actingRole.files != '[]'}">
		<c:forEach items="${actingRole.files}" var="file">
			<c:choose>
				<c:when test="${file.typeCode == 'guide'}">
					<div class="bg-gray-100 ">
						<div class="con p-6">
							<div class="flex">
								<div class="flex">
									<div class="min-width-96">오디션 가이드영상</div>
									<div>
										<video controls="controls" src="${file.forPrintGenUrl}"></video>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:when>
			</c:choose>
		</c:forEach>
	</c:when>
</c:choose>



<div class="btn-box con margin-top-20">
	<a class="btn btn-info"
		href="modify?id=${actingRole.id}&listUrl=${Util.getUriEncoded(listUrl)}">수정</a>
	<a class="btn btn-danger"
		href="doDelete?id=${actingRole.id}&listUrl=${Util.getUriEncoded(listUrl)}"
		onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;">삭제</a>

	<a href="${listUrl}" class="btn btn-info">목록</a>
</div>

<%@ include file="../part/foot.jsp"%>