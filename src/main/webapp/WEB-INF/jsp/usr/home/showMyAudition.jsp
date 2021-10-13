<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../part/head.jspf"%>

<div class="grid justify-center grid-column-auto-800 p-4 ">

	<div class="flex justify-between py-8">
		<div class="text-center ">내가지원한 오디션</div>
		<div class="text-center ">정렬</div>
	</div>

	<c:forEach items="${applyments}" var="applyment">
		<div id="artwork-box${applyment.extra.artworkId}"
			class="relative  flex flex-col mt-4">
			<div id="artwork${applyment.extra.artworkId}"
				class=" grid grid-columns-myAudition grid-row-myAudition gap-x-2.5 bg-gray-100 place-content-stretch bg-gray-200 rounded-full place-content-stretch z-20"
				onclick="showActingRoleList(${applyment.extra.artworkId}, 1 )">
				<c:choose>
					<c:when test="${applyment.extra.artworkGenre == 'action'}">
						<c:set var="bgColor" value="bg-red-200"></c:set>
					</c:when>
					<c:when test="${applyment.extra.artworkGenre == 'SF'}">
						<c:set var="bgColor" value="bg-indigo-600"></c:set>
					</c:when>
					<c:when test="${applyment.extra.artworkGenre == 'comedy'}">
						<c:set var="bgColor" value="bg-yellow-500"></c:set>
					</c:when>
					<c:when test="${applyment.extra.artworkGenre == 'thriller'}">
						<c:set var="bgColor" value="bg-purple-300"></c:set>
					</c:when>
					<c:when test="${applyment.extra.artworkGenre == 'war'}">
						<c:set var="bgColor" value="bg-gray-700"></c:set>
					</c:when>
					<c:when test="${applyment.extra.artworkGenre == 'sports'}">
						<c:set var="bgColor" value="bg-blue-500"></c:set>
					</c:when>
					<c:when test="${applyment.extra.artworkGenre == 'fantasy'}">
						<c:set var="bgColor" value="bg-purple-600"></c:set>
					</c:when>
					<c:when test="${applyment.extra.artworkGenre == 'music'}">
						<c:set var="bgColor" value="bg-green-500"></c:set>
					</c:when>
					<c:when test="${applyment.extra.artworkGenre == 'romance'}">
						<c:set var="bgColor" value="bg-pink-400"></c:set>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when
						test="${applyment.forPrintGenUrl != '' && applyment.forPrintGenUrl != null}">
						<div class="relative padding-bottom-50 overlow-hidden">
							<img
								class="artwork-image absolute top-0 left-0 text-white w-full h-full flex justify-center items-center rounded-full"
								src="${applyment.forPrintGenUrl}" alt="" />
						</div>
					</c:when>
					<c:otherwise>
						<div class="relative padding-bottom-50 overlow-hidden">
							<div
								class="absolute top-0 left-0 ${bgColor} text-white w-full h-full rounded-full flex justify-center items-center text-center overflow-ellipsis overflow-hidden break-words">${applyment.extra.artworkGenre}</div>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="grid items-center">
					<div>
						<div class="font-black text-sm">${applyment.extra.artworkTitle}</div>
					</div>

				</div>
				<div
					class="relative flex justify-center items-center font-myAudition text-gray-600 pr-12">
					<div class="absolute text-black text-sm top-0 right-0"
						onclick="doDeleteAllApplyment()"></div>
				</div>
			</div>
			<c:set var="actingRoleBg" value="bg-gray-showMyPage"></c:set>
			<div id="artwork-left-background${applyment.extra.artworkId}"
				class="absolute bottom-0 left-0 ${actingRoleBg} h-1/2 w-1/2 hidden z-10"></div>
			<div id="artwork-right-background${applyment.extra.artworkId}"
				class="absolute bottom-0 right-0 ${actingRoleBg} h-1/2 w-1/2 hidden z-10"></div>
		</div>
		<div id="actingRoleList-box-by-artwork${applyment.extra.artworkId}"
			class="flex justify-center items-center text-gray-600 ">
			<!-- 각각의 작품에 해당하는 배역목록을 보여줌  -->
			<div id="actingRoleList-by-artwork${applyment.extra.artworkId}"
				data-artwork-id="${applyment.extra.artworkId}"
				data-display-status="-1"
				class="flex-col flex-grow hidden ${actingRoleBg} p-4 rounded-b-lg leading-10 text-sm">
			</div>
		</div>
	</c:forEach>
