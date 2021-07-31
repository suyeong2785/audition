<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원정보수정" />
<%@ include file="../part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
	var checkCareerBoxResult = function(form) {
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

		var dateSize = dates.length;

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

		dates = $("input[name='careerDate']").map(function(index, element) {
			if ($.trim($(this).val()) != "" && $.trim($(this).val()) != null) {
				return $.trim($(this).val());
			}
		}).get().join(",");

		artworks = $("input[name='careerArtwork']").map(
				function(index, element) {
					if ($.trim($(this).val()) != ""
							&& $.trim($(this).val()) != null) {
						return $.trim($(this).val());
					}
				}).get().join(",");

		form.careerDates.value = dates;
		form.careerArtworks.value = artworks;

		alert('form.careerDates.value : ' + form.careerDates.value);
		alert('form.careerArtworks.value : ' + form.careerArtworks.value);

	}

	function MemberModifyForm__submit(form) {

		/*url validation check 함수...
		function validateUrl(value) {
			return /^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:[/?#]\S*)?$/i
					.test(value);
		}
		 */

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

		form.youtubeUrl.value = form.youtubeUrl.value.trim();

		if (form.youtubeUrl.value.length != 0) {
			if (matchYoutubeUrl(form.youtubeUrl.value) == false) {
				form.youtubeUrl.focus();
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
					&& form["file__profile__" + loginedMemberId
							+ "__common__attachment__" + fileNo]) {
				needToUpload = form["file__profile__" + loginedMemberId
						+ "__common__attachment__" + fileNo]
						&& form["file__profile__" + loginedMemberId
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
								name="file__profile__${loginedMemberId}__common__attachment__${fileForProfile != null ? fileForProfile.fileNo : 0 }" />
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
						<input type="text" name="youtubeUrl" />
					</div>
				</td>
			</tr>
			<tr>
				<th>ISNI 인증</th>
				<td>
					<div class="flex">
						<input id="ISNI-number" class="w-72" type="text"
							placeholder="본인의 ISNI Number를 입력해주세요" />
						<button type="button" onclick="javascript:getISNIInfo()"
							class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">전송</button>
					</div>
				</td>
			</tr>
			<script>
				function getISNIInfo() {

					var $ISNI_number = $("#ISNI-number").val();

					$.get('/usr/member/getIsniSearchResultAjax', {
						id : $ISNI_number
					}, function(data) {
						alert(data.msg);
					});

				}
			</script>
			<tr>
				<th>이름</th>
				<td>
					<div class="form-control-box">
						<input type="text" placeholder="이름을 입력해주세요." name="name"
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
											<input name="careerDate" type="date" value="${career.key}" />
										</div>
										<div>
											<input name="careerArtwork" type="text"
												placeholder="작품명 입력해주세요." name="career" maxlength="20"
												value="${career.value}" />
										</div>
										<button type="button" class="text-2xl"
											onclick="javascript:removeCareerBoxAndShowSwitch(this)">
											<i class="far fa-trash-alt"></i>
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
	$(function() {
		var joinedCareer = '<c:out value="${joinedCareer}" />';
		
		if(joinedCareer != null && joinedCareer != "" ){
			$('#career-box-switch').data("displayStatus",-1);
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

	function addCareerBox() {

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

	function showCareerBox() {
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
		html += '<input name="careerArtwork" type="text" placeholder="작품명 입력해주세요." name="career" maxlength="20" />';
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