<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="오디션 신청관리페이지" />
<%@ include file="../part/head.jspf"%>


<div class="list-box con">
	<div class="flex border-2 border-black box-border p-4">
		<div class=" flex-1">번호</div>
		<div class="flex-4">모집기간</div>
		<div class=" flex-4">배역</div>
	</div>
	<c:forEach items="${recruitments}" var="recruitment">
		<div class="toggle">
			<div class="flex border-2 border-black box-border p-4">
				<div class=" flex-1">${recruitment.id}</div>
				<div class="flex-4">${recruitment.regDate}</div>
				<div class=" flex-4" onclick="showApplicantList(${recruitment.id})">${recruitment.forPrintTitle}</div>
			</div>
			<div class="${recruitment.id} border-2 "></div>
		</div>
	</c:forEach>
</div>

<style>
.applicant-decision-form-modal-actived,
	applicant-decision-form-modal-actived>body {
	overflow: hidden;
}

.applicant-decision-form-modal {
	display: none;
}

.applicant-decision-form-modal-actived .applicant-decision-form-modal {
	display: flex;
}

.applicant-decision-form-modal .video-box {
	width: 800px;
}

.applicant-decision-form-modal .img-box {
	width: 100px;
}
</style>

<div class="popup-1 applicant-decision-form-modal">
	<div class="content">
		<div id="media-content" class="flex justify-center"></div>
		<div class="flex justify-center">
		<button class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow">추천</button>
		<button class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow">보류</button>
		<button class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow">삭제</button>
		<button class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow" onclick="hideApplicantDecisonModal()">닫기</button>
		</div>
	</div>

</div>
<script>

var ApplymentList__lastLodedId = 0;
var ApplymentList__applymentsCount = 0;

	var showApplicantList = function(recruitment_id) {
		
		//displayStatus를 확인하고 displayStatus을 누를때마다 바꿔주면서
		//display:none,block를 결정해준다.
		if($('.' + recruitment_id).data("displayStatus") == 1){
			$('.' + recruitment_id).css({"display":"none"});
			$('.' + recruitment_id).data("displayStatus",0);
			return;
		}
		
		if($('.' + recruitment_id).data("displayStatus") == 0){
			$('.' + recruitment_id).css({"display":"block"});
			$('.' + recruitment_id).data("displayStatus",1);
		}
		
		
		//ajax를 통해 recruitment.id에 해당하는 모든 applyments 객체를 가져와서
		//ApplymentList__loadMoreCallback에 전달한다.
		function ApplymentList__loadMore() {

			$.get('../../usr/applyment/getForPrintApplyments', {
				recruitmentId : recruitment_id,
				from : ApplymentList__lastLodedId + 1
			}, ApplymentList__loadMoreCallback, 'json');
		}
		
		//받아온 applyments객체의 데이터유무 확인하고,가장 마지막의 applyment의 id를
		//ApplymentList__lastLodedId에 기록한다.
		//ApplymentList__drawApplyments에 applyments를 넘겨준다.
		function ApplymentList__loadMoreCallback(data) {
	        
	        if (data.body.applyments && data.body.applyments.length > 0) {
	            ApplymentList__lastLodedId = data.body.applyments[data.body.applyments.length - 1].id;
	            ApplymentList__drawApplyments(data.body.applyments);
	        }
	        
	        return;
		}
		
		//ApplymentList__drawApplyment에 applyment를 뿌려서 화면에 그려낸다.
		function ApplymentList__drawApplyments(applyments) {
			
			for (var i = 0; i < applyments.length; i++) {
				var applyment = applyments[i];
				ApplymentList__drawApplyment(applyment);
			}
		}
	
		//applyment(지원자)의 객체의 id,작성자실제이름,작성자성별,작성자나이를 화면에 그린다.
		// displayStatus를 1로 지정해준다.
		function ApplymentList__drawApplyment(applyment) {

			var ApplymentList__$tr = $('.' + recruitment_id);
			$('.' + recruitment_id).data("displayStatus", 1);
			
			var html = '';
			
			html += '<div onclick="showApplicantDecisonModal(' + applyment.id + ');" class="flex justify-center text-center border-2 border-black box-border p-4">';
			html += '<div class="flex-1">' + applyment.id + '</div>';
			html += '<div class="flex-1">' + applyment.extra.writerRealName + '</div>';
			html += '<div class="flex-1">' + applyment.extra.writerGender + '</div>';
			html += '<div class="flex-1">' + applyment.extra.writerAge + '</div>';
			html += '</div>';
			
			var $td = $(html);

			ApplymentList__$tr.append($td);
		}
		
		showApplicantListStatus = true;
		ApplymentList__loadMore();
	}
	
	var Applyment__lastLodedId = 0;	
	
	function hideApplicantDecisonModal() {
        $('#media-content').empty();
		
        $('html').removeClass('applicant-decision-form-modal-actived');
    }
	
  	function showApplicantDecisonModal(id) {
	  
	  var Applicant__$div = $("#media-content");
	  
	  var html = '';
	  
	  $.get('../../usr/applyment/getForPrintApplyment', {
		 id : id
		}, function (data) {
			
			html += ApplymentList__getMediaHtml(data);
			
			var $div = $(html);
			
			Applicant__$div.prepend($div);
			
		}, 'json');  
	
	  $('html').addClass('applicant-decision-form-modal-actived');
 	}
	  
	
	function ApplymentList__getMediaHtml(data) {
			var applyment = data.body.applyment;	
			
			var html = '';
			for (var fileNo = 1; fileNo <= 3; fileNo++) {
	            var file = null;
	            if (applyment.extra.file__common__attachment && applyment.extra.file__common__attachment[fileNo]) {
	                file = applyment.extra.file__common__attachment[fileNo];
	            }

	            html += '<div class="video-box" data-video-name="applyment__' + applyment.id + '__common__attachment__' + fileNo + '" data-file-no="' + fileNo + '">';

	            if (file && file.fileExtTypeCode == 'video') {
	                html += '<video preload="auto" controls src="' + file.forPrintGenUrl + '"></video>';
	            }

	            html += '</div>';

	            html += '<div class="img-box img-box-auto" data-img-name="applyment__' + applyment.id + '__common__attachment__' + fileNo + '" data-file-no="' + fileNo + '">';

	            if (file && file.fileExtTypeCode == 'img') {
	                html += '<img src="' + file.forPrintGenUrl + '">';
	            }

	            html += '</div>';
	        }

	        return '<div class="media-box">' + html + "</div>";
	}
	
</script>

<%@ include file="../part/foot.jspf"%>