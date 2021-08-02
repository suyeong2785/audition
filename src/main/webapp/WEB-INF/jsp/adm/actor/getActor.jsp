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
	<div class="flex border-2 border-black box-border p-2 mb-2">
		<div class="text-center flex-grow">캐스팅 검색</div>
	</div>
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
		<!-- 검색 닫기버튼 -->
		<button onclick="closeCastingDirectorList()"
			id="search-close-button" class=" hidden justify-center items-center h-full bg-green-400 text-white text-center h-full px-4 text-2xl md:text-3xl hover:bg-green-500">
			<i class="fas fa-times"></i>
		</button>
	</div>
	<div id="search-result"></div>
</div>

<script>
	var loginedMemberId = '<c:out value="${loginedMemberId}"/>';	
		
	function closeCastingDirectorList(){
	
		$('#search-close-button').css({"display":"none"});
		$('#search-result').empty();
	}
	
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
		var $search_result = $('#search-result');
		
		//값 초기화
		$('#search-result').empty();
		
		var members = null;
		
		if(data.resultCode.startsWith('F')){
			$('#search-close-button').css({"display":"none"});
		}
		
		if(data && data.body && data.body.members){
			members = data.body.members;
			
			$('#search-close-button').css({"display":"flex"});
		}

		var $search_result = $('#search-result');
		
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
		
		var result = confirm(name +'님과 지원자들을 공유하시겠습니까?');
		
		if(result == false){
			return;
		}
		
		$.post('../../usr/share/doShareApplymentsAjax',{
			requesterId: loginedMemberId,
			requesteeId: id,
			name : name,
			relTypeCode : "applyment"
		},function (data){
			alert(data.msg);
		},'json');
		
		location.reload();
	}
</script>


<%@ include file="../part/foot.jspf"%>