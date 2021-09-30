<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../part/head.jspf"%>

<div class="grid justify-center grid-column-auto-800 p-4">
	<div class="flex justify-between py-8">
		<div class="text-center ">내가지원한 오디션</div>
		<div class="text-center ">정렬</div>
	</div>

	<c:forEach items="${applyments}" var="applyment">
		<div class="relative  flex flex-col mt-4">
			<div
				class="grid grid-columns-myAudition grid-row-myAudition gap-x-2.5 bg-gray-100 place-content-stretch bg-gray-200 rounded-full place-content-stretch z-20"
				onclick="showActingRoleList(${applyment.artworkId}, 1 )">
				<c:choose>
					<c:when
						test="${applyment.artworkFileUrl != '' || applyment.artworkFileUrl != null}">
						<div class="relative padding-bottom-50 overlow-hidden">
							<img
								class="absolute top-0 left-0 text-white w-full h-full flex justify-center items-center rounded-full"
								src="${applyment.artworkFileUrl}" alt="" />
							<c:if test="${applyment.result != 0}">
								<div
									class="absolute top-0 left-0 w-full h-full flex justify-center items-center rounded-full text-white bg-black opacity-60 text-xl">마감</div>
							</c:if>
						</div>
					</c:when>
					<c:otherwise>
						<div class="relative padding-bottom-50 overlow-hidden">
							<div
								class="absolute top-0 left-0 bg-gray-400 text-white w-full h-full rounded-full flex justify-center items-center">${applyment.actingRole}</div>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="grid items-center">
					<div>
						<div class="font-black text-sm">${applyment.artworkTitle}</div>
					</div>

				</div>
				<div
					class="relative flex justify-center items-center font-myAudition text-gray-600 pr-12">
					<div class="absolute text-black text-sm top-0 right-0"
						onclick="doDeleteAllApplyment()">
						<i class="fas fa-times"></i>
					</div>
				</div>
			</div>
			<c:set var="actingRoleBg" value="bg-gray-showMyPage"></c:set>
			<div id="artwork-left-background${applyment.artworkId}"
				class="absolute bottom-0 left-0 ${actingRoleBg} h-1/2 w-1/2 hidden z-10"></div>
			<div id="artwork-right-background${applyment.artworkId}"
				class="absolute bottom-0 right-0 ${actingRoleBg} h-1/2 w-1/2 hidden z-10"></div>
		</div>
		<div
			class="actingRoleList flex justify-center items-center text-gray-600 ">
			<!-- 각각의 작품에 해당하는 배역목록을 보여줌  -->
			<div id="actingRoleList${applyment.artworkId}"
				data-display-status="-1"
				class="flex-col flex-grow hidden ${actingRoleBg} p-4 rounded-b-lg leading-10 text-sm">
			</div>
		</div>
	</c:forEach>
</div>

<div id="applyment-reply-modal" class="modal-background pt-8 items-center">
	<div id="applyment-reply" class="modal-content" ></div>
</div>

<div id="applyment-modify-modal" class="modal-background pt-8 items-center">
	<div id="applyment-modify" class="modal-content-no-bg bg-black z-20"></div>
</div>

