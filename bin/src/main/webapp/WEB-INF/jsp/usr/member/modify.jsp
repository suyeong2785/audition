<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="pageTitle" value="회원정보수정" />
<%@ include file="../part/head.jsp"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
	//경력박스확인 체크
	var checkCareerBoxResult = function(form) {

		var artworkNeedToStop = 0;
		$("input[name='careerArtwork']").each(
				function(index, item) {
					if ($.trim($(this).val()) != ""
							&& $.trim($(this).val()) != null) {
						return true;
					}

					alert('경력내용의 ' + (index + 1) + '번째 칸이 비어있습니다.');
					artworkNeedToStop = 1;
					$(this).focus();
					return false;
				});

		if (artworkNeedToStop == 1) {
			return -1;
		}

		var dates = $("input[name='careerDate']").map(function(index, element) {
			if ($.trim($(this).val()) != "" && $.trim($(this).val()) != null) {
				return $.trim($(this).val());
			}
			
			return element.innerHTML = ""+index;
			
		}).get().join("_");

		artworks = $("input[name='careerArtwork']").map(
				function(index, element) {
					if ($.trim($(this).val()) != ""
							&& $.trim($(this).val()) != null) {
						return $.trim($(this).val());
					}
					
				}).get().join("_");

		form.careerDates.value = dates;
		form.careerArtworks.value = artworks;
		
		return 1;
	}

	function MemberModifyForm__submit(form) {

		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length > 0) {
			if (form.loginPw.value.length == 0) {
				form.loginPw.focus();
				alert('로그인 비밀번호를 입력해주세요.');

				return;
			}

			if (form.loginPw.value.length < 5) {
				form.loginPw.focus();
				alert('로그인 비밀번호를 5자 이상 입력해주세요.');

				return;
			}

			if (form.loginPwConfirm.value.length == 0) {
				form.loginPwConfirm.focus();
				alert('로그인 비밀번호 확인을 입력해주세요.');

				return;
			}

			if (form.loginPw.value != form.loginPwConfirm.value) {
				form.loginPwConfirm.focus();
				alert('로그인 비밀번호 확인이 일치하지 않습니다.');

				return;
			}
		}

		//YoutubeUrl validation check 함수...
		function matchYoutubeUrl(url) {
			var p = /^(?:https?:\/\/)?(?:m\.|www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/;
			if (url.match(p)) {
				return url.match(p)[1];
			}
			return false;
		}

		form.youTubeUrl.value = form.youTubeUrl.value.trim();

		if (form.youTubeUrl.value.length != 0) {
			if (matchYoutubeUrl(form.youTubeUrl.value) == false) {
				form.youTubeUrl.focus();
				alert('youTube url형식에 맞게 입력해주세요.');

				return;
			}
		}
		
		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			form.name.focus();
			alert('이름을 입력해주세요.');

			return;
		}

		form.nickname.value = form.nickname.value.trim();

		if (form.nickname.value.length == 0) {
			form.nickname.focus();
			alert('활동명을 입력해주세요.');

			return;
		}

		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			form.email.focus();
			alert('이메일을 입력해주세요.');

			return;
		}

		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		form.cellphoneNo.value = form.cellphoneNo.value.replaceAll('-', '');
		form.cellphoneNo.value = form.cellphoneNo.value.replaceAll(' ', '');

		if (form.cellphoneNo.value.length == 0) {
			form.cellphoneNo.focus();
			alert('휴대전화번호를 입력해주세요.');

			return;
		}

		if (form.cellphoneNo.value.length < 10) {
			form.cellphoneNo.focus();
			alert('휴대폰번호를 10자 이상 입력해주세요.');

			return;
		}

		if (isCellphoneNo(form.cellphoneNo.value) == false) {
			form.cellphoneNo.focus();
			alert('휴대전화번호를 정확히 입력해주세요.');

			return;
		}
		var result = 1;
		if ($('#career-box-switch').data("displayStatus") == -1) {
			result = checkCareerBoxResult(form);
		}

		if (result == -1) {
			return;
		}

		if (form.loginPw.value.length > 0) {
			form.loginPwReal.value = sha256(form.loginPw.value);
		}

		form.loginPw.value = '';
		form.loginPwConfirm.value = '';

		var fileNo = '<c:out value="${fileForProfile != null ? fileForProfile.fileNo : 0}" />';
		var loginedMemberId = '<c:out value="${loginedMemberId}" />';

		var startUploadFiles = function(onSuccess) {
			var needToUpload = false;
			var needToDelete = form.deleteCheck.value;

			if (needToUpload == false
					&& form["file__member__" + loginedMemberId
							+ "__common__attachment__" + fileNo]) {
				needToUpload = form["file__member__" + loginedMemberId
						+ "__common__attachment__" + fileNo]
						&& form["file__member__" + loginedMemberId
								+ "__common__attachment__" + fileNo].value.length > 0;
			}

			if (needToUpload == false && needToDelete == -1) {
				onSuccess();
				return;
			}

			var fileUploadFormData = new FormData(form);

			if (needToDelete == -1) {
				$.ajax({
					url : './../file/doUploadAjax',
					data : fileUploadFormData,
					processData : false,
					contentType : false,
					dataType : "json",
					type : 'POST',
					success : onSuccess
				});
			} else {
				$.ajax({
					url : './../file/doDeleteAjax',
					data : fileUploadFormData,
					processData : false,
					contentType : false,
					dataType : "json",
					type : 'POST',
					success : onSuccess
				});
			}

		}

		startUploadFiles(function(data) {

			if (data && data.body && data.body.fileIdsStr) {
				form.fileIdsStr.value = data.body.fileIdsStr;
				form.submit();
			}

			form.submit();
		});
	}
