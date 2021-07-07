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
<script>

var ApplymentList__lastLodedId = 0;
var ApplymentList__needToLoadMore = true;

	var showApplicantList = function(recruitment_id) {
		
		if($('.' + recruitment_id).data("displayStatus") == 1){
			$('.' + recruitment_id).css({"display":"none"});
			$('.' + recruitment_id).data("displayStatus",0);
			return;
		}
		
		if($('.' + recruitment_id).data("displayStatus") == 0){
			$('.' + recruitment_id).css({"display":"block"});
			$('.' + recruitment_id).data("displayStatus",1);
		}
		
		
		//applyment 객체들을 ajax를 통해 불러온다.
		function ApplymentList__loadMore() {

			$.get('../../usr/applyment/getForPrintApplyments', {
				recruitmentId : recruitment_id,
				from : ApplymentList__lastLodedId + 1
			}, ApplymentList__loadMoreCallback, 'json');
		}
		
		function ApplymentList__loadMoreCallback(data) {
	        
	        if (data.body.applyments && data.body.applyments.length > 0) {
	            ApplymentList__lastLodedId = data.body.applyments[data.body.applyments.length - 1].id;
	            ApplymentList__drawApplyments(data.body.applyments);
	        }
	        
	        return;
		}
		
		function ApplymentList__drawApplyments(applyments) {
			
			for (var i = 0; i < applyments.length; i++) {
				var applyment = applyments[i];
				ApplymentList__drawApplyment(applyment);
			}
		}
	
		function ApplymentList__drawApplyment(applyment) {

			var ApplymentList__$tr = $('.' + recruitment_id);
			$('.' + recruitment_id).data("displayStatus", 1);
			
			var html = '';
			
			html += '<div class="flex justify-center text-center border-2 border-black box-border p-4">';
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
	
</script>






<%@ include file="../part/foot.jspf"%>