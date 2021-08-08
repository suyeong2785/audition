<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>
<!-- PC용 -->
<div class="con flex-col">
	<div class="flex items-center justify-center pt-4 px-4">
		<div class="flex justify-center items-center max-w-screen-sm flex-grow">
			<div class="text-center text-xl font-bold">Auditions</div>
			<div class="flex-grow"></div>
			<a href="#" class="flex items-center justify-center">
				<img src="/resource/img/sort_icon.svg" alt="" />
				<span>정렬</span>
			</a>
			<!-- 
				<c:if test="${actorCanWrite}">
				<a class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4" href="./${job.code}-write">
					<i class="fas fa-plus"></i>
					<span>신규모집</span>
				</a>
				</c:if>
				 -->
		</div>
	</div>
	<div class="px-4">
		<div class="flex-grow"></div>
		<c:forEach items="${recruitments}" var="recruitment">
			<div class="flex justify-center items-center py-4 flex-grow">
				<div class="max-h-40 pr-4 ">
					<img class="max-h-40 min-width-140"
						src="/resource/img/castingCall_1.png" alt="" />
				</div>
				<a href="${recruitment.getDetailLink(job.code)}">
					<div class="max-w-md">
						<div class="font-bold overflow-hidden line-clamp-1">${recruitment.extra.artworkName}</div>
						<div class="text-xs text-left my-2 overflow-hidden line-clamp-5">내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용</div>
						<div class="text-xs ">${recruitment.regDate}</div>
					</div>
				</a>
			</div>
		</c:forEach>
		<div class="flex-grow"></div>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>