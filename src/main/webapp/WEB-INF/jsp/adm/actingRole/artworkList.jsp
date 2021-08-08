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
				<a
					class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
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
					<img class="inline object-cover w-20 h-20 rounded-full"
						src="/resource/img/castingCall_1.png" alt="" />
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
					<img class="inline object-cover w-14 h-14 mr-2 rounded-full"
						src="/resource/img/castingCall_1.png" alt="" />
				</div>
			</div>
			<div class="flex-grow"></div>
		</div>
	</c:forEach>
</div>
<%@ include file="../part/foot.jspf"%>