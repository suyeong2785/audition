<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원가입" />
<%@ include file="../part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
	function MemberJoinForm__submit(form) {
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		form.loginId.value = form.loginId.value.trim();
		form.loginId.value = form.loginId.value.replaceAll('-', '');
		form.loginId.value = form.loginId.value.replaceAll('_', '');
		form.loginId.value = form.loginId.value.replaceAll(' ', '');

		if (form.loginId.value.length == 0) {
			form.loginId.focus();
			alert('로그인 아이디를 입력해주세요.');

			return;
		}

		if (form.loginId.value.length < 4) {
			form.loginId.focus();
			alert('로그인 아이디 4자 이상 입력해주세요.');

			return;
		}

		form.loginPw.value = form.loginPw.value.trim();

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
		
		var result = 1;
		if ($('#career-box-switch').data("displayStatus") == -1) {
			result = checkCareerBoxResult(form);
		}

		if (result == -1) {
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

		form.loginPwReal.value = sha256(form.loginPw.value);

		var startUploadFiles = function(onSuccess) {
			var needToUpload = false;

			if (needToUpload == false
					&& form.file__profile__0__common__attachment__1) {
				needToUpload = form.file__profile__0__common__attachment__1
						&& form.file__profile__0__common__attachment__1.value.length > 0;
			}

			if (needToUpload == false) {
				onSuccess();
				return;
			}

			var fileUploadFormData = new FormData(form);

			$.ajax({
				url : './../file/doUploadAjax',
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
	onsubmit="javascript:MemberJoinForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/usr/member/login">
	<input type="hidden" name="loginPwReal">
	<input type="hidden" name="fileIdsStr">
	<table>
		<colgroup>
			<col class="table-first-col">
		</colgroup>
		<tbody>
			<tr>
				<th>로그인 아이디</th>
				<td>
					<div class="form-control-box">
						<input type="text" placeholder="로그인 아이디 입력해주세요." name="loginId"
							maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>로그인 비번</th>
				<td>
					<div class="form-control-box">
						<input type="password" placeholder="로그인 비밀번호를 입력해주세요."
							name="loginPw" maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>로그인 비번 확인</th>
				<td>
					<div class="form-control-box">
						<input type="password" placeholder="로그인 비밀번호 확인을 입력해주세요."
							name="loginPwConfirm" maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>프로필 사진</th>
				<td>
					<div class="form-control-box">
						<input id="join-file" type="file"
							accept="${appConfig.getAttachemntFileInputAccept('img')}"
							name="file__profile__0__common__attachment__1" />
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
				<th>나이</th>
				<td>
					<div class="form-control-box">
						<input type="number" placeholder="나이를 입력해주세요." name="age"
							maxlength="20" />
					</div>
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<div class="form-control-box">
						<label>
							<input type="radio" name="gender" value="woman">
							여성
						</label>
						<label>
							<input type="radio" name="gender" value="man">
							남성
						</label>
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
				<th>직업</th>
				<td>
					<div class="form-control-box">
						<select name="authority" maxlength="20">
							<option value="1">캐스팅디렉터</option>
							<option value="2">배우</option>
						</select>
					</div>
				</td>
			</tr>
			<tr id="activity-box" > 
				<th>
					<span>활동이력</span>
				</th>
				<td class="flex items-center">
					<button type="button" class="text-2xl"
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
						<input type="tel" placeholder="휴대전화번호를 입력해주세요." name="cellphoneNo"
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
</script>
<%@ include file="../part/foot.jspf"%>