<script>
	//회원모달창 켜졌을경우 외부영역 클릭 시 팝업 닫기
	$('.modal-background').mouseup(function(e) {
		if ($('.modal-content').has(e.target).length === 0
				&& $('.modal-content-no-bg').has(e.target).length === 0) {
			$('.modal-background').css("display", "none");
		}
	});
	
	var applyments = new Map();
	
	function showReplyFromDirector(result){
		if(result == 1){
			$('#applyment-reply').html('<div class="flex justify-center items-center py-8">저희가 찾는 이미지와는 맞는 관계로 1차 합격되었습니다.</br> 2차 면접관련해서 추후 연락드리겠습니다.</div>');
		}else{
			$('#applyment-reply').html('<div class="flex justify-center items-center py-8">이번 작품에 함께하지 못해서 아쉽습니다.</br> 지원해주셔서 진심으로 감사합니다.</div>');
		}
		
		$('#applyment-reply-modal').css("display", "flex");
	}
	
	var videoFileUrl = "";
	
	function showModifyModal(applymentId){
		
		$.ajax({
			url:'../../usr/file/getFileByApplymentIdAjax',
			data : { relId : applymentId ,
				relTypeCode : "applyment"},
			dataType : 'json',
			}).then(function(data){
				
				videoFileUrl = data.body.file.forPrintGenUrl;
		
				html = '';
				html += '<div class="grid" style="grid-templates-row : 30px auto auto">';
				html += '<div class="flex justify-end items-center text-white" >';
				html += '<div class="p-4" onclick="closeModal()"><i class="fas fa-times"></i></div>';
				html += '</div>';
				html += '<video id="actingRole-video" controls src=' + videoFileUrl + '></video>';
				html += '<div class="flex justify-around text-white py-8">';
				html += '<input type="text" class="w-0 h-0" name="videoStatus" value="0" />';
				html += '<label for="actingRole-video-input">';
				html += '<input id="actingRole-video-input" type="file" class="text-sm cursor-pointer hidden " name="file__applyment__'+ applymentId +'__common__attachment__1" accept="${appConfig.getAttachemntFileInputAccept("video")}" />';
				html += '<div id="guide-video" class=" text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600">';
				html += '오디션영상 교체하려면 클릭(※평가자가 동영상확인후에는 교체불가※)</div>';
				html += '</label>';
				html += '<div><button class=" text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600" onclick="modifyApplymentVideo('+ applymentId +')">수정</button></div>';
				html += '</div>';
				html += '</div>';
				
				$('#applyment-modify').html(html);
				
				$('#applyment-modify-modal').css("display", "flex");
				
				//오디션가이드영상 올릴시 작동
				var videoInput = $('#actingRole-video-input');
				var videoForDisplay = $('#actingRole-video');

				videoInput.on('change', function() {
					
					const files = videoInput[0].files;
					const file = videoInput[0].files[0];
					
					if(files.length != 0){
						const fileName = file.name;
						const videourl = URL.createObjectURL(file);
						
						videoForDisplay.attr("src", videourl);
						
						videoForDisplay.on('loadedmetadata',function(){
							var duration =  Math.floor(videoForDisplay[0].duration);
							var oneMinute = Math.floor(videoForDisplay[0].duration > 60 ? videoForDisplay[0].duration/60 : 0);
							
							// 동영상 재생시간이 1분 30초 이상이 넘어간다면 초기화 후,알림창띄움
							if(duration > 90){
								$('input[name="videoStatus"]').val(0);
								alert('동영상이 1분 30초를 넘겨서는 안됩니다!');
								
								videoInput.val("");
								videoForDisplay.attr("src", videoFileUrl);
								URL.revokeObjectURL(file);
								
								//jquery html이 동작이 안되서 약간 동작을 이후에 해줌
								setTimeout(() => {
									$("#guide-video").html("오디션영상 교체하려면 클릭(※평가자가 동영상확인후에는 교체불가※)");
								}, 100);
								
								return;
								
							}else{
								$('input[name="videoStatus"]').val(1);
								$("#guide-video").html("파일이름 : " + fileName + "<br>" + "총 재생시간 : "
										+ (oneMinute > 0 ? oneMinute + "분 " : "") + 
								(duration - oneMinute * 60) + "초");
								
							}
						});

					} else {
						//파일이 없는 경우 내용을 지워준다.
						$('input[name="videoStatus"]').val(0);
						videoForDisplay.attr("src", videoFileUrl);
						URL.revokeObjectURL(file);
						
						videoForDisplay.on('loadedmetadata',function(){
							$("#guide-video").html("오디션영상 교체하려면 클릭(※평가자가 동영상확인후에는 교체불가※)");
						});
					}
				});
			
			});
		
	}
	
	function closeModal(){
		$('.modal-background').css("display", "none");
	}
	
	function modifyApplymentVideo(applymentId){
		if($('.toast')){
			window.toastr.remove();
		}
		
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}
		
		if ($('input[name=videoStatus]').val() != 1) {
			$('input[name=videoStatus]').focus();
			
			var msg = "지원자 영상을 업로드해주세요";
			var targetName = "videoStatus"
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			
			return;
		}

		function startUploadFiles(applymentId) {
			
			var fileUploadFormData = new FormData();

			fileUploadFormData.append( $('#actingRole-video-input').attr("name") + "",$('#actingRole-video-input')[0].files[0]);
			
			for (var pair of fileUploadFormData.entries()) {
                console.log(pair[0]+ ', ' + pair[1]); 
            }
			
			$.ajax({
				url : './../file/doUploadAjax',
				data : fileUploadFormData,
				processData : false,
				contentType : false,
				dataType : "json",
				type : 'POST',
				success : function(data){
					alert(data.msg);
				}
			});
		}
		
		startUploadFiles(applymentId);
		
	}
	
	var totalCount = 0;
	var actingRoleIds = new Array();
	
	function showActingRoleList(artworkId, page) {

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
			url:'../../usr/applyment/getApplymentsByArtworkIdAjax',
			data : { artworkId : artworkId},
			dataType : 'json',
			}).then(function(data){
				totalCount = data.body.applyments.length;
				actingRoles = data.body.applyments;
				drawActingRoleList(artworkId, page);
			});
		
	}
	
	function drawActingRoleList(artworkId, page){
		
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
				html += '<div class="flex justify-start items-center flex-grow"  onclick="showModifyModal(' + actingRole.id + ')">';
				html += '<div class="grid justify-items-start" style="grid-template-columns: minmax(30px,40px) minmax(30px,50px) minmax(30px,50px);">';
				html += '<div class=" text-center overflow-ellipsis overflow-hidden whitespace-nowrap ">'+ actingRole.actingRole +'</div>';
				html += '<div class=" text-center overflow-ellipsis overflow-hidden whitespace-nowrap ">'+ actingRole.actingRoleStartDate.split(" ")[0] + ' ~ ' + actingRole.actingRoleEndDate.split(" ")[0] + '</div>';
				html += '</div>';
				html += '</div>';
				html += '<div class="bg-gray-500 hover:bg-gray-700 text-white text-xs font-thin rounded-full py-1 px-2" style="background-color : #58595B">';
				if(actingRole.result == 0 ){
					html += '<div class="flex justify-center items-center" >';
					html += '<i class="fas fa-bell"></i>';
					html +=	'<div class="pl-1">0</div>';	
				}else{
					html += '<div class="flex justify-center items-center" onclick="javscript:showReplyFromDirector(${applyment.result})">';
					html += '<i class="fas fa-bell text-yellow-600"></i>';		
					html += '<div class="pl-1">1</div>';	
				}				
				html += '</div>';
				html += '</div>';
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
				pageHtml += '<span class="bg-white border-gray-300 text-red-500 hover:bg-red-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium" data-page="'+ i +'" onclick="changeActingRoleListPage('+ artworkId +','+ i + ')">'+ i +'</span>';	
			}else{
				pageHtml += '<span class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium" data-page="'+ i +'" onclick="changeActingRoleListPage('+ artworkId +','+ i +')">'+ i +'</span>';	
			}
		}

		$('#pagination'+ artworkId).append(pageHtml);
		
		var currentPage = $('#pagination'+ artworkId).find('span.text-red-500').data("page");
		
		var previousPage = parseInt(currentPage) - 1;
		
		var previousPageHtml = '<span id="previousPage" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (previousPage < pageMenuStart ? pageMenuStart : previousPage) + ')">';
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
		var limitTake = limitStart + itemsInAPage;
		
		$('#actingRoleList'+ artworkId).empty();
		
		var html = '';
		
		$.each(actingRoles, function(index, actingRole){
			if(limitStart <= index && limitTake > index ){
				
				html += '<div class="flex justify-between items-center mb-2 font-black border-dashed border-b border-black" style="border-color : #58595B">';
				html += '<div class="flex justify-start items-center flex-grow"  onclick="showModifyModal()">';
				html += '<div class="grid justify-items-start" style="grid-template-columns: minmax(30px,40px) minmax(30px,50px) minmax(30px,50px);">';
				html += '<div class=" text-center overflow-ellipsis overflow-hidden whitespace-nowrap ">'+ actingRole.actingRole +'</div>';
				html += '<div class=" text-center overflow-ellipsis overflow-hidden whitespace-nowrap ">'+ actingRole.actingRoleStartDate.split(" ")[0] + ' ~ ' + actingRole.actingRoleEndDate.split(" ")[0] + '</div>';
				html += '</div>';
				html += '</div>';
				html += '<div class="bg-gray-500 hover:bg-gray-700 text-white text-xs font-thin rounded-full py-1 px-2" style="background-color : #58595B">';
				if(actingRole.result == 0 ){
					html += '<div class="flex justify-center items-center" >';
					html += '<i class="fas fa-bell"></i>';
					html +=	'<div class="pl-1">0</div>';	
				}else{
					html += '<div class="flex justify-center items-center" onclick="javscript:showReplyFromDirector(${applyment.result})">';
					html += '<i class="fas fa-bell text-yellow-600"></i>';		
					html += '<div class="pl-1">1</div>';	
				}				
				html += '</div>';
				html += '</div>';
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
				pageHtml += '<span class="bg-white border-gray-300 text-red-500 hover:bg-red-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium" data-page="'+ i +'" onclick="changeActingRoleListPage('+ artworkId +','+ i +')">'+ i +'</span>';	
			}else{
				pageHtml += '<span class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium" data-page="'+ i +'" onclick="changeActingRoleListPage('+ artworkId +','+ i + ')">'+ i +'</span>';	
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
		
		var nextPageHtml = '<span id="nextPage" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (nextPage > totalPage ? totalPage : nextPage) + ')">';
		nextPageHtml += '<i class="fas fa-caret-right"></i>';
		nextPageHtml += '</span>';
		
		$('#pagination'+ artworkId).append(nextPageHtml);
		
		var pageMobileHtml = '<span class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (previousPage < pageMenuStart ? pageMenuStart : previousPage) + ')">';
		pageMobileHtml += 'Previous';
		pageMobileHtml += '</span>';
		pageMobileHtml += '<span class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50" onclick="changeActingRoleListPage('+ artworkId +','+ (nextPage > totalPage ? totalPage : nextPage) + ')">';
		pageMobileHtml += 'Next';
		pageMobileHtml += '</span>';
		
		$('#pagination-mobile'+ artworkId).prepend(pageMobileHtml);
	
	}

</script>

<%@ include file="../part/foot.jspf"%>