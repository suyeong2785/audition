<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="오디션 신청관리페이지" />
<%@ include file="../part/head.jspf"%>

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
<div class="con mx-auto mb-4">
	<div
		class="relative flex justify-center items-center text-white text-center h-12 md:h-14 text-2xl md:text-4xl mb-4">
		<!-- 검색 상자 -->
		<div class="search-box flex-grow h-full ">
			<input id="director-search-input"
				class="bg-gray-200 block w-full h-full text-xl px-4 text-black"
				type="text" placeholder="공유할 캐스팅디렉터님의 아이디를 입력해주세요" />
		</div>
		<!-- 검색 버튼 -->
		<button onclick="getCastingDirectorList()"
			class="flex justify-center items-center h-full bg-green-400 text-white text-center h-full px-4 text-2xl md:text-3xl hover:bg-green-500">
			<i class="fas fa-search"></i>
		</button>
	</div>
	<div id="search-result"></div>
</div>

<script>
	var loginedMemberId = '<c:out value="${loginedMemberId}"/>';	
		
	function getCastingDirectorList(){
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
		
		var members = data.body.members;

		var $search_result = $('#search-result');
		
		//값 초기화
		$('#search-result').empty();
		
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
		
		$('#search-result').prepend(html);
		
	}
	
	function doShareApplymentsWith(id, name){
		
		var result = confirm(id + '번 ' +name +'님과 지원자들을 공유하시겠습니까?');
		
		if(result == false){
			return;
		}
		
		$.post('../../usr/share/doShareApplymentsAjax',{
			actorId: loginedMemberId,
			targetId: id,
			name : name,
			relTypeCode : "applyment"
		},function (data){
			alert(data.msg);
		},'json');
	}
</script>


<div class="list-box con">
	<div class="flex border-2 border-black box-border p-4">
		<div class=" flex-1">번호</div>
		<div class="flex-4">모집기간</div>
		<div class=" flex-4">배역</div>
	</div>

	<c:forEach items="${recruitments}" var="recruitment">
		<c:if
			test="${recruitment.memberId == loginedMemberId || isAdmin == true}">
			<div class="toggle">
				<div class="flex border-2 border-black box-border p-4">
					<div class=" flex-1">${recruitment.id}</div>
					<div class="flex-4">${recruitment.regDate}</div>
					<div class=" flex-4"
						onclick="showApplicantList( ${recruitment.id} , ${recruitment.memberId} )">${recruitment.forPrintTitle}</div>
				</div>
				<div class="${recruitment.id} border-2 "></div>
			</div>
		</c:if>
	</c:forEach>
</div>
<div class="popup-1 applicant-decision-form-modal">
	<div class="content">
		<div id="media-content" class="flex justify-center"></div>
		<div id="button-box" class="button-box flex justify-center">
			<button
				class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow">추천</button>
			<span id="decision-button-box"> </span>
			<button
				class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow"
				onclick="hideApplicantDecisonModal()">닫기</button>
		</div>
	</div>

</div>

<script>

var ApplymentList__lastLodedId = 0;
var ApplymentList__applymentsCount = 0;

	var showApplicantList = function(recruitment_id , recruitment_memberId) {
		
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
			var undecidedApplicant = 0;

			$.get('../../usr/applyment/getForPrintApplymentsByResult', {
				recruitmentId : recruitment_id,
				from : ApplymentList__lastLodedId + 1,
				result : undecidedApplicant
				
			}, function(data) {
				if(data && data.body){
					ApplymentList__loadMoreCallback(data);
				}
			}, 'json');
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
			
			html += '<div onclick="showApplicantDecisonModal(' + applyment.id + ','+ recruitment_id + ','+ recruitment_memberId +');" class="flex justify-center text-center border-2 border-black box-border p-4">';
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
        //showApplicantDecisonModal의 동영상 제거한다.
        $('#media-content').empty();
        
        //showApplicantDecisonModal의 합격/불합격 버튼을 제거한다.
       $("#decision-button-box").empty();
		
        $('html').removeClass('applicant-decision-form-modal-actived');
    }
	
  	function showApplicantDecisonModal(applyment_id, recruitment_id, recruitment_memberId) { 		
  		
  	  //video태그를 보여줄 id=media-content 엘리먼트를 가져온다.
	  var $media_content = $("#media-content");
	  
	  //버튼 태그를 보여줄 id=button-box 엘리먼트를 가져온다.
	  var $decision_button_box = $("#decision-button-box");
	  
	  //로그인한 사용자의 번호를 가져온다.
	  var loginedMemberId = '<c:out value="${loginedMemberId}"/>';
	  
	  //admin인지 확인용.
	  var isAdmin = '<c:out value="${isAdmin}"/>';
	  
	  var Media_html = '';
	  
	  var button_html = '';
	  
	  button_html += "<button class='bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow' onclick='ChangeApplymentResult(2)'>불합격</button>";
	  button_html += "<button class='bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow' onclick='ChangeApplymentResult(1)'>합격</button>";
	  
	  var undecidedApplicant = 0;
	  
	  $.get('../../usr/applyment/getForPrintApplymentRelatedToResultAjax', {
		 id : applyment_id,
		 relId : recruitment_id,
		 result : undecidedApplicant
		 
		}, function (data) {
			
			Media_html += ApplymentList__getMediaHtml(data);
			
			var $Media_html = $(Media_html);
			
			//video태그를 id=media-content인 태그에 넣어준다.
			$media_content.prepend($Media_html);

			//합격불,합격 버튼 태그를 사용자의 아이디에따라 보여준다.
			if(loginedMemberId == recruitment_memberId ){
				var $button_html = $(button_html);
				
				$decision_button_box.prepend($button_html);
			}			
			
			//applicantDecisionModal창을 열때마다 
			// ApplymentList__getMediaHtml를 감싸고있는 #media-content에
			// 전역변수처럼 data-id에 id값을 저장해서 해당 엘리먼트의 자식,후손들이 사용할 수 있도록 한다.
			$('#media-content').data('id',applyment_id);
			
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

	            html += '<div class="video-box hidden md:block" data-video-name="applyment__' + applyment.id + '__common__attachment__' + fileNo + '" data-file-no="' + fileNo + '">';

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
			
			for (var fileNo = 1; fileNo <= 3; fileNo++) {
	            var file = null;
	            if (applyment.extra.file__common__attachment && applyment.extra.file__common__attachment[fileNo]) {
	                file = applyment.extra.file__common__attachment[fileNo];
	            }

	            html += '<div class=" visible-on-sm-down" data-video-name="applyment__' + applyment.id + '__common__attachment__' + fileNo + '" data-file-no="' + fileNo + '">';

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
	
	function ChangeApplymentResult(result) {
		var id = $('#media-content').data('id');
		
		// result : 1 (합격)
		if(result == 1){
			if (confirm('합격 시키겠습니까?') == false) {
	            return;
	        }
		} else{
			// result : 2 (불합격)
			if (confirm('불합격 시키겠습니까?') == false) {
	            return;
	        }
		}
		
		$.post('../../usr/applyment/doChangeApplymentResultAjax',{
			id : id,
			result : result
		},function(data){
			alert(data.msg);
		},'json');
		
		location.reload();
		
	} 
	
</script>

<%@ include file="../part/foot.jspf"%>