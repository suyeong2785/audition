<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/head.jspf"%>
<%@ include file="../../part/toastuiEditor.jspf"%>

<script>
	function ApplymentWriteForm__submit(form) {
		if($('.toast')){
			window.toastr.remove();
		}
		
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}
		
		if (form.videoStatus.value != 1) {
			form.videoStatus.focus();
			
			var msg = "지원자 영상을 업로드해주세요";
			var targetName = "videoStatus"
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			
			return;
		}

		var startUploadFiles = function(onSuccess) {
			
			var needToUpload = form.file__applyment__0__common__attachment__1.value.length > 0;

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
		
		startUploadFiles(function(data) {
			
			var fileIdsStr = '';

			if (data && data.body && data.body.fileIdsStr) {
				fileIdsStr = data.body.fileIdsStr;
			}

			form.fileIdsStr.value = fileIdsStr;
			form.file__applyment__0__common__attachment__1.value = '';

			form.submit();
		});
	}
</script>
<form method="POST" action="doWrite"
	onsubmit="ApplymentWriteForm__submit(this); return false;">
	<input type="hidden" name="fileIdsStr" />
	<input type="hidden" name="relTypeCode" value="actingRole" />
	<input type="hidden" name="relId" value="${actingRole.id}" />
	<input type="hidden" name="redirectUri"
		value="/usr/home/showMyAudition">

	<div class="con">
		<div class=" flex flex-col">
			<div class="max-height-360 relative overflow-hidden">
				<div class="relative padding-bottom-50">
					<c:choose>
						<c:when test="${artworkFileUrl != '' && artworkFileUrl != null }">
							<img
								class="absolute top-2/4 left-2/4 transform -translate-x-1/2 -translate-y-1/2 h-full"
								src="${artworkFileUrl}" alt="" />
						</c:when>
						<c:otherwise>
							<div
								class="flex justify-center items-center absolute text-7xl h-full w-full bg-gray-600 text-white top-2/4 left-2/4 transform -translate-x-1/2 -translate-y-1/2 capitalize">
								${actingRole.role}</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div
					class="absolute bottom-0 left-2/4 transform -translate-x-1/2  bg-black text-white opacity-40 text-opacity-0 z-10 w-full"
					style="height: 253px;"></div>
				<div
					class="absolute bottom-0 transform text-white w-full z-20"
					style="height: 253px;">
					<div class="absolute top-0 mt-14 left-2/4 transform -translate-x-1/2 text-2xl font-bold">${artworkTitle}</div>
					<div class="absolute bottom-0 mb-14 left-2/4 transform -translate-x-1/2 text-2xl font-bold">${actingRole.gender}
						${actingRole.role} ${actingRole.age}</div>
				</div>
			</div>
			<div class="grid p-6 grid-column-applyment">
				<div class="grid content-between text-sm font-black">
					<div>지원자 : ${loginedMember.nickname}</div>
					<div>${loginedMember.age}살</div>
					<div>${loginedMember.cellphoneNo}</div>
					<div>${loginedMember.email}</div>
				</div>
				<div class="grid gap-y-7">
					<div class="text-red-400 text-xs font-black">지원하실 프로필을 확인하시고
						이상이 있으면 프로필을 수정해 주세요</div>
					<div
						class="justify-self-center bg-gray-500 hover:bg-gray-700 text-white rounded-full px-4 ">
						<a
							href="/usr/member/checkPassword?redirectUri=%2Fusr%2Fmember%2Fmodify">프로필
							수정</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="bg-gray-100 ">
		<div class="con p-6">
			<div class="flex text-sm">
				<div>지원하기 를 누르면 이후 촬영 등 지원 과정에 관한 설명 글 지원하기 를 누르면 이후 촬영 등 지원
					과정에 관한 설명 글 지원하기 를 누르면 이후 촬영 등 지원 과정에 관한 설명 글 지원하기 를 누르면 이후 촬영 등 지원
					과정에 관한 설명 글 지원하기 를 누르면 이후 촬영 등 지원 과정에 관한 설명 글</div>
			</div>
		</div>
	</div>
	<div class="bg-gray-100 ">
		<div class="con p-6">
			<div class="flex flex-col justify-center">
				<input type="text" class="w-0 h-0" name="videoStatus" value="0" />
				<label class="flex-grow">
					<input id="actingRole-video-input" type="file"
						class="text-sm cursor-pointer hidden "
						name="file__applyment__0__common__attachment__1"
						accept="${appConfig.getAttachemntFileInputAccept('video')}" />
					<div id="guide-video"
						class=" text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600">
						지원하실 동영상을 업로드해주세요.</div>
				</label>
				<video id="actingRole-video"
					class="hidden pt-4 mx-auto max-height-360" controls src=""></video>
			</div>
		</div>
	</div>
	<div class="flex justify-center items-center py-8">
		<button
			class=" bg-green-500 hover:bg-green-700 text-white py-2 rounded-full px-4"
			type="submit">오디션 지원하기</button>
	</div>
</form>

<script>
//오디션가이드영상 올릴시 작동
let videoInput = $('#actingRole-video-input');
let videoForDisplay = $('#actingRole-video');

videoInput.on("change", function() {
	const video = document.createElement ( "VIDEO" );
	const files = videoInput[0].files;
	const file = files[0];
	
	if(files.length != 0){
		const fileName = file.name;
		const videourl = URL.createObjectURL(file);
		
		videoForDisplay.attr("src", videourl);
		videoForDisplay.css("display","block");
		
		videoForDisplay.on('loadedmetadata',function(){
			var duration =  Math.floor(videoForDisplay[0].duration);
			var oneMinute = Math.floor(videoForDisplay[0].duration > 60 ? videoForDisplay[0].duration/60 : 0);
			
			// 동영상 재생시간이 1분 30초 이상이 넘어간다면 초기화 후,알림창띄움
			if(duration > 90){
				$('input[name="videoStatus"]').val(0);
				alert('동영상이 1분 30초를 넘겨서는 안됩니다!');
				
				videoInput.val("");
				videoForDisplay.css("display","none");
				videoForDisplay.attr("src", "");
				URL.revokeObjectURL(file);
				
				//jquery html이 동작이 안되서 약간 동작을 이후에 해줌
				setTimeout(() => {
					$("#guide-video").html("가이드 영상을 올려주세요.");
				}, 100);
				
				return;
				
			}else{
				$('input[name="videoStatus"]').val(1);
				$("#guide-video").html("파일이름 : " + fileName + "<br>" + "총 재생시간 : "
						+ (oneMinute > 0 ? oneMinute + "분 " : "") + 
				(duration - oneMinute * 60) + "초");
			}
			
		});

	} else {
		//파일이 없는 경우 내용을 지워준다.
		$('input[name="videoStatus"]').val(0);
		videoForDisplay.css("display","none");
		$("#guide-video").html("동영상을 업로드해주세요.");
		videoForDisplay.attr("src", "");
		URL.revokeObjectURL(file);
	}
});
</script>

</div>
</body>
</html>
