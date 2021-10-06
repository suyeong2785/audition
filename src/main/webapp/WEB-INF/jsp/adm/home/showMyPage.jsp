<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../../usr/part/head.jspf"%>

<div class="grid justify-center grid-column-auto-800 mx-4">
	<!--  
	<div>
		<span>actingRoleId : </span>
		<span id="checked-actingRole-id"></span>
	</div>
	-->
	<div class="flex justify-between">
		<div class="text-center py-8 text-xl font-bold">
			<span>진행중인 오디션</span>
		</div>

		<div id="share-box" class="flex items-center justify-center font-bold">
			<div id="share-button"
				class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
				onclick="showArtworksAndActingRolesCheckBox()">
				<span>
					<i class="far fa-share-square"></i>
				</span>
			</div>
			<div id="share-search-button"
				class="hidden bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-l-full px-4"
				onclick="showShareModal()">
				<span>
					<i class="fas fa-user-plus"></i>
				</span>
			</div>
			<div id="share-close-button"
				class="hidden bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-r-full px-4"
				onclick="closeArtworksAndActingRolesCheckBox()">
				<span>
					<i class="fas fa-times"></i>
				</span>
			</div>
		</div>
	</div>

	<c:forEach items="${artworks}" var="artwork">
		<div class="relative flex flex-col mt-4">
			<div
				class="artworkList-box z-20 grid grid-columns-adm-myPage grid-row-adm-myPage place-content-stretch place-content-stretch"
				onclick="showActingRoleList(${artwork.id},'${artwork.title}', '1','${artwork.forPrintGenUrlForArtwork}')">
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
						<div class="relative padding-bottom-50 overlow-hidden bg-white">
							<img
								class="absolute top-0 left-0 text-white w-full h-full flex justify-center items-center rounded-l-lg "
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

				<div
					class="grid items-center border-t-2 border-b-2 border-r-2 border-opacity-25 rounded-r-lg bg-white"
					style="border-color: #C4C4C4;">
					<div
						class="overflow-ellipsis overflow-hidden whitespace-nowrap pl-4 font-black ">
						${artwork.title}
						<input type="checkbox" id="share-artwork${artwork.id}"
							value="${artwork.id}" class="hidden" />
					</div>
				</div>
			</div>
			<c:set var="actingRoleBg" value="bg-gray-showMyPage"></c:set>
			<div id="artwork-left-background${artwork.id}"
				class="absolute bottom-0 left-0 ${actingRoleBg} h-1/2 w-1/2 z-10 hidden"></div>
			<div id="artwork-right-background${artwork.id}"
				class="absolute bottom-0 right-0 ${actingRoleBg} h-1/2 w-1/2 z-10 hidden"></div>
		</div>
		<div
			class="actingRoleList flex justify-center items-center text-gray-600 ">
			<!-- 각각의 작품에 해당하는 배역목록을 보여줌  -->
			<div id="actingRoleList${artwork.id}" data-display-status="-1"
				class="flex-col flex-grow hidden ${actingRoleBg} p-4 rounded-b-lg leading-10 text-sm">
			</div>
		</div>
	</c:forEach>
</div>
<div id="applyment-share-modal" class="modal-background items-center">
	<div class="modal-content-share">
		<div
			class="relative flex justify-center items-center text-white text-center h-12 md:h-14 text-2xl md:text-4xl mb-4">
			<!-- 검색 상자 -->
			<div class="search-box flex-grow h-full ">
				<input id="director-search-input"
					class="bg-gray-200 block w-full h-full text-xl px-4 text-black"
					type="text" placeholder="지원자를 공유할 캐스팅디렉터님의 아이디를 입력해주세요" />
			</div>
			<!-- 검색 버튼 -->
			<button onclick="getCastingDirectorList()"
				class="flex justify-center items-center h-full bg-green-400 text-white text-center h-full px-4 text-2xl md:text-3xl hover:bg-green-500">
				<i class="fas fa-search"></i>
			</button>
			<!-- 닫기 버튼 -->
			<button onclick="closeCastingDirectorList()" id="search-close-button"
				class=" hidden justify-center items-center h-full bg-green-400 text-white text-center h-full px-4 text-2xl md:text-3xl hover:bg-green-500">
				<i class="fas fa-times"></i>
			</button>
		</div>
		<div id="search-result"></div>
		<div id="share-link-box" class="hidden">
			<input class="absolute -inset-full z-0" type="text" id="share-link" />
			<button type="button" id="copy_btn" class="btn btn-info">Link
				Copy</button>
			<button class="share-button" type="button" title="Share this article">
				<i class="fas fa-share-alt"></i>
				Share
			</button>
		</div>
	</div>
