<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="pageTitle" value="배우추가" />
<%@ include file="../part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
	//경력박스확인 체크
	var checkCareerBoxResult = function(form) {

		/*
		var dateNeedToStop = 0;
		
		let dates = $("input[name='careerDate']").each(function(index, item) {
			if ($.trim($(this).val()) != "" && $.trim($(this).val()) != null) {
				return true;
			}

			alert('경력날짜의 ' + (index + 1) + '번째 칸이 비어있습니다.');
			dateNeedToStop = 1;
			$(this).focus();
			return false;
		});

		if (dateNeedToStop == 1) {
			return -1;
		}
		 */

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

		alert('form.careerDates.value : ' + form.careerDates.value);
		alert('form.careerArtworks.value : ' + form.careerArtworks.value);

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

<form method="POST" class="table-box table-box-vertical con form1"
	action="doJoin"
	onsubmit="javascript:ActorJoinForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/adm/home/showMyPage">
	<input type="hidden" name="fileIdsStr">
	<input type="hidden" name="careerDates" />
	<input type="hidden" name="careerArtworks" />
	<input type="hidden" name="jobId" value="1" />
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
				<th>이름</th>
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
				<th>성별</th>
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
						<input type="number" placeholder="나이를 입력해주세요." name="age"
							maxlength="20" />
					</div>
				</td>
			</tr>
			<tr>
				<th>키</th>
				<td>
					<div class="form-control-box">
						<input type="number" placeholder="나이를 입력해주세요." name="age"
							maxlength="20" />
					</div>
				</td>
			</tr>
			<tr>
				<th>몸무게</th>
				<td>
					<div class="form-control-box">
						<input type="number" placeholder="나이를 입력해주세요." name="age"
							maxlength="20" />
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
		html += '<input name="careerArtwork" type="text" placeholder="작품명 입력해주세요." name="career" maxlength="20" value="'
				+ (title != null ? title : "") + '"/>';
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
<%@ include file="../part/foot.jspf"%>