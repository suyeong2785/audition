<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jsp"%>
<!-- PC용 -->
<div class="grid justify-center grid-column-auto-800 p-4 gap-y-4">
	<div class="flex justify-between">
		<div class="text-xl font-bold">Auditions</div>
		<c:if test="${actorCanWrite}">
			<div>
				<a
					class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
					href="./${job.code}-write">
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
		<c:when test="${recruitments != null && recruitments != ''}">
			<c:forEach items="${recruitments}" var="recruitment">
				<div class="grid grid-columns-1fr-2fr grid-row-140-160 gap-x-2.5">
					<a href="${recruitment.getDetailLink(job.code)}">
						<img src="/resource/img/castingCall_1.png" alt="" />
					</a>
					<div class="grid content-between">
						<a class="font-bold overflow-hidden line-clamp-1"
							href="${recruitment.getDetailLink(job.code)}" class="block">${recruitment.extra.artworkName}</a>
						<a href="${recruitment.getDetailLink(job.code)}"
							class=" text-xs my-2 text-left overflow-ellipsis overflow-hidden line-clamp-6">내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용</a>
						<a href="${recruitment.getDetailLink(job.code)}"
							class="text-xs text-left">${recruitment.regDate}</a>
					</div>
				</div>
			</c:forEach>
		</c:when>
		<c:when test="${recruitments == null || recruitments == ''}">
			<div
				class="flex justify-center items-center py-4 flex-grow padding-bottom-25s">
				<div class="">배역모집없음</div>
			</div>
		</c:when>
	</c:choose>
</div>
<%@ include file="../part/foot.jsp"%>