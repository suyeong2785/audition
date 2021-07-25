<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원정보수정" />
<%@ include file="../part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
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
	<table>
		<colgroup>
			<col class="table-first-col">
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
</script>
<%@ include file="../part/foot.jspf"%>