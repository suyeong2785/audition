<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../../usr/part/head.jspf"%>

<div class="grid justify-center grid-column-auto-800 mx-4 ">
	<div class="flex justify-between">
		<div class="flex justify-center items-center flex-4">
			<div class="text-center py-8 text-xl font-bold">진행중인 캐스팅</div>
			<div class="flex-grow"></div>
			<div class="flex items-center justify-center"></div>
		</div>
	</div>
	<c:forEach items="${artworks}" var="artwork">
		<div class="relative flex flex-col mt-4 ">
			<div
				class="z-20 grid place-content-stretch rounded-lg place-content-stretch"
				style="grid-template-columns: minmax(68px,90px) minmax(100px,auto);
				grid-template-rows: minmax(68px,auto);">
				<a href="../../usr/actingRole/${artwork.getDetailLink()}">
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
							<div class="relative padding-bottom-50 overlow-hidden">
								<img
									class="absolute top-0 left-0 text-white w-full h-full flex justify-center items-center rounded-l-lg"
									src="${artwork.forPrintGenUrlForArtwork}" alt="" />
							</div>
						</c:when>
						<c:when
							test="${artwork.forPrintGenUrlForArtwork == null || artwork.forPrintGenUrlForArtwork == ''}">
							<div class="relative padding-bottom-50 overlow-hidden">
								<div
									class="${bgColor} absolute top-0 left-0 text-white w-full h-full rounded-l-lg flex justify-center items-center">${artwork.genre}</div>
							</div>
						</c:when>
					</c:choose>
				</a>

				<div
					class="flex flex-col justify-between py-2 border-t-2 border-b-2 border-r-2 border-opacity-25 rounded-r-lg pl-4 "
					style="border-color: #C4C4C4;">
					<div class="overflow-ellipsis overflow-hidden whitespace-nowrap ">
						<a href="../../usr/actingRole/${artwork.getDetailLink()}">${artwork.title}</a>
					</div>
					<div class="flex">
						<a href="modifyArtwork?id=${artwork.id}">
							<div
								class="rounded-full">
								<i class="far fa-edit"></i>
							</div>
						</a>
						<button
							class=" rounded-full px-4" onclick="deleteArtworkBy(${artwork.id})">
							<i class="fas fa-trash"></i>
						</button>
					</div>
				</div>		
			</div>
		</div>
	</c:forEach>
</div>

<script>
	function deleteArtworkBy(id){
		
		if(confirm("해당 캐스팅콜을 삭제하시겠습니까?")){
			$.ajax({
				url : '../../adm/actingRole/doDeleteArtworkAjax',
				data : {id : id},
				dataType : 'json',
				async : false,
				type : 'POST',
				success : function(data){
					if (data && data.body) {
						
						alert(data.body.msg);
		
					}
				}
			});
			
			location.reload();
		}
	}
</script>
<%@ include file="../part/foot.jspf"%>