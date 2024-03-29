<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="신규오디션" />
<%@ include file="../part/head.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" />
<script>
	$(function() {
		$('.select2').select2();
	});
</script>
<script>
	function RecruitmentWriteForm__submit(form) {
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		form.title.value = form.title.value.trim();

		var bodyEditor = $(form).find('.toast-editor.input-body').data('data-toast-editor');

		var body = bodyEditor.getMarkdown().trim();

		if (body.length == 0) {
			bodyEditor.focus();
			alert('상세내용을 입력해주세요.');

			return;
		}

		form.body.value = body;

		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024 //50MB

		if (form.file__recruitment__0__common__attachment__1.value) {
			if (form.file__recruitment__0__common__attachment__1.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		if (form.file__recruitment__0__common__attachment__2.value) {
			if (form.file__recruitment__0__common__attachment__2.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		if (form.file__recruitment__0__common__attachment__3.value) {
			if (form.file__recruitment__0__common__attachment__3.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		var startUploadFiles = function(onSuccess) {
			var needToUpload = form.file__recruitment__0__common__attachment__1.value.length > 0;

			if (!needToUpload) {
				needToUpload = form.file__recruitment__0__common__attachment__2.value.length > 0;
			}

			if (!needToUpload) {
				needToUpload = form.file__recruitment__0__common__attachment__3.value.length > 0;
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

		startLoading();
		startUploadFiles(function(data) {
			var fileIdsStr = '';

			if (data && data.body && data.body.fileIdsStr) {
				fileIdsStr = data.body.fileIdsStr;
			}

			form.fileIdsStr.value = fileIdsStr;
			form.file__recruitment__0__common__attachment__1.value = '';
			form.file__recruitment__0__common__attachment__2.value = '';

			if (bodyEditor.inBodyFileIdsStr) {
                form.fileIdsStr.value += bodyEditor.inBodyFileIdsStr;
            }

            form.submit();
		});
	}
</script>
<form method="POST" class="table-box table-box-vertical con form1" action="${job.code}-doWrite" onsubmit="RecruitmentWriteForm__submit(this); return false;">
	<input type="hidden" name="fileIdsStr" />
	<input type="hidden" name="redirectUri" value="/usr/recruitment/${job.code}-detail?id=#id">
	<input type="hidden" name="roleTypeCode" value="actingRole">
	<input type="hidden" name="body">
	<table>
		<colgroup>
			<col class="table-first-col">
		</colgroup>
		<tbody>
			<tr>
				<th>배역</th>
				<td>
					<div class="form-control-box">
						<select name="roleId" class="select2" style="width: 100%;">
							<c:forEach items="${roles}" var="role">
								<option value="${role.id}">${role.getTitle()}</option>
							</c:forEach>
						</select>
					</div>
				</td>
			</tr>
			<tr class="none">
				<th>제목</th>
				<td>
					<div class="form-control-box">
						<input type="text" placeholder="제목을 입력해주세요." name="title" maxlength="100" />
					</div>
				</td>
			</tr>
			<tr>
				<th>상세내용</th>
				<td>
					<div class="form-control-box">
						<script type="text/x-template">
# 감독 인사말
![img](https://placekitten.com/200/287)
정말 반갑습니다.

# 1분연기 예시

아래 영상을 참고하여 영상을 촬영해서 신청해주세요.

```youtube
https://www.youtube.com/watch?v=LmgWxezH7cc(동영상 주소)
```
						</script>
						<div data-relTypeCode="recruitment" data-relId="0"  class="toast-editor input-body"></div>
					</div>
				</td>
			</tr>
			<c:forEach var="i" begin="1" end="3" step="1">
				<c:set var="fileNo" value="${String.valueOf(i)}" />
				<c:set var="fileExtTypeCode" value="${appConfig.getAttachmentFileExtTypeCode('recruitment', i)}" />
				<tr>
					<th>첨부${fileNo} ${appConfig.getAttachmentFileExtTypeDisplayName('recruitment', i)}</th>
					<td>
						<div class="form-control-box">
							<input type="file" accept="${appConfig.getAttachemntFileInputAccept('recruitment', i)}" name="file__recruitment__0__common__attachment__${fileNo}">
						</div>
					</td>
				</tr>
			</c:forEach>
			<tr class="tr-do">
				<th>작성</th>
				<td>
					<button class="btn btn-primary" type="submit">작성</button>
					<a class="btn btn-info" href="${listUrl}">리스트</a>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<%@ include file="../part/foot.jsp"%>