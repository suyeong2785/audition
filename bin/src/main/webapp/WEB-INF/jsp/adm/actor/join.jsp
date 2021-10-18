<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="pageTitle" value="배우추가" />
<%@ include file="../../usr/part/head.jsp"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
	//경력박스확인 체크
	var checkCareerBoxResult = function(form) {

		var artworkNeedToStop = 0;
		let artworks = $("input[name='careerArtwork']").each(
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

			return element.innerHTML = "" + index;

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

	function ActorJoinForm__submit(form) {
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		var result = 1;
		if ($('#career-box-switch').data("displayStatus") == -1) {
			result = checkCareerBoxResult(form);
		}

		if (result == -1) {
			return;
		}
		
		form.name.value = form.name.value.trim();
		
		if(form.name.value.length == 0){
			form.name.focus();
			alert('이름은 필수입력사항 입니다.');
			
			return;
		}
		
		if (form.name.value.length > 10) {
			form.name.focus();
			alert('이름을 아홉자리수 이상 입력할 수 없습니다.');
			
			return;
		}
		
		form.nickname.value = form.nickname.value.trim();
		
		if (form.nickname.value.length > 10) {
			form.nickname.focus();
			alert('활동명을 아홉자리수 이상 입력할 수 없습니다.');
			
			return;
		}
		
		form.age.value = form.age.value.trim();
		
		if (form.age.value.length > 3) {
			form.age.focus();
			alert('나이를 두자리수 이상 입력할 수 없습니다.');
			return;
		}
		
		if(form.age.value > 255){
			alert('나이를 255살 이상 입력할 수 없습니다.');
			form.age.focus();
			return;
		}
		
		if (form.gender[0].checked == false && form.gender[1].checked == false) {
			alert('성별은 필수입력사항입니다.');
			
			return;
		}
		
		form.weight.value = form.weight.value.trim();
		
		if (form.weight.value.length > 3) {
			form.weight.focus();
			alert('몸무게를 세자리수 이상 입력할 수 없습니다.');
			return;
		}
		
		if(form.weight.value > 255){
			alert('몸무게를 255kg이상 입력할 수 없습니다.');
			form.weight.focus();
			return;
		}
		
		form.height.value = form.height.value.trim();
		
		if (form.height.value.length > 3) {
			form.height.focus();
			alert('키를 세자리수 이상 입력할 수 없습니다.');
			return;
		}
		
		if(form.height.value > 255){
			alert('키를 255cm이상 입력할 수 없습니다.');
			form.height.focus();
			return;
		}
		
		form.phone.value = form.phone.value.trim();
		
		if (form.phone.value.length > 11 || form.phone.value.length < 11 ) {
			form.phone.focus();
			alert('전화번호 열한자리수를 입력해주세요.');
		
			return;
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

		var startUploadFiles = function(onSuccess) {
			var needToUpload = false;

			if (needToUpload == false
					&& form.file__actor__0__common__attachment__1) {
				needToUpload = form.file__actor__0__common__attachment__1
						&& form.file__actor__0__common__attachment__1.value.length > 0;
			}

			if (needToUpload == false) {
				onSuccess();
				return;
			}

			var fileUploadFormData = new FormData(form);

			$.ajax({
				url : './../../usr/file/doUploadAjax',
				data : fileUploadFormData,
				processData : false,
				contentType : false,
				dataType : "json",
				type : 'POST',
				success : onSuccess
			});
		}

		var startWriteApplyment = function(fileIdsStr) {

			form.fileIdsStr.value = fileIdsStr;

			form.submit();
		};

		startUploadFiles(function(data) {

			var idsStr = '';
			if (data && data.body && data.body.fileIdsStr) {
				idsStr = data.body.fileIdsStr;
			}

			startWriteApplyment(idsStr);
		});

	}
</script>

<form method="POST" class="table-box table-box-vertical con form1 relative"
	action="doJoin"
	onsubmit="javascript:ActorJoinForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/adm/home/showMyPage">
	<input type="hidden" name="fileIdsStr">
	<input type="hidden" name="careerDates" />
	<input type="hidden" name="careerArtworks" />
	<input type="hidden" name="jobId" value="1" />
	<div class="absolute -top-6 ">
	<span class="text-gray-500">*필수 입력사항입니다.</span>
	</div>
	<table>
		<colgroup>
			<col class="table-first-col">
		</colgroup>
		<tbody>
			<tr>
				<th>프로필 사진</th>
				<td>
					<div class="form-control-box">
						<input id="join-file" type="file"
							accept="${appConfig.getAttachemntFileInputAccept('img')}"
							name="file__actor__0__common__attachment__1" />
						<img id="join-profile" class="w-20" src="" alt="" />
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
				<th>이름*</th>
				<td>
					<div class="form-control-box">
						<input type="text" placeholder="이름을 입력해주세요." name="name"
							maxlength="20" />
					</div>
				</td>
			</tr>
			<tr>
				<th>활동명</th>
				<td>
					<div class="form-control-box">
						<input type="text" placeholder="활동명 입력해주세요." name="nickname"
							maxlength="20" />
					</div>
				</td>
			</tr>
			<tr>
				<th>성별*</th>
				<td>
					<div class="form-control-box">
						<label>
							<input type="radio" name="gender" value="W">
							여성
						</label>
						<label>
							<input type="radio" name="gender" value="M">
							남성
						</label>
					</div>
				</td>
			</tr>
			<tr>
				<th>나이</th>
				<td>
					<div class="form-control-box">
						<input type="number" placeholder="나이를 입력해주세요." name="age" />
					</div>
				</td>
			</tr>
			<tr>
				<th>키</th>
				<td>
					<div class="form-control-box">
						<input type="number" placeholder="나이를 입력해주세요." name="height"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>몸무게</th>
				<td>
					<div class="form-control-box">
						<input type="number" placeholder="나이를 입력해주세요." name="weight" />
					</div>
				</td>
			</tr>
			<tr id="activity-box">
				<th>
					<span>활동이력</span>
				</th>
				<td class="flex items-center">
					<button type="button" class="text-2xl" id="career-box-switch"
						data-displayStatus=-1 onclick="javascript:showCareerBox()">
						<i class="far fa-plus-square"></i>
					</button>
					<div class="career-box hidden relative"></div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div class="form-control-box">
						<input type="email" placeholder="이메일 입력해주세요." name="email"
							maxlength="50" />
					</div>
				</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>
					<div class="form-control-box">
						<input type="tel" placeholder="휴대전화번호를 입력해주세요." name="phone"
							maxlength="12" />
					</div>
				</td>
			</tr>
			<tr>
				<th>가입</th>
				<td>
					<button class="btn btn-primary" type="submit">가입</button>
					<button class="btn btn-info" type="button"
						onclick="history.back();">취소</button>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<script>
	$('#join-file').on('change', function() {

		const files = $("#join-file")[0].files;
		const file = $("#join-file")[0].files[0];

		if (files.length != 0) {
			const imgurl = URL.createObjectURL(file);
			$('#join-profile').attr("src", imgurl);

			URL.revokeObjectURL(file);

		} else {
			//파일이 없는 경우 내용을 지워준다.
			$('#join-profile').attr("src", "");
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
		html += '<input name="careerArtwork" type="text" placeholder="작품명 입력해주세요." maxlength="20" />';
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
		html += '<input name="careerArtwork" type="text" placeholder="작품명 입력해주세요." name="career" maxlength="20"/>';
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