</div>

<div id="applyment-reply-modal"
	class="modal-background pt-8 items-center">
	<div class="modal-content">
		<div class="flex justify-end p-2 bg-gray-300">
			<span onclick="closeModal()">
				<i class="fas fa-times"></i>
			</span>
		</div>
		<div id="applyment-reply"></div>
	</div>
</div>

<div id="applyment-modify-modal"
	class="modal-background pt-8 items-center">
	<div id="applyment-modify" class="modal-content-no-bg bg-black z-20"></div>
</div>

<div id="alarm-content" class="flex-col border border-black bg-white rounded-lg z-20 hidden fixed"></div>

<script>
	let actingRoles = new Array();
	let itemsInAPage = 3; 
	
	let actingRoleListRowNumHashMapList = new Array();

	$(function(){
		console.log(param);
		if(param != null){
			
			$.ajax({
				url:'../../usr/applyment/getRowNumbersOfApplymentsByMemberIdAndArtworkIdAjax',
				data : { artworkId : param.artworkId ,
					memberId : loginedMemberId},
				method : "GET",
				dataType : "json"
				}).done(function(data){
					console.log(data.body.actingRoleListRowNumHashMapList);
					
					actingRoleListRowNumHashMapList = data.body.actingRoleListRowNumHashMapList;
					
					for( let i = 0; i < actingRoleListRowNumHashMapList.length; i++){
						if( actingRoleListRowNumHashMapList[i]["actingRoleId"] == param.roleId){
							let page = Math.ceil( actingRoleListRowNumHashMapList[i]["rownum"] / itemsInAPage );
							//console.log("page : "+ page);
							
							$.ajax({
								url:'../../usr/applyment/getActingRolesRelatedToApplymentByArtworkIdAjax',
								data : { artworkId : param.artworkId,
									getterId : loginedMemberId,
									relTypeCode : "actingRole"},
								dataType : 'json',
								}).then(function(data){
									totalCount = data.body.applyments.length;
									actingRoles = data.body.applyments;
									notifications = data.body.notifications;
									
									let actingRolesIndex = -1;
									
									for(let i = 0; i < actingRoles.length; i++){
										
										let notificationsArray = new Array();
										
										for(let j = 0; j < notifications.length; j++){
											if(actingRoles[i].relId == notifications[j].relId){
												notificationsArray.push(notifications[j]);
												if(actingRoles[i].relId == param.roleId){
													actingRolesIndex = i;
												}
											}
										}
										
										if(notificationsArray.length > 0){
											actingRoles[i]["notifications"] = notificationsArray;
										}
									}
									
									if(actingRoles[actingRolesIndex] && typeof actingRoles[actingRolesIndex]["notifications"] != "undefined"){
										let notifiactions = actingRoles[actingRolesIndex]["notifications"];	
										
										if(notifiactions.length > 0){
											drawActingRoleList(param.artworkId, page);
											changeActingRoleListPage(param.artworkId, page);
											$('#actingRole-alarm-box' + param.roleId).addClass('scale-alarm');
											$('#actingRole-alarm-box' + param.roleId).on("click",function(){
												$('#actingRole-alarm-box' + param.roleId).removeClass('scale-alarm');
											});
										}
									}
								});
						}
					}
						
				});
		};
	});
	
	//회원모달창 켜졌을경우 외부영역 클릭 시 팝업 닫기
	$(document).mouseup(function(e) {
		if ($('.modal-content').has(e.target).length === 0
				&& $('.modal-content-no-bg').has(e.target).length === 0) {
			$('.modal-background').css("display", "none");
		}
		
		if ($('.modal-content').has(e.target).length === 0
				&& $('.modal-content-no-bg').has(e.target).length === 0) {
			$('.modal-background-no-bg').css("display", "none");
		}
		
		if($('#alarm-content').has(e.target).length === 0 
			&& $(e.target).is('#alarm-content') == false
			&& $('#applyment-reply-modal').has(e.target).length === 0
			&& $(e.target).is('#applyment-reply-modal') == false){
			$('#alarm-content').css("display", "none");
		}
		
		if ($('[id^="artwork-box"]').has(e.target).length === 0
				&& $('[id^="actingRoleList-box-by-artwork"]').has(e.target).length === 0
				&& $('.modal-background').has(e.target).length === 0
				&& $(e.target).hasClass('modal-background') == false 
				&& $('#alarm-content').has(e.target).length === 0 
				&& $(e.target).is('#alarm-content') == false) {
			closeActingRoleList();
		}
	});

	var applyments = new Map();
	
	function showAlarmBoxModal(actingRoleindex, actingRoleId){
		let actingRole = actingRoles[actingRoleindex];
		let notifications = actingRole.notifications;
		
		if(notifications && notifications.length > 0 ){
			
			let html = '';
			
			$.each(notifications,function(index, notification){
				html += '<div id="applyment-notification-'+ notification.id +'" class="flex justify-center items-center m-2" onclick="showMessageModal('+ actingRoleindex + ','+ notification.id +',' + actingRoleId +','+ index + ')">';
				html += '<span>확인해주세요.</span>';
				html += '<i class="fas fa-envelope"></i>';
				html += '</div>';
			});
			
			$('#alarm-content').html(html);
			
			$('#alarm-content').css("display", "inline-flex");
			
			alarmBellCoordinate = $('#actingRole-alarm-box' + actingRoleId).offset();
			
			let height = alarmBellCoordinate.top - $('#alarm-content').outerHeight();
			let left = alarmBellCoordinate.left - $('#alarm-content').outerWidth();
			
			$('#alarm-content').offset({left : left, top : height});
		}
		
		
	}
	
	function showMessageModal(actingRoleindex, notificationId, actingRoleId, notificationArrayIndex){
		
		let actingRoleAlarmCount = parseInt($('#actingRole-alarm-count' + actingRoleId).text()) - 1;
		
		if(actingRoleAlarmCount == 0){
			$('#applyment-notification-' + notificationId).remove();
			
			$('#actingRole-alarm-bell'+ actingRoleId).attr({"style" : ""});
			$('#actingRole-alarm-bell'+ actingRoleId + ' > i').removeClass('text-yellow-600');

			$('#actingRole-alarm-count' + actingRoleId).text(actingRoleAlarmCount);	
		}else{
			$('#applyment-notification-' + notificationId).remove();

			$('#actingRole-alarm-count' + actingRoleId).text(actingRoleAlarmCount);
		}
		
		let actingRole = actingRoles[actingRoleindex];
		let notifications = actingRole.notifications;
		
		let html = '';
		
		$.each(notifications, function(index, notification){
			if(notificationId == notification.id){
				html += '<div class="flex justify-center items-center m-2">';
				html += '<span>'+ notification.message +'</span>';
				html += '</div>';
			}
		});
		
		$('#applyment-reply').html(html);		
		
		$('#applyment-reply-modal').css("display", "flex");
		
		$.ajax({
			url:'../../usr/notification/changeNotificationCheckStatusAjax',
			data : { id : notificationId,
				checkStatus : 1 },
			dataType : 'json'
		}).then(function(){
			notifications.splice(notificationArrayIndex,1);
			
			actingRoles[actingRoleindex] = actingRole;
		});
	}
	
	function showAlternativeImage(){
		$(".artwork-image").attr("src", "/resource/img/logoForLogin.svg");
		$(".artwork-image").css({"background-color" : "gray"});
	}
	
	var videoFileUrl = "";
	
	function showModifyModal(applymentId, actingRoleId){
		
		var delStatus = $('#actingRole-detail-box'+ actingRoleId).data("delStatus");
		var result = $('#actingRole-detail-box'+ actingRoleId).data("result");
		
		if( delStatus == false  && result == 0){
			
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
					html += '<div class="p-4" onclick="closeModal('+ actingRoleId +')"><i class="fas fa-times"></i></div>';
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
	
		}else{
			if($('.toast')){
				window.toastr.remove();
			}
			
			var msg = "업로드 영상이 존재하지 않습니다.";
			var targetName = "actingRole-detail-box" + actingRoleId;
			var targetType = "id";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
		}
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

		$('[id^="actingRoleList-by-artwork"]').not('#actingRoleList-by-artwork'+ artworkId).css("display","none");
		$('[id^="actingRoleList-by-artwork"]').not('#actingRoleList-by-artwork'+ artworkId).data("displayStatus",-1);
		$('[id^="artwork-left-background"]').not('#artwork-left-background'+ artworkId).css("display","none");
		$('[id^="artwork-right-background"]').not('#artwork-right-background'+ artworkId).css("display","none");

		if($('#actingRoleList-by-artwork'+ artworkId).data("displayStatus") == 1){
			$('#actingRoleList-by-artwork'+ artworkId).data("displayStatus", -1);
			$('#actingRoleList-by-artwork'+ artworkId ).css("display","none");
			$('#artwork-left-background'+ artworkId).css("display","none");
			$('#artwork-right-background'+ artworkId).css("display","none");
			
			return;
		}
		
		$.ajax({
			url:'../../usr/applyment/getActingRolesRelatedToApplymentByArtworkIdAjax',
			data : { artworkId : artworkId,
				getterId : loginedMemberId,
				relTypeCode : "actingRole" },
			dataType : 'json',
			}).then(function(data){
				totalCount = data.body.applyments.length;
				actingRoles = data.body.applyments;
				notifications = data.body.notifications;
				
				for(let i = 0; i < actingRoles.length; i++){
					
					let notificationsArray = new Array();
					
					for(let j = 0; j < notifications.length; j++){
						if(actingRoles[i].relId == notifications[j].relId){
							notificationsArray.push(notifications[j]);
						}
					}
					
					if(notificationsArray.length > 0){
						actingRoles[i]["notifications"] = notificationsArray;
					}
				}
				
				drawActingRoleList(artworkId, page);
			});
	}
	
	function closeActingRoleList (){
		
		$('[id^="actingRoleList-by-artwork"]').data('displayStatus' , -1);
		$('[id^="actingRoleList-by-artwork"]').css("display" , "none");
		
		$('[id^="artwork-left-background"]').css("display","none");
		$('[id^="artwork-right-background"]').css("display","none");
		
	}
	
	function drawActingRoleList(artworkId, page){
		
		var limitStart = (page-1) * itemsInAPage ;
		var limitTake = itemsInAPage;
		
		$('#actingRoleList-by-artwork'+ artworkId).empty();
		
		if(actingRoles == null || actingRoles == ''){
			return;
		}
		
		var html = '';
		var actingRoleIds = new Array();
		
		$.each(actingRoles, function(index, actingRole){
			actingRoleIds.push(actingRole.extra.id);
			
			let alarmAnimation = "";
			let alarmColor = "";
			let alaramCount = 0;
			
			if( actingRole.notifications && actingRole.notifications.length > 0){
				alarmAnimation = '<span id="actingRole-alarm-bell' + actingRole.extra.id + '" style="animation:alarm 1s linear 0.5s infinite alternate both">';
				alarmColor = 'text-yellow-600';
				alaramCount = actingRole.notifications.length;
			}else{
				alarmAnimation = '<span id="actingRole-alarm-bell' + actingRole.extra.id + '">';
			}
			
			if(limitStart <= index && limitTake > index ){
				
				html += '<div id="actingRole-detail-box'+ actingRole.extra.id +'" data-result="'+ actingRole.result +'" data-del-status="'+ actingRole.delStatus +'" class="flex justify-between items-center mb-2 font-black border-dashed border-b border-black" style="border-color : #58595B">';
				html += '<div id="actingRole-content-box'+ actingRole.extra.id +' class="flex justify-start items-center flex-grow" >';
				html += '<div class="inline-flex items-center">';
				html += '<div class=" text-center overflow-ellipsis overflow-hidden whitespace-nowrap " style="width:5vmin"  onclick="showModifyModal(' + actingRole.id + ','+ actingRole.extra.id +')">'+ actingRole.extra.role +'</div>';
				html += '<div class=" text-center overflow-ellipsis overflow-hidden whitespace-nowrap " style="width:30vmin"  onclick="showModifyModal(' + actingRole.id + ','+ actingRole.extra.id +')">'+ actingRole.extra.startDate.split("T")[0] + ' ~ ' + actingRole.extra.endDate.split("T")[0] + '</div>';
				html += '<div id="actingRole-cancel-button-'+ actingRole.extra.id +'" class="bg-gray-500 hover:bg-gray-700 text-white text-xs font-thin rounded-full py-1 px-2 whitespace-nowrap" style="background-color : #58595B">지원취소</div>';
				if(actingRole.delStatus == true ) {
					html += '<div id="actingRole-delete-button-'+ actingRole.extra.id +'" class="text-center" style="width:5vmin" ><i class="fas fa-times"></i></div>';
				}
				html += '</div>';
				html += '</div>';
				html += '<div class="flex">';
				html += '<div id="actingRole-alarm-box'+ actingRole.extra.id +'" class="bg-gray-500 hover:bg-gray-700 text-white text-xs font-thin rounded-full py-1 px-2" style="background-color : #58595B">';
				html += '<div class="flex justify-center items-center" onclick="javscript:showAlarmBoxModal('+ index + ',' + actingRole.extra.id + ')">';
				html += alarmAnimation;
				html += '<i class="fas fa-bell '+ alarmColor + '"></i>';
				html += '</span>';	
				html += '<div id="actingRole-alarm-count'+ actingRole.extra.id +'" class="pl-1">'+ alaramCount +'</div>';
				html += '</div>';
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
		
		$('#actingRoleList-by-artwork'+ artworkId).append(html);
		
		$('#actingRoleList-by-artwork'+ artworkId).data("actingRoleIds", actingRoleIds);
		
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
		
		if($('#actingRoleList-by-artwork'+ artworkId).data("displayStatus") == 1){
			$('#actingRoleList-by-artwork'+ artworkId).data("displayStatus", -1);
			$('#actingRoleList-by-artwork'+ artworkId ).css("display","none");
			$('#artwork-left-background'+ artworkId).css("display","none");
			$('#artwork-right-background'+ artworkId).css("display","none");
			
		}else{
			$('#actingRoleList-by-artwork'+ artworkId).data("displayStatus", 1);
			$('#actingRoleList-by-artwork'+ artworkId ).css("display","flex");
			$('#artwork-left-background'+ artworkId).css("display","block");
			$('#artwork-right-background'+ artworkId).css("display","block");
		}
	}
	
	function changeActingRoleListPage(artworkId, page){
		
		var limitStart = (page-1) * itemsInAPage ;
		var limitTake = limitStart + itemsInAPage;
		
		$('#actingRoleList-by-artwork'+ artworkId).empty();
		
		var html = '';
		
		$.each(actingRoles, function(index, actingRole){
			actingRoleIds.push(actingRole.extra.id);
			
			let alarmAnimation = "";
			let alarmColor = "";
			let alaramCount = 0;
			
			if( actingRole.notifications && actingRole.notifications.length > 0){
				alarmAnimation = '<span id="actingRole-alarm-bell' + actingRole.extra.id + '" style="animation:alarm 1s linear 0.5s infinite alternate both">';
				alarmColor = 'text-yellow-600';
				alaramCount = actingRole.notifications.length;
			}else{
				alarmAnimation = '<span id="actingRole-alarm-bell' + actingRole.extra.id + '">';
			}
			
			if(limitStart <= index && limitTake > index ){
				
				html += '<div id="actingRole-detail-box'+ actingRole.extra.id +'" data-result="'+ actingRole.result +'" data-del-status="'+ actingRole.delStatus +'" class="flex justify-between items-center mb-2 font-black border-dashed border-b border-black" style="border-color : #58595B">';
				html += '<div id="actingRole-content-box'+ actingRole.extra.id +' class="flex justify-start items-center flex-grow"  onclick="showModifyModal(' + actingRole.id + ','+ actingRole.extra.id +')">';
				html += '<div class="grid justify-items-start" style="grid-template-columns: minmax(30px,40px) minmax(30px,50px) minmax(30px,50px)">';
				html += '<div class=" text-center overflow-ellipsis overflow-hidden whitespace-nowrap ">'+ actingRole.extra.role +'</div>';
				html += '<div class=" text-center overflow-ellipsis overflow-hidden whitespace-nowrap ">'+ actingRole.extra.startDate.split("T")[0] + ' ~ ' + actingRole.extra.endDate.split("T")[0] + '</div>';
				html += '</div>';
				html += '</div>';
				html += '<div id="actingRole-alarm-box'+ actingRole.extra.id +'" class="bg-gray-500 hover:bg-gray-700 text-white text-xs font-thin rounded-full py-1 px-2" style="background-color : #58595B">';
				html += '<div class="flex justify-center items-center" onclick="javscript:showAlarmBoxModal('+ index + ',' + actingRole.extra.id + ')">';
				html += alarmAnimation;
				html += '<i class="fas fa-bell '+ alarmColor + '"></i>';
				html += '</span>';	
				html += '<div id="actingRole-alarm-count'+ actingRole.extra.id +'" class="pl-1">'+ alaramCount +'</div>';
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
		
		$('#actingRoleList-by-artwork'+ artworkId).append(html);
		
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