</script>
<form method="POST" class="table-box table-box-vertical con form1"
	action="doModify"
	onsubmit="javascript:MemberModifyForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/usr/home/main">
	<input type="hidden" name="loginPwReal">
	<input type="hidden" name="fileIdsStr"
		value="${fileForProfile != null ? fileForProfile.id : 0 }">
	<input type="hidden" name="relId" value="${loginedMember.id}">
	<input type="hidden" name="careerDates" />
	<input type="hidden" name="careerArtworks" />
	<input type="hidden" name="jobId" value="1" />
	<table>
		<colgroup>
			<col class="w-40">
		</colgroup>
		<tbody>
			<tr>
				<th>로그인 아이디</th>
				<td>
					<div class="form-control-box">${loginedMember.loginId}</div>
				</td>
			</tr>
			<tr>
				<th>새 로그인 비번(선택)</th>
				<td>
					<div class="form-control-box">
						<input type="password" placeholder="새 로그인 비밀번호를 입력해주세요."
							name="loginPw" maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>새 로그인 비번 확인(선택)</th>
				<td>
					<div class="form-control-box">
						<input type="password" placeholder="새 로그인 비밀번호 확인을 입력해주세요."
							name="loginPwConfirm" maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>프로필 사진</th>
				<td>
					<div class="flex">
						<div>
							<input id="modify-file" type="file" class="pb-4"
								accept="${appConfig.getAttachemntFileInputAccept('img')}"
								name="file__member__${loginedMemberId}__common__attachment__${fileForProfile != null ? fileForProfile.fileNo : 0 }" />
							<img id="modify-profile" class="w-20" src="" alt="" />
						</div>
						<c:if test="${fileForProfile != null}">
							<div>
								<label>프로필 삭제</label>
								<input type="checkbox" onclick="changeDeleteCheck()" />
							</div>
						</c:if>
						<input type="hidden" id="delete-check" name="deleteCheck"
							value="-1" />

					</div>
				</td>
			</tr>
			<tr>
				<th>유튜브 url</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="youTubeUrl" placeholder="ex) https://www.youtube.com/watch?v=영문/숫자/특수문자 (pc버전)" />
					</div>
				</td>
			</tr>
			<tr>
				<th class="flex">
					<span>ISNI 인증</span>
					<span id="ISNI-validation" data-isni-result="1" class="hidden text-green-400">
						<i class="fas fa-check"></i>
					</span>
				</th>
				<td>
					<div class="ISNI-box flex items-center">
						<div class="flex-col items-center pr-4">
							<input id="ISNI-number" type="hidden" name="ISNI_number" />
							<div class="ISNI-input-box flex items-center">
								<span class="pr-2">
									<input id="ISNI-number1"
										class="w-12 border border-black border-opacity-25 rounded-sm text-center"
										type="text" maxlength="4" placeholder="0000"
										value="${loginedMember.ISNI_number != null ? fn:substring(loginedMember.ISNI_number,0,4) : ''}" />
								</span>
								
								<span class="pr-2">
									<input id="ISNI-number2"
										class="w-12 border border-black border-opacity-25 rounded-sm text-center"
										type="text" maxlength="4" placeholder="0000"
										value="${loginedMember.ISNI_number != null ? fn:substring(loginedMember.ISNI_number,4,8) : ''}" />
								</span>

								<span class="pr-2">
									<input id="ISNI-number3"
										class="w-12 border border-black border-opacity-25 rounded-sm text-center"
										type="text" maxlength="4" placeholder="0000"
										value="${loginedMember.ISNI_number != null ? fn:substring(loginedMember.ISNI_number,8,12) : ''}" />
								</span>

								<span class="pr-2">
									<input id="ISNI-number4"
										class="w-12 border border-black border-opacity-25 rounded-sm text-center"
										type="text" maxlength="4" placeholder="0000"
										value="${loginedMember.ISNI_number != null ? fn:substring(loginedMember.ISNI_number,12,16) : ''}" />
								</span>
							</div>
							<div id="ISNI-reuslt" class="hidden"></div>
						</div>
						<button type="button" onclick="javascript:getISNIInfo()"
							class="mr-8 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">검색</button>
					</div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<div class="form-control-box">
						<input id="name" type="text" placeholder="이름을 입력해주세요." name="name"
							maxlength="20" value="${loginedMember.name.trim()}" />
					</div>
				</td>
			</tr>
			<tr>
				<th>활동명</th>
				<td>
					<div class="form-control-box">
						<input type="text" placeholder="활동명 입력해주세요." name="nickname"
							maxlength="20" value="${loginedMember.nickname.trim()}" />
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div class="form-control-box">
						<input type="email" placeholder="이메일 입력해주세요." name="email"
							maxlength="50" value="${loginedMember.email.trim()}" />
					</div>
				</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>
					<div class="form-control-box">
						<input type="tel" placeholder="휴대전화번호를 입력해주세요." name="cellphoneNo"
							maxlength="12" value="${loginedMember.cellphoneNo.trim()}" />
					</div>
				</td>
			</tr>
			<tr id="activity-box">
				<th>
					<span>활동이력</span>
				</th>
				<td class="relative flex items-center">
					<button type="button" class="absolute top-50 text-2xl"
						id="career-box-switch" data-displayStatus=-1
						onclick="javascript:showCareerBox()">
						<i class="far fa-plus-square"></i>
					</button>
					<div class="career-box hidden relative">
						<c:if test="${joinedCareer != null}">
							<button type="button" class="absolute top-0 text-2xl"
								onclick="javascript:addCareerBox()">
								<i class="far fa-plus-square"></i>
							</button>

							<div id="career-input-box" class="pl-8">
								<c:forEach items="${joinedCareer}" var="career"
									varStatus="status">
									<div class="career-input flex items-center">
										<div>
											<input name="careerDate" type="date" value="${fn:contains(career.key,'-') ? career.key : ''}" />
										</div>
										<div>
											<input name="careerArtwork" type="text"
												placeholder="작품명 입력해주세요." name="career" maxlength="20"
												value="${career.value}" />
										</div>
										<button type="button" class="text-2xl"
											onclick="javascript:removeCareerBox(this)">
											<i class="far fa-minus-square"></i>
										</button>
									</div>
								</c:forEach>
							</div>
						</c:if>
					</div>
				</td>
			</tr>
			<tr class="tr-do">
				<th>수정</th>
				<td>
					<button class="btn btn-primary" type="submit">수정</button>
					<button class="btn btn-info" type="button"
						onclick="history.back();">취소</button>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<script>

	$("#ISNI-number1, #ISNI-number2, #ISNI-number3, #ISNI-number4").change(function(){
		var ISNI_number1 = $("#ISNI-number1").val();
		var ISNI_number2 = $("#ISNI-number2").val();
		var ISNI_number3 = $("#ISNI-number3").val();
		var ISNI_number4 = $("#ISNI-number4").val();
		
		$("#ISNI-reuslt").html('');
		$("#ISNI-validation").css({"display":"none"});
		
		if(ISNI_number1.length == 4 && ISNI_number2.length == 4 && ISNI_number3.length == 4 && ISNI_number4.length == 4){
			getISNIInfo();
		}else if(ISNI_number1.length != 4){
			$("#ISNI-reuslt").css({"display":"block"});
			$("#ISNI-reuslt").html('<span style="color:red;">첫번째칸의 숫자가 4자리가아닙니다.</span>');
		}else if(ISNI_number2.length != 4){
			$("#ISNI-reuslt").css({"display":"block"});
			$("#ISNI-reuslt").html('<span style="color:red;">두번째칸의 숫자가 4자리가아닙니다.</span>');
		}else if(ISNI_number3.length != 4){
			$("#ISNI-reuslt").css({"display":"block"});
			$("#ISNI-reuslt").html('<span style="color:red;">세번째칸의 숫자가 4자리가아닙니다.</span>');
		}else if(ISNI_number4.length != 4){
			$("#ISNI-reuslt").css({"display":"block"});
			$("#ISNI-reuslt").html('<span style="color:red;">네번째칸의 숫자가 4자리가아닙니다.</span>');
		}
	});
	
	function getISNIInfo() {
		
		var ISNI_number1 = $("#ISNI-number1").val();
		var ISNI_number2 = $("#ISNI-number2").val();
		var ISNI_number3 = $("#ISNI-number3").val();
		var ISNI_number4 = $("#ISNI-number4").val();
		
		if(ISNI_number1.length == 4 && ISNI_number2.length == 4 && ISNI_number3.length == 4 && ISNI_number4.length == 4){
		
		var ISNI_number = $("#ISNI-number").val(
				ISNI_number1 + ISNI_number2 + ISNI_number3 + ISNI_number4);

		$.get('/usr/member/getMemberByISNINumberAjax',{
			ISNI_number : ISNI_number.val()
		}).then(function(data){
			if(data.resultCode.startsWith('S')){
				return $.get('/usr/member/getIsniSearchResultAjax', {
					id : ISNI_number.val()
				});
			}
			
			$("#ISNI-reuslt").css({"display":"block"});
			$("#ISNI-reuslt").html('<span style="color:red;">이미사용중인 ISNI번호입니다.</span>');
			$("#ISNI-validation").data("isniResult", -1);
			return;
			
		}).then(function(data) {
			var nameCheck = false;
			if (data.resultCode.startsWith('S')) {
				
				for(var i = 0; i < data.body.personalNames.length; i++){
					if($("#name").val() == data.body.personalNames[i].surname){
						nameCheck = true;
						break;
					}
				}
				
				if(nameCheck == false){
					$("#ISNI-reuslt").css({"display":"block"});
					$("#ISNI-reuslt").html('<span style="color:red;">ISNI에 등록된 이름과 다릅니다.</span>');
					$("#ISNI-validation").data("isniResult", -1);
					$("#ISNI-validation").css({"display":"none"});
					return;
				}
				
				$("#ISNI-reuslt").css({"display":"block"});
				$("#ISNI-reuslt").html('<span style="color:green;">사용가능한 ISNI번호입니다.</span>');
				$("#ISNI-validation").data("isniResult", 1);
				$("#ISNI-validation").css({"display":"inline-block"});
				
				var ISNIcareer = confirm("ISNI 등록된 경력사항을 가져오시겠습니까?.");
				if(ISNIcareer){
					setISNIcareer(data);
				}
				return;
			}
			
			$("#ISNI-reuslt").css({"display":"block"});
			$("#ISNI-reuslt").html('<span style="color:red;">존재하지않는 ISNI번호입니다.</span>');
			$("#ISNI-validation").data("isniResult", -1);
			return;
		});

		}else if(ISNI_number1.length != 4){
			$("#ISNI-reuslt").css({"display":"block"});
			$("#ISNI-reuslt").html('<span style="color:red;">첫번째칸의 숫자가 4자리가아닙니다.</span>');
		}else if(ISNI_number2.length != 4){
			$("#ISNI-reuslt").css({"display":"block"});
			$("#ISNI-reuslt").html('<span style="color:red;">두번째칸의 숫자가 4자리가아닙니다.</span>');
		}else if(ISNI_number3.length != 4){
			$("#ISNI-reuslt").css({"display":"block"});
			$("#ISNI-reuslt").html('<span style="color:red;">세번째칸의 숫자가 4자리가아닙니다.</span>');
		}else if(ISNI_number4.length != 4){
			$("#ISNI-reuslt").css({"display":"block"});
			$("#ISNI-reuslt").html('<span style="color:red;">네번째칸의 숫자가 4자리가아닙니다.</span>');
		}
		
	}
	
	function setISNIcareer(data){
		
		for(var i = 0; i < data.body.titleOfWorks.length; i++){
			var title = data.body.titleOfWorks[i].title;
			title = title.replace('@',"");
			if(i == 0){
				if($('.career-box').css("display") == "none"){
					showCareerBox(title);
				}else{
					addCareerBox(title);
				}
			}else{
				addCareerBox(title);	
			}
		}
		
	}

	$(function() {
		var joinedCareer = '<c:out value="${joinedCareer}" />';

		if (joinedCareer != null && joinedCareer != "") {
			$('#career-box-switch').data("displayStatus", -1);
			$('#career-box-switch').css("display", "none");
			$('.career-box').css("display", "block");
		}

	});

	$('#modify-file').on('change', function() {

		const files = $("#modify-file")[0].files;
		const file = $("#modify-file")[0].files[0];

		if (files.length != 0) {
			const imgurl = URL.createObjectURL(file);
			$('#modify-profile').attr("src", imgurl);

			URL.revokeObjectURL(file);

		} else {
			//파일이 없는 경우 내용을 지워준다.
			$('#modify-profile').attr("src", "");
		}
	});

	function changeDeleteCheck() {

		if ($('#delete-check').val() == 1) {
			$('#delete-check').val(-1);
		} else {
			$('#delete-check').val(1);
		}
	}

	function addCareerBox(title) {
		
		let html = '';

		html += '<div class="career-input flex items-center">';
		html += '<div>';
		html += '<input type="date" name="careerDate" />';
		html += '</div>';
		html += '<div>';
		html += '<input name="careerArtwork" type="text" placeholder="작품명 입력해주세요." maxlength="20" value="'+ (title != null ? title : "") +'"/>';
		html += '</div>';
		html += '<button class="text-2xl" onclick="removeCareerBox(this)">';
		html += '<i class="far fa-minus-square"></i>';
		html += '</button>';
		html += '</div>';

		$('#career-input-box').append(html);

	}

	function removeCareerBox(val) {
		$(val).closest("div.career-input").remove();
	}

	function removeCareerBoxAndShowSwitch(val) {
		$('#career-box-switch').data("displayStatus", 1);
		$('#career-box-switch').css("display", "block");

		$('.career-box').css("display", "none");
		$('.career-box').empty();

	}

	function showCareerBox(title) {
		$('#career-box-switch').data("displayStatus", -1);
		$('#career-box-switch').css("display", "none");

		html = '';

		html += '<button type="button" class="absolute top-0 text-2xl" onclick="javascript:addCareerBox()">';
		html += '<i class="far fa-plus-square"></i>';
		html += '</button>';
		
		html += '<div id="career-input-box" class="pl-8">';
		html += '<div class="career-input flex items-center">';
		html += '<div>';
		html += '<input name="careerDate" type="date" />';
		html += '</div>';
		html += '<div>';
		html += '<input name="careerArtwork" type="text" placeholder="작품명 입력해주세요." name="career" maxlength="20" value="'+ (title != null ? title : "") +'"/>';
		html += '</div>';
		
		html += '<button type="button" class="text-2xl" onclick="javascript:removeCareerBoxAndShowSwitch(this)">';
		html += '<i class="far fa-trash-alt"></i>';
		html += '</button>';
		html += '</div>';
		html += '</div>';

		$('.career-box').prepend(html);
		$('.career-box').css("display", "flex");
	}
</script>
<%@ include file="../part/foot.jsp"%>