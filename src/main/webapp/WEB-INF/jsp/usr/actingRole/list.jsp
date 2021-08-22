<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>
<!-- PC용 -->
<div class="grid justify-center grid-column-auto-800 p-4 gap-y-4">
	<div class="flex justify-between">
		<div class="text-xl font-bold">usr Auditions</div>
		<c:if test="${isAdmin == true || isCastingDirector == true}">
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
		<c:when test="${actingRoles != null && actingRoles != ''}">
			<c:forEach items="${actingRoles}" var="actingRole">
				<div
					class="grid grid-columns-1fr-2fr grid-row-140-160 gap-x-2.5 bg-gray-100 place-content-stretch">
					<a href="${actingRole.getDetailLink()}">
						<c:if test="${actingRole.files != '[]'}">
							<img class="bg-gray-200" src="${actingRole.files[0].forPrintGenUrl}" alt="" />
						</c:if>
						<c:if test="${actingRole.files == '[]'}">
							<div class="relative bg-gray-400 padding-bottom-50">
								<div
									class="absolute top-0 left-0 text-white w-full h-full rounded-xl flex justify-center items-center">${actingRole.name}</div>
							</div>
						</c:if>
					</a>
					<div class="grid content-between">
						<a class="font-bold overflow-hidden line-clamp-1"
							href="${actingRole.getDetailLink()}" class="block">${actingRole.extra.artworkName}</a>
						<a href="${actingRole.getDetailLink()}"
							class=" text-xs text-left overflow-ellipsis overflow-hidden line-clamp-6">배역명
							: ${actingRole.name}</a>
						<a href="${actingRole.getDetailLink()}"
							class=" text-xs text-left overflow-ellipsis overflow-hidden line-clamp-6">성별
							: ${actingRole.gender}</a>
						<a href="${actingRole.getDetailLink()}"
							class=" text-xs 
							text-left overflow-ellipsis overflow-hidden
							line-clamp-6">배역나이
							: ${actingRole.age}</a>
						<a href="${actingRole.getDetailLink()}"
							class=" text-xs text-left overflow-ellipsis overflow-hidden line-clamp-6">급여
							: ${actingRole.pay}</a>
						<a href="${actingRole.getDetailLink()}" class="text-xs text-left">모집기간
							: ${fn:split(actingRole.startDate,' ')[0]} ~
							${fn:split(actingRole.endDate,' ')[0]}</a>
					</div>
				</div>
			</c:forEach>
		</c:when>
		<c:when test="${actingRoles == null || actingRoles == ''}">
			<div
				class="flex justify-center items-center py-4 flex-grow padding-bottom-25s">
				<div class="">배역모집없음</div>
			</div>
		</c:when>
	</c:choose>
</div>
<%@ include file="../part/foot.jspf"%>