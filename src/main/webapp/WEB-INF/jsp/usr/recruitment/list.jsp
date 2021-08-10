<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>
<!-- PC용 -->
<div class="con flex-col">
	<div class="px-4 text-center">
		<div class="inline-block ">
			<div class="flex justify-between">
				<div class="text-xl font-bold">Auditions</div>

				<div class="">
					<a href="#" class="flex items-center justify-center">
						<img src="/resource/img/sort_icon.svg" alt="" />
						<span>정렬</span>
					</a>
				</div>
				<!-- 
				<c:if test="${actorCanWrite}">
				<a class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4" href="./${job.code}-write">
					<i class="fas fa-plus"></i>
					<span>신규모집</span>
				</a>
				</c:if>
				 -->
			</div>

			<c:forEach items="${recruitments}" var="recruitment">
				<div
					class="flex justify-center items-center py-4 flex-grow">
					<div class="max-h-40 pr-4 ">
						<a href="${recruitment.getDetailLink(job.code)}">
							<img class="max-h-40 min-width-140"
								src="/resource/img/castingCall_1.png" alt="" />
						</a>
					</div>

					<div class="self-stretch max-w-md flex flex-col max-h-40 justify-center">
						<div class="font-bold overflow-hidden line-clamp-1 self-start ">
							<a href="${recruitment.getDetailLink(job.code)}" class="block">${recruitment.extra.artworkName}</a>
						</div>
						<div
							class="text-xs my-2 text-left overflow-ellipsis overflow-hidden self-start box-border flex items-center">
							<a href="${recruitment.getDetailLink(job.code)}"
								class="inline-block line-clamp-6">내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용</a>
						</div>
						<div class="text-xs self-start">
							<a href="${recruitment.getDetailLink(job.code)}" class="block">${recruitment.regDate}</a>
						</div>

					</div>

				</div>
			</c:forEach>
		</div>
	</div>
	<%@ include file="../part/foot.jspf"%>