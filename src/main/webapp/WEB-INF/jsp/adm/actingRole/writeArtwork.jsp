<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/head.jspf"%>
<%@ include file="../../part/toastuiEditor.jspf"%>

<script>
	//actingRole-box확인 체크
	var checkActingRoleBoxResult = function(form) {

		var NeedToStop = 0;

		$("input[name='role']").each(function(index, item) {
			if ($.trim($(this).val()) != "" && $.trim($(this).val()) != null) {
				return true;
			}

			alert('역할의 ' + (index + 1) + '번째 칸이 비어있습니다.');
			NeedToStop = 1;
			$(this).focus();
			return false;
		});

		if (NeedToStop == 1) {
			return -1;
		}

		$("input[name='gender']").each(function(index, item) {
			if ($.trim($(this).val()) != "" && $.trim($(this).val()) != null) {
				return true;
			}

			alert('성별의 ' + (index + 1) + '번째 칸이 비어있습니다.');
			NeedToStop = 1;
			$(this).focus();
			return false;
		});

		if (NeedToStop == 1) {
			return -1;
		}

		$("input[name='age']").each(function(index, item) {
			if ($.trim($(this).val()) != "" && $.trim($(this).val()) != null) {
				return true;
			}

			alert('나이의 ' + (index + 1) + '번째 칸이 비어있습니다.');
			NeedToStop = 1;
			$(this).focus();
			return false;
		});

		if (NeedToStop == 1) {
			return -1;
		}

		var actingRole = $("input[name='role']").map(
				function(index, element) {
					if ($.trim($(this).val()) != ""
							&& $.trim($(this).val()) != null) {
						return $.trim($(this).val());
					}

					return element.innerHTML = "" + index;

				}).get().join("_");

		var actingRoleGender = $("input[name='gender']").map(function(index, element) {
			if ($.trim($(this).val()) != "" && $.trim($(this).val()) != null) {
				return $.trim($(this).val());
			}

			return element.innerHTML = "" + index;

		}).get().join("_");

		var actingRoleAge = $("input[name='age']").map(function(index, element) {
			if ($.trim($(this).val()) != "" && $.trim($(this).val()) != null) {
				return $.trim($(this).val());
			}

			return element.innerHTML = "" + index;

		}).get().join("_");

		form.actingRole.value = actingRole;
		form.actingRoleGender.value = actingRoleGender;
		form.actingRoleAge.value = actingRoleAge;

		alert('form.actingRole.value : ' + form.actingRole.value);
		alert('form.actingRoleGender.value : ' + form.actingRoleGender.value);
		alert('form.actingRoleAge.value : ' + form.actingRoleAge.value);

		return 1;
	}

	function ArtworkWriteForm__submit(form) {
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			form.name.focus();
			alert('영화제목을 입력해주세요.');

			return;
		}

		form.genre.value = form.genre.value.trim();

		if (form.genre.value.length == 0) {
			form.genre.focus();
			alert('장르를 입력해주세요');

			return;
		}

		form.investor.value = form.investor.value.trim();

		if (form.investor.value.length == 0) {
			form.investor.focus();
			alert('투자사를 입력해주세요.');

			return;
		}

		form.productionName.value = form.productionName.value.trim();

		if (form.productionName.value.length == 0) {
			form.productionName.focus();
			alert('제작사를 입력해주세요.');

			return;
		}

		form.directorName.value = form.directorName.value.trim();

		if (form.directorName.value.length == 0) {
			form.directorName.focus();
			alert('감독이름을 입력해주세요.');

			return;
		}

		form.leadActor.value = form.leadActor.value.trim();

		if (form.leadActor.value == 0) {
			form.leadActor.focus();
			alert('주연(출연)을 입력해주세요.');

			return;
		}

		var result = 1;
		if ($('#actingRole-box-switch').attr("data-displayStatus") == "-1") {
			result = checkActingRoleBoxResult(form);
		}

		if (result == -1) {
			return;
		}

		form.etc.value = form.etc.value.trim();

		if (form.etc.value == 0) {
			form.etc.focus();
			alert('줄거리를 입력해주세요.');

			return;
		}

		form.startDate.value = form.startDate.value.trim();

		if (form.startDate.value == 0) {
			form.startDate.focus();
			alert('모집시작일을 입력해주세요.');

			return;
		}

		form.endDate.value = form.endDate.value.trim();

		if (form.endDate.value == 0) {
			form.endDate.focus();
			alert('마감일을 입력해주세요.');

			return;
		}

		var startUploadFiles = function(onSuccess) {
			var needToUpload = false;

			if (needToUpload == false
					&& form.file__artwork__0__common__attachment__1) {
				needToUpload = form.file__artwork__0__common__attachment__1
						&& form.file__artwork__0__common__attachment__1.value.length > 0;
			}

			if (needToUpload == false) {
				onSuccess();
				return;
			}

			var fileUploadFormData = new FormData(form);

			$.ajax({
				url : '../../usr/file/doUploadAjax',
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
<div class="con p-4">
	<span class="font-bold text-xl">Casting Call 등록</span>
</div>

<form method="POST" class="bg-gray-200 p-4 w-full h-full"
	action="doWriteArtwork"
	onsubmit="ArtworkWriteForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="detailArtwork?id=#id">
	<input type="hidden" name="fileIdsStr">
	<input type="hidden" name="actingRole" />
	<input type="hidden" name="actingRoleGender" />
	<input type="hidden" name="actingRoleAge" />

	<div class="con">
		<div class="text-sm font-bold">캐스팅콜 등록에 관한설명</div>
		<div class="text-xs pb-4">캐스팅 콜 등록에 관한 설명 설명 설명 설명 설명 설명 설명 설명
			설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명</div>

		<div class="flex justify-center">
			<label class="flex-grow">
				<input id="artwork-file" class="text-sm cursor-pointer hidden "
					accept="${appConfig.getAttachemntFileInputAccept('img')}"
					name="file__artwork__0__common__attachment__1" type="file">
				<div
					class=" mb-4 w-full text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600">
					대표 이미지를 선택해주세요</div>
			</label>
		</div>
		<div id="artwork-box" class="flex justify-center">
			<img id="artwork-profile" class="max-w-xs" src="" alt="" />
		</div>

		<div class="form-control-box pb-4 flex-grow">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="text" placeholder="영화제목" name="name" maxlength="100" />
		</div>
		<div class="form-control-box mb-4 flex-grow relative">
			<select name="genre"
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
				<option value="action">액션</option>
				<option value="SF">SF</option>
				<option value="comedy">코미디</option>
				<option value="thriller">스릴러</option>
				<option value="war">전쟁</option>
				<option value="sports">스포츠</option>
				<option value="fantasy">판타지</option>
				<option value="music">음악</option>
				<option value="romance">멜로</option>
			</select>
			<div
				class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
				<i class="fas fa-chevron-down"></i>
			</div>
		</div>

		<div class="form-control-box w-full pb-4">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="text" placeholder="투자사" name="investor" maxlength="100" />
		</div>
		<div class="form-control-box w-full pb-4">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="text" placeholder="제작사" name="productionName" maxlength="100" />
		</div>
		<div class="form-control-box w-full pb-4">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="text" placeholder="감독명." name="directorName" maxlength="100" />
		</div>
		<div class="form-control-box w-full pb-4">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="text" placeholder="주연(출연)" name="leadActor" maxlength="100" />
		</div>
		<div class="form-control-box w-full flex justify-center pb-2">
			<div class="pr-2">모집배역</div>
			<div id="actingRole-box-switch"
				class="text-2xl flex items-center justify-center"
				data-displayStatus=1 onclick="javascript:showActingRoleBox()">
				<i class="far fa-plus-square"></i>
			</div>
		</div>
		<div id="actingRole-box">
			<div class="actingRole-box flex-grow flex">
				<button type="button" class="absolute top-0 text-2xl"
					onclick="javascript:addActingRoleBox()">
					<i class="far fa-plus-square"></i>
				</button>
			</div>
		</div>
		<div class="form-control-box w-full pb-4">
			<textarea
				class="resize-none shadow appearance-none border rounded-lg w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline h-72"
				name="etc" placeholder="줄거리를 입력해주세요."></textarea>
		</div>
		<div class="pb-4 text-center">모집일정</div>
		<div class="form-control-box w-full pb-4 flex items-center">
			<input
				class="border rounded-full flex-grow py-2 pl-2 focus:outline-none focus:shadow-outline"
				type="date" name="startDate" />
			<span>~</span>
			<input
				class="border rounded-full flex-grow py-2 pl-2 focus:outline-none focus:shadow-outline"
				type="date" name="endDate" />
		</div>

		<button class="btn btn-primary" type="submit">작성</button>
		<a class="btn btn-info" href="${listUrl}">리스트</a>
	</div>
</form>

<script>
	$('#artwork-file').on('change', function() {

		const files = $("#artwork-file")[0].files;
		const file = $("#artwork-file")[0].files[0];

		if (files.length != 0) {
			const imgurl = URL.createObjectURL(file);
			$('#artwork-profile').attr("src", imgurl);
			$('#artwork-box').css("padding", "0 0 10px");

			URL.revokeObjectURL(file);

		} else {
			//파일이 없는 경우 내용을 지워준다.
			$('#artwork-profile').attr("src", "");
			$('#artwork-box').css("padding", "0");
		}
	});

	function addActingRoleBox(title) {

		let html = '';

		html += '<div class="actingRole-input flex flex-grow">';
		html += '<input name="role" class="w-10 shadow appearance-none border rounded-full flex-grow mb-2 py-2 pl-2 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="text" placeholder="역할" />';
		html += '<input name="gender" class="w-10 shadow appearance-none border rounded-full flex-grow mb-2 py-2 pl-2 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="text" placeholder="성별" />';
		html += '<input name="age" class="w-10 shadow appearance-none border rounded-full flex-grow mb-2 py-2 pl-2 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="text" placeholder="나이" />';
		html += '<button class="text-2xl self-start" onclick="removeActingRoleBox(this)">';
		html += '<i class="far fa-minus-square"></i>';
		html += '</button>';
		html += '</div>';

		$('#actingRole-input-box').append(html);

	}

	function removeActingRoleBox(val) {
		$(val).closest("div.actingRole-input").remove();
	}

	function removeActingRoleBoxAndShowSwitch(val) {
		$('#actingRole-box-switch').attr("data-displayStatus", 1);
		$('#actingRole-box-switch').css("display", "flex");

		$('.actingRole-box').css("display", "none");
		$('.actingRole-box').empty();
	}

	function showActingRoleBox(title) {
		$('#actingRole-box-switch').attr("data-displayStatus", -1);
		$('#actingRole-box-switch').css("display", "none");

		html = '';

		html += '<button type="button" class="self-start text-2xl" onclick="javascript:addActingRoleBox()">';
		html += '<i class="far fa-plus-square"></i>';
		html += '</button>';

		html += '<div id="actingRole-input-box" class="flex-grow pl-2">';
		html += '<div class="actingRole-input flex flex-grow">';
		html += '<input name="role" class="w-10 shadow appearance-none border rounded-full flex-grow mb-2 py-2 pl-2 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="text" placeholder="역할"/>';
		html += '<input name="gender" class="w-10 shadow appearance-none border rounded-full flex-grow mb-2 py-2 pl-2 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="text" placeholder="성별"/>';
		html += '<input name="age" class="w-10 shadow appearance-none border rounded-full flex-grow mb-2 py-2 pl-2 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="text" placeholder="나이" />';
		html += '<button type="button" class="self-start text-2xl" onclick="javascript:removeActingRoleBoxAndShowSwitch(this)">';
		html += '<i class="far fa-trash-alt"></i>';
		html += '</button>';
		html += '</div>';
		html += '</div>';

		$('.actingRole-box').prepend(html);
		$('.actingRole-box').css("display", "flex");
	}
</script>
<%@ include file="../part/foot.jspf"%>