</div>
<script>	
	var actingRoles = new Array();
	
	var loginedMemberId = '<c:out value="${loginedMemberId}"/>';
	var environment = '<c:out value="${environment}"/>';
	
	//외부영역 클릭 시 팝업 닫기
	$(document).mouseup(function(e){ 
		
		if($('.artworkList-box').has(e.target).length === 0  && $('.actingRoleList').has(e.target).length === 0){ 
			$('[id^="actingRoleList"]').css("display","none");
			$('[id^="actingRoleList"]').data("displayStatus","-1");
			$('[id^="actingRoleList"]').empty();
			$('[id^="artwork-left-background"]').css("display","none");
			$('[id^="artwork-right-background"]').css("display","none");

		}
		//회원모달창 켜졌을경우 외부영역 클릭 시 팝업 닫기
		if($('.modal-background').has(e.target).length === 0 && $('.modal-content').has(e.target).length === 0){
			$('.modal-background').css("display", "none");
			$('#search-result').empty();
		}
		
	});
	
	function showShareModal(){
		$('#applyment-share-modal').css("display", "flex");
		
		if(sharedActingRoles.length != 0){
			$('#share-link-box').css("display","flex");
			
			var redirectUri = encodeURIComponent('/usr/share/doShareArtworksAndActingRoles?relTypeCode=actingRole&relId='+ sharedActingRoles +'&requesterId=1');
			$('#share-link').val( environment + '/usr/member/join?redirectUri='+ redirectUri);
		}else{
			$('#share-link-box').css("display","none");
		}
	}
	
	var totalCount = 0;
	
	function showActingRoleList(artworkId,artworkTitle, page, artworkFileUrl) {

		$('[id^="actingRoleList"]').not('#actingRoleList'+ artworkId).css("display","none");
		$('[id^="actingRoleList"]').not('#actingRoleList'+ artworkId).data("displayStatus",-1);
		$('[id^="artwork-left-background"]').not('#artwork-left-background'+ artworkId).css("display","none");
		$('[id^="artwork-right-background"]').not('#artwork-right-background'+ artworkId).css("display","none");

		if($('#actingRoleList'+ artworkId).data("displayStatus") == 1){
			$('#actingRoleList'+ artworkId).data("displayStatus", -1);
			$('#actingRoleList'+ artworkId ).css("display","none");
			$('#artwork-left-background'+ artworkId).css("display","none");
			$('#artwork-right-background'+ artworkId).css("display","none");
			
			return;
		}
		
		$.ajax({
			url:'../../adm/actingRole/getActingRoleListByArtworkIdAjax',
			data : { artworkId : artworkId},
			dataType : 'json',
			}).then(function(data){
				totalCount = data.body.actingRoles.length;
				actingRoles = data.body.actingRoles;
				drawActingRoleList(artworkId, artworkTitle, page, artworkFileUrl);
			});
		
	}
	
	let sharedActingRoles = [];
	
	function drawActingRoleList(artworkId, artworkTitle, page, artworkFileUrl){
		
		var itemsInAPage = 3;
		
		var limitStart = (page-1) * itemsInAPage ;
		var limitTake = itemsInAPage;
		
		$('#actingRoleList'+ artworkId).empty();
		
		if(actingRoles == null || actingRoles == ''){
			return;
		}
		
		var html = '';
		var actingRoleIds = new Array();
		
		$.each(actingRoles, function(index, actingRole){
			actingRoleIds.push(actingRole.id);
			
			if(limitStart <= index && limitTake > index ){
				
				html += '<div class="flex justify-between items-center mb-2 font-black border-dashed border-b border-black" style="border-color : #58595B">';
				html += '<div class="grid justify-items-start" style="grid-template-columns: minmax(30px,40px) minmax(30px,50px) minmax(30px,50px);">';
				html += '<div class=" text-center overflow-ellipsis overflow-hidden whitespace-nowrap ">'+ actingRole.gender +'</div>';
				html += '<div class=" text-center overflow-ellipsis overflow-hidden whitespace-nowrap ">'+ actingRole.role +'</div>';
				html += '<div class=" text-right whitespace-nowrap ">';
				html += '<span class="pr-4">' + actingRole.age + '</span>';
				html += '<input type="checkbox" class="'+ ($('#share-box').data("shareStatus") == 1 ? "inline" : "none") + '" id="share-actingRole'+ actingRole.id + '" value="'+ actingRole.id + '"/>';
				html += '</div>';
				html += '</div>';
				html += '<a href="../applyment/showMyApplyments?artworkTitle='+ artworkTitle.replace("[","(*(").replace("]",")*)") +'&actingRoleGender='+ actingRole.gender +'&actingRoleRole='+ actingRole.role +'&actingRoleAge='+ actingRole.age +'&relTypeCode=actingRole&relId='+ actingRole.id +'&artworkFileUrl='+ artworkFileUrl +'">';
				html += '<div class="bg-gray-500 hover:bg-gray-700 text-white text-xs font-thin rounded-full py-1 px-2" style="background-color : #58595B"><i class="fas fa-search"></i></div>';
				html += '</a>';
				html += '</div>';
				
			}
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
		
		$('#actingRoleList'+ artworkId).data("actingRoleIds", actingRoleIds);
		
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
				pageHtml += '<span class="bg-white border-gray-300 text-red-500 hover:bg-red-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium" data-page="'+ i +'" onclick="changeActingRoleListPage('+ artworkId +','+ i + ',' + artworkTitle + ',' + artworkFileUrl +')">'+ i +'</span>';	
			}else{
				pageHtml += '<span class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium" data-page="'+ i +'" onclick="changeActingRoleListPage('+ artworkId +','+ i + ',' + artworkTitle + ',' + artworkFileUrl +')">'+ i +'</span>';	
			}
		}

		$('#pagination'+ artworkId).append(pageHtml);
		
		var currentPage = $('#pagination'+ artworkId).find('span.text-red-500').data("page");
		
		var previousPage = parseInt(currentPage) - 1;
		
		var previousPageHtml = '<span id="previousPage" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (previousPage < pageMenuStart ? pageMenuStart : previousPage) +',' + artworkTitle + ',' + artworkFileUrl +')">';
		previousPageHtml += '<i class="fas fa-caret-left"></i>';
		previousPageHtml += '</span>';
		
		$('#pagination'+ artworkId).prepend(previousPageHtml);
		
		var nextPage = parseInt(currentPage) + 1;
		
		var nextPageHtml = '<span id="nextPage" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (nextPage > totalPage ? totalPage : nextPage) +',' + artworkTitle + ',' + artworkFileUrl +')">';
		nextPageHtml += '<i class="fas fa-caret-right"></i>';
		nextPageHtml += '</span>';
		
		$('#pagination'+ artworkId).append(nextPageHtml);
		
		var pageMobileHtml = '<span class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (previousPage < pageMenuStart ? pageMenuStart : previousPage) +',' + artworkTitle + ',' + artworkFileUrl +')">';
		pageMobileHtml += 'Previous';
		pageMobileHtml += '</span>';
		pageMobileHtml += '<span class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (nextPage > totalPage ? totalPage : nextPage) +',' + artworkTitle + ',' + artworkFileUrl +')">';
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
		
		if($("[id='share-artwork"+ artworkId +"']").is(":checked") == true){
			$('input:checkbox[id^="share-actingRole"]').css("display","none");
			
			var actingRoleIds = $('#actingRoleList'+ artworkId).data("actingRoleIds");
			
			for(var i = 0; i < actingRoleIds.length; i++ ){
				var sameValue = -1;
				for(var j = 0; j < sharedActingRoles.length; j++){
					if(sharedActingRoles[j] == actingRoleIds[i]){
						sharedActingRoles.splice(sharedActingRoles.indexOf(sharedActingRoles[j]),1);
					}
				}
				sharedActingRoles[ sharedActingRoles.length + 1] = actingRoles[i].id;	
			}
			
			// 오름차순
			sharedActingRoles.sort(function(a, b) {
			    return a - b;
			});
			
			sharedActingRoles = sharedActingRoles.filter((element, index) => element != "" && element != null );
			var actingRoleToShare =  sharedActingRoles.join(",");
			
			$('#checked-actingRole-id').html(actingRoleToShare);
		}
		
		$('input:checkbox[id^="share-actingRole"]:not(:checked)').each(function(index,item) {
			for(var i = 0; i < sharedActingRoles.length; i++ ){
				if(sharedActingRoles[i] == $('[id^="share-actingRole"]:not(:checked)').eq(index).val()){
					$('[id^="share-actingRole"]:not(:checked)').eq(index).attr("checked", true);
				}
			}
		});	
		
		$("[id^='share-actingRole']").change(function(){
			$('#checked-actingRole-id').empty();
			
			$('input:checkbox[id^="share-actingRole"]:checked').each(function(index,item) {
				var sameValue = -1;
				for(var i = 0; i < sharedActingRoles.length; i++ ){
					if(sharedActingRoles[i] == $('[id^="share-actingRole"]:checked').eq(index).val()){
						sameValue = 1;
						break;
					}
				}
				if(sameValue != 1){
					sharedActingRoles[ sharedActingRoles.length + 1] = $('[id^="share-actingRole"]:checked').eq(index).val();	
				}

			 });
			
			$('input:checkbox[id^="share-actingRole"]:not(:checked)').each(function(index,item) {

				for(var i = 0; i < sharedActingRoles.length; i++ ){
					if(sharedActingRoles[i] == $('[id^="share-actingRole"]:not(:checked)').eq(index).val()){
						sharedActingRoles.splice(sharedActingRoles.indexOf(sharedActingRoles[i]),1);
					} 
				}
			 });
			// 오름차순
			sharedActingRoles.sort(function(a, b) {
			    return a - b;
			});
			
			sharedActingRoles = sharedActingRoles.filter((element, index) => element != "" && element != null );
			var actingRoleToShare =  sharedActingRoles.join(",");
			
			$('#checked-actingRole-id').html(actingRoleToShare);
		});
		
	}
	
	function changeActingRoleListPage(artworkId, page , artworkTitle, artworkFileUrl ){
		
		var itemsInAPage = 3;
		
		var limitStart = (page-1) * itemsInAPage ;
		var limitTake = limitStart + itemsInAPage;
		
		$('#actingRoleList'+ artworkId).empty();
		
		var html = '';
		
		$.each(actingRoles, function(index, actingRole){
			if(limitStart <= index && limitTake > index ){
				
				html += '<div class="flex justify-between items-center mb-2 font-black border-dashed border-b border-opacity-25" >';
				html += '<div class="grid justify-items-start" style="grid-template-columns: minmax(30px,40px) minmax(30px,50px) minmax(30px,50px);">';
				html += '<div class=" text-center overflow-ellipsis overflow-hidden whitespace-nowrap ">'+ actingRole.gender +'</div>';
				html += '<div class=" text-center overflow-ellipsis overflow-hidden whitespace-nowrap ">'+ actingRole.role +'역</div>';
				html += '<div class=" text-right whitespace-nowrap ">';
				html += '<span class="pr-4">' + actingRole.age + '</span>';
				html += '<input type="checkbox" class="'+ ($('#share-box').data("shareStatus") == 1 ? "inline" : "none") + '" id="share-actingRole'+ actingRole.id + '" value="'+ actingRole.id + '"/>';
				html += '</div>';
				html += '</div>';
				html += '<a href="../applyment/showMyApplyments?artworkTitle='+ artworkTitle +'&actingRoleGender='+ actingRole.gender +'&actingRoleRole='+ actingRole.role +'&actingRoleAge='+ actingRole.age +'&relTypeCode=actingRole&relId='+ actingRole.id +'&artworkFileUrl='+ artworkFileUrl +'">';
				html += '<div class="bg-gray-500 hover:bg-gray-700 text-white text-xs font-thin rounded-full py-1 px-2"><i class="fas fa-search"></i></div>';
				html += '</a>';
				html += '</div>';
			}
		});
		
		html += '<div class="flex items-center justify-center sm:px-6">';
		html += '<div id="pagination-mobile'+ artworkId +'" class="flex justify-between sm:hidden">';
		html += '</div>';
		html += '<div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-center">';
		html += '<div>';
		html += '<nav id="pagination'+ artworkId +'" class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">';
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
				pageHtml += '<span class="bg-white border-gray-300 text-red-500 hover:bg-red-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium" data-page="'+ i +'" onclick="changeActingRoleListPage('+ artworkId +','+ i +',' + artworkTitle + ',' + artworkFileUrl +')">'+ i +'</span>';	
			}else{
				pageHtml += '<span class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium" data-page="'+ i +'" onclick="changeActingRoleListPage('+ artworkId +','+ i +',' + artworkTitle + ',' + artworkFileUrl +')">'+ i +'</span>';	
			}
		}
		
		$('#pagination'+ artworkId).append(pageHtml);
		
		var currentPage = $('#pagination'+ artworkId).find('span.text-red-500').data("page");
		
		var previousPage = parseInt(currentPage) - 1;
		
		var previousPageHtml = '<span id="previousPage" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (previousPage < pageMenuStart ? pageMenuStart : previousPage) +',' + artworkTitle + ',' + artworkFileUrl +')">';
		previousPageHtml += '<i class="fas fa-caret-left"></i>';
		previousPageHtml += '</span>';
		
		$('#pagination'+ artworkId).prepend(previousPageHtml);
		
		var nextPage = parseInt(currentPage) + 1;
		
		var nextPageHtml = '<span id="nextPage" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (nextPage > totalPage ? totalPage : nextPage) +',' + artworkTitle + ',' + artworkFileUrl +')">';
		nextPageHtml += '<i class="fas fa-caret-right"></i>';
		nextPageHtml += '</span>';
		
		$('#pagination'+ artworkId).append(nextPageHtml);
		
		var pageMobileHtml = '<span class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (previousPage < pageMenuStart ? pageMenuStart : previousPage) +',' + artworkTitle + ',' + artworkFileUrl +')">';
		pageMobileHtml += 'Previous';
		pageMobileHtml += '</span>';
		pageMobileHtml += '<span class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (nextPage > totalPage ? totalPage : nextPage) +',' + artworkTitle + ',' + artworkFileUrl +')">';
		pageMobileHtml += 'Next';
		pageMobileHtml += '</span>';
		
		$('#pagination-mobile'+ artworkId).prepend(pageMobileHtml);
		
		$('input:checkbox[id^="share-actingRole"]:not(:checked)').each(function(index,item) {
			for(var i = 0; i < sharedActingRoles.length; i++ ){
				if(sharedActingRoles[i] == $('[id^="share-actingRole"]:not(:checked)').eq(index).val()){
					$('[id^="share-actingRole"]:not(:checked)').eq(index).attr("checked", true);
				}
			}
		});
		
		$("[id^='share-actingRole']").change(function(){
			$('#checked-actingRole-id').empty();
			
			$('input:checkbox[id^="share-actingRole"]:checked').each(function(index,item) {
				var sameValue = -1;
				for(var i = 0; i < sharedActingRoles.length; i++ ){
					if(sharedActingRoles[i] == $('[id^="share-actingRole"]:checked').eq(index).val()){
						sameValue = 1;
						break;
					}
				}
				if(sameValue != 1){
					sharedActingRoles[sharedActingRoles.length + 1] = $('[id^="share-actingRole"]:checked').eq(index).val();	
				}

			 });
			
			$('input:checkbox[id^="share-actingRole"]:not(:checked)').each(function(index,item) {
				for(var i = 0; i < sharedActingRoles.length; i++ ){
					if(sharedActingRoles[i] == $('[id^="share-actingRole"]:not(:checked)').eq(index).val()){
						sharedActingRoles.splice(sharedActingRoles.indexOf(sharedActingRoles[i]),1);
					} 
				}
			 });
			
			// 오름차순
			sharedActingRoles.sort(function(a, b) {
			    return a - b;
			});
			
			sharedActingRoles = sharedActingRoles.filter((element, index) => element != "" && element != null );
			var actingRoleToShare =  sharedActingRoles.join(",");
			
			$('#checked-actingRole-id').html(actingRoleToShare);
		});
	
	}
	
	$("[id^='share-artwork']").change(function(e){
		
		var actingRoleIds = $('#actingRoleList'+ e.target.value).data("actingRoleIds");
		
		if($("[id='"+ e.target.id +"']").is(":checked") == false){		
			for(var i = 0; i < actingRoleIds.length; i++ ){
				for(var j = 0; j < sharedActingRoles.length; j++){
					if(sharedActingRoles[j] == actingRoleIds[i]){
						sharedActingRoles.splice(sharedActingRoles.indexOf(sharedActingRoles[j]),1);
					}
				} 
			}
		}
		
		// 오름차순
		sharedActingRoles.sort(function(a, b) {
		    return a - b;
		});
		
		sharedActingRoles = sharedActingRoles.filter((element, index) => element != "" && element != null );
		var actingRoleToShare =  sharedActingRoles.join(",");
		
		$('#checked-actingRole-id').html(actingRoleToShare);	
	});
	
	//감춰두었던 체크박스 보여주는 함수
	function showArtworksAndActingRolesCheckBox(){
		$('#share-box').data("shareStatus", 1);
		$('#share-button').css("display","none");
		$('#share-search-button').css("display","block");
		$('#share-close-button').css("display","block");
		
		$('input:checkbox[id^="share-artwork"]').css("display","inline");
		
	}
	
	function closeArtworksAndActingRolesCheckBox(){
		$('#share-box').data("shareStatus", -1);
		$('#share-button').css("display","inline");
		$('#share-search-button').css("display","none");
		$('#share-close-button').css("display","none");
		
		$('input:checkbox[id^="share-artwork"]:checked').each(function(index,item) {
			$(item).prop("checked", false);
		});
		
		$('input:checkbox[id^="share-artwork"]').css("display","none");
		
		sharedArtworks = [];
		sharedActingRoles = [];
		$('#share-link').val("");
		
	}
	
	//작품리스트,배역리스트 공유대상 검색 및 공유기능
	function closeCastingDirectorList(){
		$('#search-close-button').css({"display":"none"});
		
		//값 초기화
		$('#search-result').empty();
		$('#director-search-input').val("");
	}
	
	function getCastingDirectorList(){
		
		if(sharedActingRoles.length == 0){
			alert("공유할 대상이 선택되지 않았습니다.");
			return;
		}
		//양쪽 공백제거
		var $director_search_input = $.trim($('#director-search-input').val());
		
		if($director_search_input == ""){
			alert('검색어를 입력해주세요.');
			return;
		}	
		
		$.get('../../usr/member/getCastingDirectorListAjax',{
			loginId : $director_search_input,
			authority : 1,
			id : loginedMemberId
		},CastingDirectorList
		,'json'
		);	
	}
	
	function CastingDirectorList(data){
		var $search_result = $('#search-result');
		
		//값 초기화
		$search_result.empty();
		
		var members = null;
		
		if(data.resultCode.startsWith('F')){
			$('#search-close-button').css({"display":"none"});
			
			$search_result.html("<span>존재하지않는 계정입니다.</br>아래의 링크를 상대방에게 공유하여 지원자공유를 진행하실수 있습니다.</span>");
		}
		
		if(data && data.body && data.body.members){
			members = data.body.members;
			
			$('#search-close-button').css({"display":"flex"});
		}
		
		var html = '';
		
		$.each(members, function(index, item){
			
			html+= "<div class='flex justify-center items-center mb-4'>";
			html+= "<div>" + item.loginId+ "/" + item.name + "</div>";
			html+= "<div class='flex-grow'></div>";
			html+= "<button onclick='doShareApplymentsWith({item.id}" + "," +"{item.name})' class='bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded'>";
			html+= "공유초대</button>";
			html+= "</div>";
			
			//item.name을 변수로 인식해서 uncaught reference error에러 발생 아래처럼 정규식으로 찾아서 값을 넣어줘야함
			html = html.replace(/{item.name}/gi, '"' + item.name + '"').replace(/{item.id}/gi, '"' + item.id + '"');
	
		});
		
		$search_result.prepend(html);
		
	}
	
	function doShareApplymentsWith(id, name){
		
		var result = confirm(name +'님과 지원자들을 공유하시겠습니까?');
		
		if(result == false){
			return;
		}
		
		if(sharedActingRoles.length != 0){
			
			sharedActingRoles =  sharedActingRoles.filter((element, index) => element != "" && element != null );
			var data = { 
					"requesterId" : loginedMemberId,
					"requesteeId" : id,
					"name" : name,
					"relTypeCode" : "actingRole",
					"relIds" : sharedActingRoles
			};
			
			$.ajax({
				url : '../../usr/share/doShareArtworksAndActingRolesAjax',
				type : "post",
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				data : data,
				success : function(data){
					alert(data.msg);
					getCastingDirectorList();
				}
			});
			
		}else{
			alert("공유할 대상이 선택되지 않았습니다.");
		}
	}
	
	$('#copy_btn').click(function(){
		$('#share-link').select(); //복사할 텍스트를 선택
		document.execCommand("copy"); //클립보드 복사 실행
		alert('복사완료');
	});
	
	const shareButton = document.querySelector('.share-button');
	const shareDialog = document.querySelector('.share-dialog');
	const closeButton = document.querySelector('.close-button');
	
	shareButton.addEventListener('click', event => {
	  var loginedMemberName = '<c:out value="${loginedMember.name}"/>';
	  var title = loginedMemberName + '님의 지원자 공유신청 링크';
	  var url = $('#share-link').val();
	  
	  if (navigator.share) { 
	   navigator.share({
	      title: title,
	      url: url
	    }).then(() => {
	      console.log('Thanks for sharing!');
	    })
	    .catch(console.error);
	    } else {
	        shareDialog.classList.add('is-open');
	    }
	});
	

</script>


<%@ include file="../part/foot.jspf"%>