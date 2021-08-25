<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<div class="grid justify-center grid-column-auto-800">
	<div class="flex justify-between">
		<div class="text-center py-8 text-xl font-bold">CastingCall</div>
		<div class="flex items-center justify-center">
			<a
				class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
				href="./writeArtwork">
				<i class="fas fa-plus"></i>
				<span>Add</span>
			</a>
		</div>
	</div>

	<c:forEach items="${artworks}" var="artwork">
		<div class="relative flex flex-col mt-4">
			<div
				class="artworkList-box z-20 grid grid-columns-myAudition grid-row-myAudition gap-x-2.5 bg-gray-100 place-content-stretch bg-gray-200 rounded-full place-content-stretch"
				onclick="showActingRoleList(${artwork.id})">
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
							<img class="object-cover w-20 h-20 rounded-full"
								src="${artwork.forPrintGenUrlForArtwork}" alt="" />
						</div>
					</c:when>
					<c:when
						test="${artwork.forPrintGenUrlForArtwork == null || artwork.forPrintGenUrlForArtwork == ''}">
						<div
							class="${bgColor} text-white object-cover w-20 h-20 rounded-full flex justify-center items-center">${artwork.genre}</div>
					</c:when>
				</c:choose>

				<div class="grid items-center">
					<div class="font-black text-sm">${artwork.name}</div>
					<div class="title text-overflow-el text-xs">${artwork.extra.writer}</div>
					<div class="writer text-xs">
						<div>지원자 : 000명</div>
					</div>
				</div>
				<div>
					<c:choose>
						<c:when
							test="${artwork.forPrintGenUrlForMember != null && artwork.forPrintGenUrlForMember != ''}">
							<img class="inline object-cover w-14 h-14 mr-2 rounded-full"
								src="${artwork.forPrintGenUrlForMember}" alt="" />
						</c:when>
						<c:when
							test="${artwork.forPrintGenUrlForMember == null || artwork.forPrintGenUrlForMember == ''}">
							<div
								class="flex justify-center items-center w-14 h-full text-5xl text-gray-600 pr-4">
								<i class="fas fa-user-circle"></i>
							</div>
						</c:when>
					</c:choose>
				</div>
				<c:set var="actingRoleBg" value="bg-gray-300"></c:set>
			</div>
			<div id="artwork-left-background${artwork.id}"
				class="absolute bottom-0 left-0 ${actingRoleBg} h-1/2 w-1/2 z-10 hidden"></div>
			<div id="artwork-right-background${artwork.id}"
				class="absolute bottom-0 right-0 ${actingRoleBg} h-1/2 w-1/2 z-10 hidden"></div>
		</div>
		<div
			class="actingRoleList flex justify-center items-center text-gray-600 " >
			<!-- 각각의 작품에 해당하는 배역목록을 보여줌  -->
			<div id="actingRoleList${artwork.id}" data-display-status="-1"
				class="flex-col flex-grow hidden ${actingRoleBg} p-4 rounded-b-3xl leading-10"></div>
		</div>
	</c:forEach>
</div>

<script>
	//외부영역 클릭 시 팝업 닫기
	$(document).mouseup(function(e){ 
		if($('.artworkList-box').has(e.target).length === 0  && $('.actingRoleList').has(e.target).length === 0){ 
			$('[id^="actingRoleList"]').css("display","none");
			$('[id^="artwork-left-background"]').css("display","none");
			$('[id^="artwork-right-background"]').css("display","none");
			}
		});
	
	function showActingRoleList(artworkId) {
		$('[id^="actingRoleList"]').data("displayStatus", -1);
		$('[id^="actingRoleList"]').css("display","none");
		$('[id^="artwork-left-background"]').css("display","none");
		$('[id^="artwork-right-background"]').css("display","none");
		
		$.get('../../adm/actingRole/getActingRoleListAjax',{
			artworkId : artworkId 
		},function(data){
			drawActingRoleList(data,artworkId);
		},'json');
		
	}
	
	function drawActingRoleList(data,artworkId){
		$('#actingRoleList'+ artworkId).empty();
		
		if(data && data.body && data.body.actingRoles){
			var actingRoles = data.body.actingRoles;
		}else{
			return;
		}
		
		var html = '';
		
		$.each(actingRoles, function(index, actingRole){
			html += '<div class="grid grid-cols-4 bg-gray-200 mb-2 rounded-full px-8 font-black">';
			html += '<div>'+ actingRole.id +'</div>';
			html += '<div>'+ actingRole.name +'역</div>';
			html += '<div>'+ actingRole.gender +'</div>';
			html += '<div>'+ actingRole.job +'</div>';
			html += '</div>';
			
			$('#actingRoleList'+ artworkId).append(html);
		});
		
		if($('#actingRoleList'+ artworkId).data("displayStatus") == 1){
			$('#actingRoleList'+ artworkId).data("displayStatus", -1);
			$('#actingRoleList'+ artworkId ).css("display","none");
			$('#artwork-left-background'+ artworkId).css("display","none");
			$('#artwork-right-background'+ artworkId).css("display","none");
			
		}else{
			$('#actingRoleList'+ artworkId).data("displayStatus", 1);
			$('#actingRoleList'+ artworkId ).css("display","flex");
			$('#artwork-left-background'+ artworkId).css("display","block");
			$('#artwork-right-background'+ artworkId).css("display","block");
		}
	}
</script>


<%@ include file="../part/foot.jspf"%>