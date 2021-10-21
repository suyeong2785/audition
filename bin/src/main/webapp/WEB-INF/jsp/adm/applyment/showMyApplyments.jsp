<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../../usr/part/head.jsp"%>

<div class="grid justify-center grid-column-auto-800 ">
	<c:set var="artworkTitle"
		value="${fn:replace(fn:replace(artworkTitle,'(*(','['),')*)',']')}"></c:set>
	<div>
		<div style="height: 93px;">
			<div
				class="relative w-full h-full font-bold text-center flex items-center pl-4"
				style="background-image: url('${artworkFileUrl}');
				background-repeat : no-repeat;
				background-size : 100%;
				background-position: center center;">
				<div
					class="absolute bottom-0 right-0 bg-black bg-opacity-50 w-full h-full z-10"></div>
				<div
					class="absolute top-0 right-0 pt-3 pr-4 z-20 text-lg text-white">
					<a href="javascript:window.history.back();">
						<i class="fas fa-times"></i>
					</a>
				</div>
				<div
					class="absolute flex flex-col items-start font-thin text-white z-20 text-lg">
					<div>${artworkId}/${artworkTitle}</div>
					<div>${actingRoleGender}${actingRole}${actingRoleAge}</div>
				</div>
			</div>
		</div>
		<div
			class="grid justify-items-start bg-gray-300 p-4 text-center font-bold  "
			style="grid-template-rows: repeat(2, minmax(0, 1fr)); background-color: #EFEFEF;">
			<div class="text-sm">평가 참여자</div>
			<div>
				<c:forEach items="${shares}" var="share">
					<span class="text-sm">${share.extra.memberName}</span>
				</c:forEach>
			</div>
		</div>
		<div class="p-8 text-center text-sm">지원자의 영상을 확인하시고 X버튼을 누르시면
			탈락처리되고 목록에서 삭제 됩니다.</div>
	</div>

	<div
		class="applymentList-box flex flex-col mb-4 border-gray-300 border-t-2 border-b-2 boder-opacity-25 first:border-t-0 mx-2">
		<c:forEach items="${applyments}" var="applyment" varStatus="status">
			<div
				class="artworkList-box z-20 grid gap-x-2.5 py-4 place-content-stretch border-gray-300 ${status.first == false ? 'border-t-2' : '' } boder-opacity-25 "
				style="grid-template-columns: minmax(100px, 140px) minmax(80px, auto) 50px;">
				<c:choose>
					<c:when
						test="${applyment.forPrintGenUrlForMember != null && applyment.forPrintGenUrlForMember != ''}">
						<div id="img-box${applyment.id}" class=" relative overlow-hidden"
							style="padding-bottom: 56.25%">
							<img
								class="absolute top-0 left-0 w-full h-full flex justify-center items-center object-cover"
								src="${applyment.forPrintGenUrlForMember}" alt="" />
						</div>
					</c:when>
					<c:when
						test="${applyment.forPrintGenUrlForMember == null || applyment.forPrintGenUrlForMember == ''}">
						<c:set var="bgColor" value="bg-gray-200"></c:set>
						<div class="relative overlow-hidden"
							style="padding-bottom: 56.25%">
							<div
								class="${bgColor} absolute top-0 left-0 w-full h-full  flex justify-center items-center">사진x</div>
						</div>
					</c:when>
				</c:choose>

				<div class="flex flex-col justify-center">
					<div class="font-black text-sm pb-2">${applyment.extra.memberName}</div>
					<div class="writer text-sm">
						<div>
							<i class="fas fa-heart"></i>
							${applyment.extra.memberRecommendation}
						</div>
					</div>
				</div>
				<div>
					<div
						class="flex justify-center items-center h-full text-4xl text-gray-600 pr-4"
						onclick="showApplymentModal('${applyment.forPrintGenUrlForApplyment}',${applyment.id},${applyment.memberId},${applyment.extra.memberRecommendation},${actingRoleId},'${actingRole}',${artworkId},'${artworkTitle}','${applyment.extra.memberName}')">
						<i class="fas fa-play-circle"></i>
					</div>
				</div>
				<c:set var="actingRoleBg" value="bg-gray-300"></c:set>
			</div>

			<div
				class="actingRoleList flex justify-center items-center text-gray-600 ">
				<!-- 각각의 작품에 해당하는 배역목록을 보여줌  -->
				<div id="actingRoleList${applyment.id}" data-display-status="-1"
					class="flex-col flex-grow hidden ${actingRoleBg} p-4 rounded-b-3xl leading-10">
				</div>
			</div>
		</c:forEach>
	</div>

