<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<div class="grid justify-center grid-column-auto-800 mx-4">
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
				class="artworkList-box z-20 grid grid-columns-adm-myPage grid-row-adm-myPage gap-x-2.5 bg-gray-100 place-content-stretch bg-gray-200 rounded-full place-content-stretch"
				onclick="showActingRoleList(${artwork.id},1)">
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
								class="absolute top-0 left-0 text-white w-full h-full flex justify-center items-center rounded-full"
								src="${artwork.forPrintGenUrlForArtwork}" alt="" />
						</div>
					</c:when>
					<c:when
						test="${artwork.forPrintGenUrlForArtwork == null || artwork.forPrintGenUrlForArtwork == ''}">
						<div class="relative padding-bottom-50 overlow-hidden">
							<div
								class="${bgColor} absolute top-0 left-0 text-white w-full h-full rounded-full flex justify-center items-center">${artwork.genre}</div>
						</div>
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
			class="actingRoleList flex justify-center items-center text-gray-600 ">
			<!-- 각각의 작품에 해당하는 배역목록을 보여줌  -->
			<div id="actingRoleList${artwork.id}" data-display-status="-1"
				class="flex-col flex-grow hidden ${actingRoleBg} p-4 rounded-b-3xl leading-10">
			</div>
		</div>
	</c:forEach>
</div>

