<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jsp"%>

<div class="con flex-col ">
	<div class="flex items-center justify-center">
		<div class="flex-grow"></div>
		<div class="flex justify-center items-center max-w-screen-sm flex-4">
			<div class="text-center py-8 text-xl font-bold">adm Audtions</div>
			<div class="flex-grow"></div>
			<div class="flex items-center justify-center">
				<a
					class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
					href="./write">
					<i class="fas fa-plus"></i>
					<span>Add</span>
				</a>
			</div>
		</div>
		<div class="flex-grow"></div>
	</div>
	<c:forEach items="${actingRoles}" var="actingRole">
		<div class="flex justify-center mb-4 ">
			<div class="flex-grow"></div>
			<div
				class="bg-gray-200 h-20 py-4 max-w-screen-sm rounded-full flex items-center justify-center flex-4">
				<a href="${actingRole.getDetailLink()}">
					<c:if
						test="${actingRole.files != '[]'}">
						<img class="object-cover w-20 h-20 rounded-full"
							src="${actingRole.files[0].forPrintGenUrl}" alt="" />
					</c:if>
					<c:if test="${actingRole.files == '[]'}">
						<div
							class="bg-gray-400 text-white object-cover w-20 h-20 rounded-full flex justify-center items-center">${actingRole.name}</div>
					</c:if>
				</a>
				<a href="${actingRole.getDetailLink()}">
					<div class="px-4">
						<div>영화제목 :${actingRole.extra.artworkName}</div>
						<div class="title flex-1-0-0 text-overflow-el">배역 :
							${actingRole.name}</div>
						<!-- <div class="writer">모집기간 : ${fn:split(actingRole.startDate,' ')[0]} ~ ${fn:split(actingRole.endDate,' ')[0]}</div>-->
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
							test="${actingRole.forPrintGenUrlForMember != null && actingRole.forPrintGenUrlForMember != ''}">
							<img class="inline object-cover w-14 h-14 mr-2 rounded-full"
								src="${actingRole.forPrintGenUrlForMember}" alt="" />
						</c:when>
						<c:when
							test="${actingRole.forPrintGenUrlForMember == null || actingRole.forPrintGenUrlForMember == ''}">
							<div
								class="flex justify-center items-center w-14 h-14 mr-2 text-5xl text-gray-600">
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
<%@ include file="../part/foot.jsp"%>