</div>
<div id="applyment-decision-modal" class="modal-background">
	<div class="modal-content-applyments flex flex-col self-start">
		<div id="recommendation"
			class="flex justify-between items-center text-sm text-white bg-black py-2 px-2">
			<div id="recommendation-count" class="flex items-center ">
				<i class="fas fa-heart"></i>
			</div>
			<div class="text-white" onclick="closeModal()">
				<i class="fas fa-times"></i>
			</div>
		</div>
		<div id="video-box" class="flex justify-center"></div>
		<div id="button-box" class="button-box flex justify-around px-8 py-4 " style="background-color: #333333"></div>
	</div>
</div>


<script>
	var loginedMemberId = '<c:out value="${loginedMemberId}" />';
	
	//회원모달창 켜졌을경우 외부영역 클릭 시 팝업 닫기
	$('.modal-background').mouseup(
			function(e) {
				if ($('.modal-content-applyments').has(e.target).length === 0) {
					$('.modal-background').css("display", "none");
				}
			});

	function showApplymentModal(videoUrl, applyment_id, applyment_memberId, applyment_recommendation, actingRole_id, actingRole, artwork_id, artwork_title, applyment_name) {
		$('#video-box').empty();
		$('#button-box').empty();
		$('#recommendation-number').remove();
		 
		$('#applyment-decision-modal').data('applyment_id', applyment_id);
		$('#applyment-decision-modal').data('applyment_memberId', applyment_memberId); 
		$('#applyment-decision-modal').data('applyment_recommendation', applyment_recommendation);
		 
		let html = '';
		
		html += '<button id="recommendation-button" class="bg-white text-black rounded-full w-12 h-12 text-2xl" style="color: #333333" onclick="doRecommendMember()">';
		html += '<i class="fas fa-heart"></i>';	
		html += '</button>';	
		html += '<button class="bg-white text-black rounded-full w-12 h-12 text-2xl" style="color: #333333" onclick="ChangeApplymentResult(1,' + applyment_memberId + ',' + actingRole_id + ',\'' + actingRole + '\',' + artwork_id + ',\'' +artwork_title + '\')">';
		html += '<i class="far fa-circle"></i>';				
		html += '</button>';
		html += '<button class="bg-white text-black rounded-full w-12 h-12 text-2xl" style="color: #333333" onclick="ChangeApplymentResult(2,' + applyment_memberId + ',' + actingRole_id + ',\'' + actingRole + '\',' + artwork_id + ',\'' + artwork_title + '\')">';	
		html += '<i class="fas fa-times"></i>';
		html += '</button>';
		
		$('#button-box').html(html);
		
		$('#applyment-decision-modal').css("display", "flex");
		
		var $recommendation_button = $("#recommendation-button");
	  	
	  	  $.get('../../usr/recommendation/getForPrintRecommendationsByRecommendeeIdAjax',{
	  		  recommendeeId : applyment_memberId
	  	  },function(data){
	  		  
	  		  if(data != null && data.body != null){
	  			  var recommendations = data.body.recommendations;
		  		  
		  		  if(data.resultCode.startsWith("S")){
			  		  for(var i = 0; i < recommendations.length; i++ ){
			  			  
			  				if(recommendations[i].recommenderId == loginedMemberId){
					  			var recommendationStatus = data.body.recommendations[i].recommendationStatus;
					  			  
					  			if(recommendationStatus == 1 ){
					  				$recommendation_button.css({"background-color" : "green","color" : "white"});
					  				$recommendation_button.data("recommendationStatus", recommendationStatus);
					  			}else{
					  				$recommendation_button.data("recommendationStatus",recommendationStatus);
					  				$recommendation_button.css({"background-color" : "white","color" : "black"});
					  			}
			  			  	}
			  		  }
		  		  }
	  		  }
	  		  
	  	  },'json');

		if (videoUrl == '' || videoUrl == null) {
			$('#video-box').html('<div class="p-8">오디션 영상이 등록되어 있지않습니다.</div>');
		} else {
			$('#video-box').html('<video id="video" controls="controls" src="'+ videoUrl +'"></video>');
		}

		let recommenderHtml = '';

		$('#recommendation-count').append('<div id="recommendation-number" class="pl-2">' + applyment_recommendation + ' ' + applyment_name + '</div>');	
		 
	}

	function doRecommendMember() {
		
		let applyment_id = $('#applyment-decision-modal').data("applyment_id");
		let applyment_memberId = $('#applyment-decision-modal').data("applyment_memberId");
		let applyment_name = $('#applyment-decision-modal').data("applyment_name");
		
		//video태그를 보여줄 id=recommendation-button 엘리먼트를 가져온다.
		var $recommendation_button = $("#recommendation-button");

		if ($recommendation_button.data("recommendationStatus") == 1) {

			$.post('../../usr/recommendation/doModifyRecommendStatusAjax', {
				relTypeCode : "applyment",
				relId : applyment_id,
				recommenderId : loginedMemberId,
				recommendeeId : applyment_memberId,
				recommendationStatus : 0
			}, function(data) {
				if(data.resultCode.startsWith("S")){
					$recommendation_button.css({
						"background-color" : "white",
						"color" : "black"
					});
					
					$recommendation_button.data("recommendationStatus", 0);
					
				}
			}, 'json');

		} else if ($recommendation_button.data("recommendationStatus") == 0) {

			$.post('../../usr/recommendation/doModifyRecommendStatusAjax', {
				relTypeCode : "applyment",
				relId : applyment_id,
				recommenderId : loginedMemberId,
				recommendeeId : applyment_memberId,
				recommendationStatus : 1
			}, function(data) {
				if(data.resultCode.startsWith("S")){
					$recommendation_button.css({
						"background-color" : "green",
						"color" : "white"
					});
					
					$recommendation_button.data("recommendationStatus", 1);
				}
			}, 'json');

		} else {

			$.post('../../usr/recommendation/doMakeRecommendMemberAjax', {
				relTypeCode : "applyment",
				relId : applyment_id,
				recommenderId : loginedMemberId,
				recommendeeId : applyment_memberId,
				recommendationStatus : 1
			}, function(data) {
				$recommendation_button.css({
					"background-color" : "green",
					"color" : "white"
				});
				$recommendation_button.data("recommendationStatus", 1);
			}, 'json');
		}

	}
	
	function ChangeApplymentResult(result, applyment_memberId, actingRole_id ,actingRole, artwork_id, artwork_title) {
		var artworkTitle = '<c:out value="${artworkTitle}"/>';
		var actingRole = '<c:out value="${actingRole}"/>';
		
		var id = $('#applyment-decision-modal').data("applyment_id");
		
		// result : 1 (합격)
		if(result == 1){
			if (confirm('합격 시키겠습니까?') == true) {
				$.post('../../usr/applyment/doChangeApplymentResultAjax',{
					id : id,//relId
					relId : actingRole_id,
					relName : actingRole,
					relTypeCode : "actingRole",
					extraId : artwork_id,
					extraName : artwork_title,
					extraTypeCode : "artwork",
					getterId : applyment_memberId,
					senderId : loginedMemberId,
					result : result,
					message : "저희가 찾는 이미지와는 맞는 관계로 1차 합격되었습니다. 2차 면접관련해서 추후 연락드리겠습니다"
				},function(data){
					alert(data.msg);
					
					location.reload();
				},'json');
	            
	        }
		} else{
			// result : 2 (불합격)
			if (confirm('불합격 시키겠습니까?') == true) {
				$.post('../../usr/applyment/doChangeApplymentResultAjax',{
					id : id, //relId
					relId : actingRole_id,
					relName : actingRole,
					relTypeCode : "actingRole",
					extraId : artwork_id,
					extraName : artwork_title,
					extraTypeCode : "artwork",
					getterId : applyment_memberId,
					senderId : loginedMemberId,
					result : result,
					message : "이번 작품에 함께하지 못해서 아쉽습니다. 지원해주셔서 진심으로 감사합니다."
				},function(data){
					alert(data.msg);
				
					location.reload();
				},'json');

	        }
		}

	} 
	
	function closeModal(){
		$('.modal-background').css("display", "none");
	}

</script>


<%@ include file="../part/foot.jsp"%>