<script>
	//외부영역 클릭 시 팝업 닫기
	$(document).mouseup(function(e){ 
		if($('.artworkList-box').has(e.target).length === 0  && $('.actingRoleList').has(e.target).length === 0){ 
			$('[id^="actingRoleList"]').css("display","none");
			$('[id^="actingRoleList"]').data("displayStatus","-1");
			$('[id^="actingRoleList"]').empty();
			$('[id^="artwork-left-background"]').css("display","none");
			$('[id^="artwork-right-background"]').css("display","none");
			}
		});
	
	function showActingRoleList(artworkId, page) {
		
		var itemsInAPage = 3;
		
		var limitStart = (page-1) * itemsInAPage ;
		var limitTake = itemsInAPage;
		
		var totalCount = 0;
		
		$('[id^="actingRoleList"]').not('#actingRoleList'+ artworkId).css("display","none");
		$('[id^="actingRoleList"]').not('#actingRoleList'+ artworkId).data("displayStatus",-1);
		$('[id^="artwork-left-background"]').not('#artwork-left-background'+ artworkId).css("display","none");
		$('[id^="artwork-right-background"]').not('#artwork-right-background'+ artworkId).css("display","none");
		
		function actingRoleList(totalCount){ 
			$.get('../../adm/actingRole/getActingRoleListByArtworkIdAjax',{
			artworkId : artworkId,
			limitStart : limitStart,
			limitTake : limitTake
			
		},function(data){
			drawActingRoleList(data, artworkId, page, itemsInAPage, totalCount);
			
		},'json');
		
		}
		
		$.ajax({
			url:'../../adm/actingRole/getActingRoleListByArtworkIdAjax',
			data : { artworkId : artworkId},
			dataType : 'json',
			}).then(function(data){
				totalCount = data.body.actingRoles.length;
				actingRoleList(totalCount);
			});
		
	}
	
	function drawActingRoleList(data, artworkId, page, itemsInAPage, totalCount){
		$('#actingRoleList'+ artworkId).empty();
		
		if(data && data.body && data.body.actingRoles){
			var actingRoles = data.body.actingRoles;
		}else{
			return;
		}
		
		var html = '';
		
		$.each(actingRoles, function(index, actingRole){
			html += '<div class="flex justify-between justify-items-stretch bg-gray-200 mb-2 rounded-full px-8 font-black">';
			html += '<div class="flex-1-0-0 ">'+ actingRole.id +'</div>';
			html += '<div class="flex-3-0-0 text-center">'+ actingRole.name +'역</div>';
			html += '<div class="flex-2-0-0 text-center">'+ actingRole.gender +'</div>';
			html += '<div class="flex-3-0-0 text-right">'+ actingRole.job +'</div>';
			html += '</div>';
			
		});
		
		html += '<div class="flex items-center justify-center sm:px-6">';
		html += '<div id="pagination-mobile'+artworkId+'" class="flex justify-between sm:hidden">';
		html += '</div>';
		html += '<div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-center">';
		html += '<div>';
		html += '<nav id="pagination'+artworkId+'" class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">';
		html += '</nav>';
		html += '</div>';
		html += '</div>';
		html += '</div>';
		
		$('#actingRoleList'+ artworkId).append(html);
		
		var pageHtml = '';
		
		var totalPage = Math.ceil( totalCount / itemsInAPage );
		
		var pageMenuArmSize = 4;
		var pageMenuStart = page - pageMenuArmSize;
		
		if(pageMenuStart < 1) {
			pageMenuStart = 1;
		}
		
		var pageMenuEnd = page + pageMenuArmSize;
		
		if(pageMenuEnd > totalPage) {
			pageMenuEnd = totalPage;
		}
		
		for(var i = pageMenuStart; i <= pageMenuEnd; i++){
			if(page == i){
				pageHtml += '<span class="bg-white border-gray-300 text-red-500 hover:bg-red-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium" data-page="'+ i +'" onclick="changeActingRoleListPage('+ artworkId +','+ i +')">'+ i +'</span>';	
			}else{
				pageHtml += '<span class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium" data-page="'+ i +'" onclick="changeActingRoleListPage('+ artworkId +','+ i +')">'+ i +'</span>';	
			}
		}

		$('#pagination'+ artworkId).append(pageHtml);
		
		var currentPage = $('#pagination'+ artworkId).find('span.text-red-500').data("page");
		
		var previousPage = parseInt(currentPage) - 1;
		
		var previousPageHtml = '<span id="previousPage" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (previousPage < pageMenuStart ? pageMenuStart : previousPage) +')">';
		previousPageHtml += '<i class="fas fa-caret-left"></i>';
		previousPageHtml += '</span>';
		
		$('#pagination'+ artworkId).prepend(previousPageHtml);
		
		var nextPage = parseInt(currentPage) + 1;
		
		var nextPageHtml = '<span id="nextPage" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (nextPage > totalPage ? totalPage : nextPage) +')">';
		nextPageHtml += '<i class="fas fa-caret-right"></i>';
		nextPageHtml += '</span>';
		
		$('#pagination'+ artworkId).append(nextPageHtml);
		
		var pageMobileHtml = '<span class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (previousPage < pageMenuStart ? pageMenuStart : previousPage) +')">';
		pageMobileHtml += 'Previous';
		pageMobileHtml += '</span>';
		pageMobileHtml += '<span class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (nextPage > totalPage ? totalPage : nextPage) +')">';
		pageMobileHtml += 'Next';
		pageMobileHtml += '</span>';
		
		$('#pagination-mobile'+ artworkId).prepend(pageMobileHtml);
		
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
	
	function changeActingRoleListPage(artworkId, page){
		
		var itemsInAPage = 3;
		
		var limitStart = (page-1) * itemsInAPage ;
		var limitTake = itemsInAPage;
		
		var totalCount = 0;
		
		function actingRoleList(totalCount){ 
			$.get('../../adm/actingRole/getActingRoleListByArtworkIdAjax',{
			artworkId : artworkId,
			limitStart : limitStart,
			limitTake : limitTake
			
		},function(data){
			RedrawActingRoleList(data, artworkId, page, itemsInAPage, totalCount);
			
		},'json');
		
		}
		
		$.ajax({
			url:'../../adm/actingRole/getActingRoleListByArtworkIdAjax',
			data : { artworkId : artworkId},
			dataType : 'json',
			}).then(function(data){
				totalCount = data.body.actingRoles.length;
				actingRoleList(totalCount);
		});
		
	}
	
	function RedrawActingRoleList(data, artworkId, page, itemsInAPage, totalCount){
		$('#actingRoleList'+ artworkId).empty();
		
		if(data && data.body && data.body.actingRoles){
			var actingRoles = data.body.actingRoles;
		}else{
			return;
		}
		
		var html = '';
		
		$.each(actingRoles, function(index, actingRole){
			html += '<div class="flex justify-between justify-items-stretch bg-gray-200 mb-2 rounded-full px-8 font-black">';
			html += '<div class="flex-1-0-0 ">'+ actingRole.id +'</div>';
			html += '<div class="flex-3-0-0 text-center">'+ actingRole.name +'역</div>';
			html += '<div class="flex-2-0-0 text-center">'+ actingRole.gender +'</div>';
			html += '<div class="flex-3-0-0 text-right">'+ actingRole.job +'</div>';
			html += '</div>';
			
		});
		
		html += '<div class="flex items-center justify-center sm:px-6">';
		html += '<div id="pagination-mobile'+artworkId+'" class="flex justify-between sm:hidden">';
		html += '</div>';
		html += '<div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-center">';
		html += '<div>';
		html += '<nav id="pagination'+artworkId+'" class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">';
		html += '</nav>';
		html += '</div>';
		html += '</div>';
		html += '</div>';
		
		$('#actingRoleList'+ artworkId).append(html);
		
		var pageHtml = '';
		
		var totalPage = Math.ceil( totalCount / itemsInAPage );
		
		var pageMenuArmSize = 4;
		var pageMenuStart = page - pageMenuArmSize;
		
		if(pageMenuStart < 1) {
			pageMenuStart = 1;
		}
		
		var pageMenuEnd = page + pageMenuArmSize;
		
		if(pageMenuEnd > totalPage) {
			pageMenuEnd = totalPage;
		}
		
		for(var i = pageMenuStart; i <= pageMenuEnd; i++){
			if(page == i){
				pageHtml += '<span class="bg-white border-gray-300 text-red-500 hover:bg-red-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium" data-page="'+ i +'" onclick="changeActingRoleListPage('+ artworkId +','+ i +')">'+ i +'</span>';	
			}else{
				pageHtml += '<span class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium" data-page="'+ i +'" onclick="changeActingRoleListPage('+ artworkId +','+ i +')">'+ i +'</span>';	
			}
			
		}
		
		$('#pagination'+ artworkId).append(pageHtml);
		
		var currentPage = $('#pagination'+ artworkId).find('span.text-red-500').data("page");
		
		var previousPage = parseInt(currentPage) - 1;
		
		var previousPageHtml = '<span id="previousPage" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (previousPage < pageMenuStart ? pageMenuStart : previousPage) +')">';
		previousPageHtml += '<i class="fas fa-caret-left"></i>';
		previousPageHtml += '</span>';
		
		$('#pagination'+ artworkId).prepend(previousPageHtml);
		
		var nextPage = parseInt(currentPage) + 1;
		
		var nextPageHtml = '<span id="nextPage" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (nextPage > totalPage ? totalPage : nextPage) +')">';
		nextPageHtml += '<i class="fas fa-caret-right"></i>';
		nextPageHtml += '</span>';
		
		$('#pagination'+ artworkId).append(nextPageHtml);
		
		var pageMobileHtml = '<span class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (previousPage < pageMenuStart ? pageMenuStart : previousPage) +')">';
		pageMobileHtml += 'Previous';
		pageMobileHtml += '</span>';
		pageMobileHtml += '<span class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (nextPage > totalPage ? totalPage : nextPage) +')">';
		pageMobileHtml += 'Next';
		pageMobileHtml += '</span>';
		
		$('#pagination-mobile'+ artworkId).prepend(pageMobileHtml);
	
	}
	
</script>


<%@ include file="../part/foot.jspf"%>