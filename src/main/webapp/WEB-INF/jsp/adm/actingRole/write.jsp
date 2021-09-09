<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/head.jspf"%>
<%@ include file="../../part/toastuiEditor.jspf"%>


<script>
	function ActingRoleWriteForm__submit(form) {
		if($('.toast')){
			window.toastr.remove();
		}
		
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		form.thumbnailStatus.value = form.thumbnailStatus.value.trim();

		if (form.thumbnailStatus.value == 0 ) {
			form.thumbnailStatus.focus();

			var msg = "썸네일 이미지를 등록해주세요";
			var targetName = "thumbnailStatus"
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);

			return;
		}

		form.genre.value = form.genre.value.trim();

		if (form.genre.value.length == 0) {
			form.genre.focus();
			
			var msg = "장르를 입력해주세요";
			var targetName = "genre"
			var targetType = "select";
			var toastr = setPositionOfToastr(targetType,targetName,msg);

			return;
		}
		
		form.actingRole.value = form.actingRole.value.trim();

		if (form.actingRole.value.length == 0) {
			form.actingRole.focus();
			
			var msg = "배역을 선택해주세요";
			var targetName = "actingRole"
			var targetType = "select";
			var toastr = setPositionOfToastr(targetType,targetName,msg);

			return;
		}
		
		form.job.value = form.job.value.trim();

		if (form.job.value.length == 0) {
			form.job.focus();
			
			var msg = "직업을 입력해주세요";
			var targetName = "job"
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);

			return;
		}
		
		form.feature.value = form.feature.value.trim();

		if (form.feature.value.length == 0) {
			form.feature.focus();

			var msg = "주요사항을 입력해주세요";
			var targetName = "feature"
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			
			return;
		}
		
		form.schedule.value = form.schedule.value.trim();

		if (form.schedule.value.length == 0) {
			form.schedule.focus();
			
			var msg = "촬영일정을 입력해주세요";
			var targetName = "schedule"
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			
			return;
		}
		
		form.shootingsCount.value = form.shootingsCount.value.trim();

		if (form.shootingsCount.value.length == 0) {
			form.shootingsCount.focus();
			
			var msg = "촬영횟수를 입력해주세요";
			var targetName = "shootingsCount"
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);

			return;
		}
		
		form.region.value = form.region.value.trim();

		if (form.region.value.length == 0) {
			var targetOffset = $('select[name="sido"]').offset();
			window.scrollTo({top : targetOffset.top - 500, behavior:'auto'});

			form.sido.focus();

			var msg = "촬영지역를 입력해주세요";
			var targetName = "sido"
			var targetType = "select";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			
			return;
		}
		
		form.pay.value = form.pay.value.trim();

		if (form.pay.value.length == 0) {
			form.pay.value = "개별협의"
		}

		form.shotAngle.value = form.shotAngle.value.trim();

		if (form.shotAngle.value == 0) {
			form.shotAngle.focus();
			
			var msg = "요청하는 촬영방식을 입력해주세요.";
			var targetName = "shotAngle"
			var targetType = "select";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			
			return;
		}
		
		//가이드영상 주소넣어줌
		if (form.shotAngle.value != 0) {
			if(form.shotAngle.value == "BS"){
				form.guideVideoUrl.value = "v=rtOvBOTyX00";
			}else if(form.shotAngle.value == "WS"){
				form.guideVideoUrl.value = "v=JRfuAukYTKg";
			}else if(form.shotAngle.value == "KS"){
				form.guideVideoUrl.value = "v=uO59tfQ2TbA";
			}else if(form.shotAngle.value == "FS"){
				form.guideVideoUrl.value = "v=kTHNpusq654";
			}else if(form.shotAngle.value == "CU"){
				form.guideVideoUrl.value = "v=PT2_F-1esPk";
			}
		}
		
		if (form.requestedActing.value == '') {
			form.requestedActing.focus();
			
			var msg = "요청하는 연기방식을 입력해주세요.";
			var targetName = "requestedActing"
			var targetType = "select";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			
			return;
		}
		
		form.scriptStatus.value = form.scriptStatus.value.trim();
		
		if (form.requestedActing.value == 1) {
			if(form.scriptStatus.value == 0){
				form.scriptStatus.focus();
			
				var msg = "대본을 업로드해주세요";
				var targetName = "scriptStatus"
				var targetType = "input";
				var toastr = setPositionOfToastr(targetType,targetName,msg);
				
				return;
			}
		}
		
		form.startDate.value = form.startDate.value.trim();

		if (form.startDate.value == 0) {
			form.startDate.focus();
			
			var msg = "모집시작일을 입력해주세요.";
			var targetName = "startDate"
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			
			return;
		}

		form.endDate.value = form.endDate.value.trim();

		if (form.endDate.value == 0) {
			form.endDate.focus();
			
			var msg = "마감일을 입력해주세요";
			var targetName = "endDate"
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);

			return;
		}

		var startUploadFiles = function(onSuccess) {
			
			var needToUpload = false;

			if (form.file__actingRole__0__thumbnail__attachment__1) {
				needToUpload = form.file__actingRole__0__thumbnail__attachment__1 
				&& form.file__actingRole__0__thumbnail__attachment__1.value.length > 0;
				
			}else if(form.file__actingRole__0__script__attachment__1){
				needToUpload = form.file__actingRole__0__script__attachment__1 
				&& form.file__actingRole__0__script__attachment__1.value.length > 0;
				
			}else if(form.file__actingRole__0__guide__attachment__1){
				needToUpload = form.file__actingRole__0__guide__attachment__1 
				&& form.file__actingRole__0__guide__attachment__1.value.length > 0;
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
	<span class="font-bold text-xl">Audition 등록</span>
</div>

<form method="POST" class="bg-gray-200 p-4 w-full h-full"
	onsubmit="ActingRoleWriteForm__submit(this); return false;"
	action="doWrite">
	<input type="hidden" name="redirectUri" value="detail?id=#id">
	<input type="hidden" name="fileIdsStr">
	<input type="hidden" name="memberId" value="${loginedMemberId}" />

	<div class="con">
		<div class="text-sm font-bold">캐스팅콜 등록에 관한설명</div>
		<div class="text-xs pb-4">캐스팅 콜 등록에 관한 설명 설명 설명 설명 설명 설명 설명 설명
			설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명</div>

		<!-- 섬네일 -->
		<div class="flex justify-center">
			<input type="text" class="h-0 w-0" name="thumbnailStatus" value="0" />
			<label class="flex-grow" for="thumbnail-file">
				<input id="thumbnail-file" class="text-sm cursor-pointer hidden "
					accept="${appConfig.getAttachemntFileInputAccept('img')}"
					name="file__actingRole__0__thumbnail__attachment__1" type="file">
				<div id="actingRole-thumbnail"
					class=" mb-4 w-full text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600">
					대표 이미지를 선택해주세요</div>
			</label>
		</div>

		<!-- 영화목록 -->
		<div class="mb-4 flex-grow relative">
			<input type="hidden" name="artworkId" value="" />
			<select name="genre"
				class="text-center shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				style="width: 100%; text-align-last: center;">
				<option selected="selected" value="">선택하세요</option>
				<c:forEach items="${artworks}" var="artwork">
					<option value="${artwork.actingRole}"
						value2="${artwork.actingRoleGender}"
						value3="${artwork.actingRoleAge}" value4="${artwork.id}">${artwork.name}</option>
				</c:forEach>
			</select>
			<div
				class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
				<i class="fas fa-chevron-down"></i>
			</div>
		</div>

		<!-- 배역목록 -->
		<div class="mb-4 flex-grow relative">
			<input type="hidden" name="name" />
			<input type="hidden" name="gender" />
			<input type="hidden" name="age" />
			<select disabled name="actingRole" style="text-align-last: center;"
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
			</select>
			<div
				class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
				<i class="fas fa-chevron-down"></i>
			</div>
		</div>

		<!-- 배역직업 -->
		<div class="w-full pb-4">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="text" placeholder="직업" name="job" maxlength="100" />
		</div>

		<!-- 배역특징 -->
		<div class="w-full pb-4">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="text" placeholder="주요사항" name="feature" maxlength="100" />
		</div>

		<!-- 촬영일정 -->
		<div class="text-center pb-4">
			<span>촬영일정</span>
			<div>
				<label for="month">
					월
					<input id="month" name="scheduleOption" type="radio" value="month" />
				</label>
				<label for="date">
					일
					<input id="date" name="scheduleOption" type="radio" value="date" />
				</label>
				<label for="typing">
					직접입력
					<input id="typing" name="scheduleOption" type="radio"
						value="typing" />
				</label>
			</div>
		</div>

		<div class="flex pb-4">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="month" name="schedule" />
		</div>

		<!-- 촬영횟수 -->
		<div class="flex pb-4">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="number" placeholder="촬영횟수" name="shootingsCount" />
		</div>

		<!-- 촬영지역 -->
		<div class="text-center pb-4">촬영지역</div>

		<div class="flex pb-4">
			<input type="hidden" name="region" />
			<select name="sido" id="sido1"
				class="text-center shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"></select>
			<select name="gugun" id="gugun1"
				class="text-center shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"></select>
		</div>

		<!-- 출연료 -->
		<div class="w-full pb-4">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="text" placeholder="출연료(미작성시 개별협의 자동등록)" name="pay"
				maxlength="100" />
		</div>

		<!-- 오디션영상 촬영앵글 -->
		<div class="text-center pb-4">오디션영상 요청사항</div>
		<div class="w-full pb-4">
			<input type="hidden" name="guideVideoUrl" />
			<select name="shotAngle"
				class="text-center shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
				<option selected="selected" value="">선택해주세요</option>
				<option value="BS">Bust Shot</option>
				<option value="WS">Waist Shot</option>
				<option value="KS">Knee Shot</option>
				<option value="FS">Full Shot</option>
				<option value="CU">Close up(얼굴 위주)</option>
			</select>
		</div>

		<!-- 오디션영상 지정/자유연기 -->
		<div class="w-full pb-4">
			<select name="requestedActing"
				class="text-center shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
				<option selected="selected" value="">선택해주세요</option>
				<option value="0">자유연기</option>
				<option value="1">지정연기</option>
			</select>
		</div>

		<!-- 오디션 대본 -->
		<div id="script-box" class=" flex-col justify-center mb-4 hidden ">
			<input type="text" class="w-0 h-0" name="scriptStatus" value="0" />
			<label class="flex-grow">
				<input type="file" class="text-sm cursor-pointer hidden"
					id="actingRole-script-input"
					name="file__actingRole__0__script__attachment__1"
					accept="${appConfig.getAttachemntFileInputAccept('document')}" />
				<div id="script"
					class="w-full text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600">
					대본을 업로드 해주세요.</div>
			</label>
		</div>

		<!-- 오디션 모집일정 -->
		<div class="pb-4 text-center">모집일정</div>
		<div class="w-full pb-4 flex items-center">
			<span class="pr-2">From</span>
			<input
				class="border rounded-full flex-grow py-2 pl-2 focus:outline-none focus:shadow-outline"
				type="date" name="startDate" />
		</div>
		<div class="w-full pb-4 flex items-center">
			<span class="pr-2">Until</span>
			<input
				class="border rounded-full flex-grow py-2 pl-2 focus:outline-none focus:shadow-outline"
				type="date" name="endDate" />
		</div>

		<!-- 작성버튼 -->
		<button class="btn btn-primary" type="submit">작성</button>
		<a class="btn btn-info" href="${listUrl}">리스트</a>
	</div>
</form>

<script>
	const actingRoleThumbnail = $('#thumbnail-file');
	
	actingRoleThumbnail.on('change', function() {

		const files = actingRoleThumbnail[0].files;
		const file = files[0];

		if (files.length != 0) {
			const fileName = file.name;
			
			$('input[name="thumbnailStatus"]').val('1');
			$('#actingRole-thumbnail').html("파일이름 : " + fileName);
			
		} else {
			//파일이 없는 경우 내용을 지워준다.
			$('input[name="thumbnailStatus"]').val('0');
			$('#actingRole-thumbnail').html("대표 이미지를 선택해주세요");
			
		}
	});
	
	// 지정연기/자유연기 여부에 따라 대본첨부 input 표시
	
	$('select[name="requestedActing"]').change(function() {
		$('#script-box').css("display","none");
		
		var optionVal = $('select[name="requestedActing"] > option:selected').val();
		
		if(optionVal == "1"){
			$('#script-box').css("display","flex");
		}

	});
	
	//pdf파일 첨부시 #script에 파일이름을 표시해준다.
	var scriptInput = $('#actingRole-script-input');
	var script = $('#script');
	var scriptResult = $('input[name="scriptStatus"]');
	
	scriptInput.on('change', function() {
		
		const files = scriptInput[0].files;
		const file = scriptInput[0].files[0];
		
		if(files.length != 0){
			
			var fileName = file.name;
			scriptResult.val('1');
			script.html("파일이름 : " + fileName);
			
		}else {
			//파일이 없는 경우 내용을 지워준다.
			scriptResult.val('0');
			script.html("대본을 업로드 해주세요.");
		}
		
	});
	
	//촬영일정 입력방법 선택에따라 input type 바꿔줌
	$('input[name="scheduleOption"]').change(function() {
		if($('input[name="scheduleOption"]:checked').val() == "month" ){
			$('input[name="schedule"]').attr("type", "month");
		}else if($('input[name="scheduleOption"]:checked').val() == "date" ){
			$('input[name="schedule"]').attr("type", "date");
		}else{
			$('input[name="schedule"]').attr("type", "text");
		}
	});
	
	$('#thumbnail-file').on('change', function() {

		const files = $("#thumbnail-file")[0].files;
		const file = $("#thumbnail-file")[0].files[0];

		if (files.length != 0) {
			const imgurl = URL.createObjectURL(file);
			$('#actingRole-profile').attr("src", imgurl);
			$('#actingRole-box').css("padding", "0 0 10px");

			URL.revokeObjectURL(file);

		} else {
			//파일이 없는 경우 내용을 지워준다.
			$('#actingRole-profile').attr("src", "");
			$('#actingRole-box').css("padding", "0");
		}
	});

	$('select[name="genre"]').change(function() {

		$('select[name="actingRole"]').empty();

		var option = $("select[name='genre'] > option:selected");

		if (option.val() != null && option.val() != '') {
			var actingRole = option.val(); //기본 value값
			var actingRoleGender = option.attr("value2"); //지정 value2 값
			var actingRoleAge = option.attr("value3"); //지정 value3값
			var artworkId = option.attr("value4"); //지정 value4값

			var actingRoles = actingRole.split('_');
			var actingRoleGenders = actingRoleGender.split('_');
			var actingRoleAges = actingRoleAge.split('_');
			
			var allData = { "artworkId": artworkId, "names": actingRoles };
			
			$.ajax({
				url : '/adm/actingRole/checkActingRoleAvailableByArtworkIdAndNamesAndAgesAndGendersAjax',
				type : 'GET',
				data : allData,
				success:function(data){
					if(data != null && data.body != null){
						var actingRolesAjax = data.body.actingRoles;
						
						var count = 0;
						actingRoles = actingRoles.filter((actingRole, index) => { 
			        		for(var i = 0; i < actingRolesAjax.length; i++){
			        			if(actingRole != actingRolesAjax[i].name){
			        				count = index;
			        				return true;	
			        			} 
			        		}
						});
						actingRoleGenders = actingRoleGenders.filter((actingRoleGender, index) => {
			        		if(count == index){
			        			return actingRoleGender != actingRolesAjax[i].gender;
			        		}
						});
						actingRoleAges = actingRoleAges.filter((actingRoleAge, index) => { 
							if(count == index){
			        			return actingRoleAge != actingRolesAjax[i].age;
			        		}
						});
						
					}
					var html = '';

					html += '<option value="">선택하세요</option>';
					for (var i = 0; i < actingRoles.length; i++) {
						html += '<option value="'+ actingRoles[i] + '" value2="'+ (actingRoleGenders[i]) + '" value3="'+ actingRoleAges[i] + '">'
								+ actingRoles[i]
								+ '/'
								+ actingRoleGenders[i]
								+ '/'
								+ actingRoleAges[i] + '</option>';
					}

					$('select[name="actingRole"]').removeAttr(
							"disabled");
					$('select[name="actingRole"]').append(html);
					$('input[name="artworkId"]').val(artworkId);	
		        },
				error:function(data){
		           
		        }
			});

		} else {
			$('input[name="artworkId"]').val("");
			$('select[name="actingRole"]').attr("disabled",
					"disabled");
		}

	});
	
	//배역을 정할시
	$('select[name="actingRole"]').change(function() {
		
		var option = $("select[name='actingRole'] > option:selected");
		
		if (option.val() != null && option.val() != '') {
			console.log(option.val());
			console.log(option.attr("value2"));
			console.log(option.attr("value3"));
			
			$('input[name="name"]').val(option.val()); //기본 value값
			$('input[name="gender"]').val(option.attr("value2")); //지정 value2 값
			$('input[name="age"]').val(option.attr("value3")); //지정 value3 값
		}
		
	});

	$("select[name=sido]").each(function() {
		
		var area0 = [ "시/도 선택", "서울특별시", "인천광역시", "대전광역시",
		"광주광역시", "대구광역시", "울산광역시", "부산광역시", "경기도",
		"강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도",
		"경상남도", "제주도" ];
		
		$selsido = $(this);
		
		$.each(area0,function() {
			$selsido.append("<option value='"+this+"'>"+ this + "</option>");
		});
		
		$selsido.next().append("<option value=''>구/군 선택</option>");
	});

	// 시/도 선택시 구/군 설정

	$("select[name=sido]").change(function() {
		
		area = [ [ "강남구", "강동구", "강북구", "강서구", "관악구", "광진구",
			"구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구",
			"마포구", "서대문구", "서초구", "성동구", "성북구", "송파구",
			"양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구" ]
		, [ "계양구", "남구", "남동구", "동구", "부평구", "서구",
				"연수구", "중구", "강화군", "옹진군" ]
		, [ "대덕구", "동구", "서구", "유성구", "중구" ]
		, [ "광산구", "남구", "동구", "북구", "서구" ]
		, [ "남구", "달서구", "동구", "북구", "서구", "수성구",
				"중구", "달성군" ]
		, [ "남구", "동구", "북구", "중구", "울주군" ]
		, [ "강서구", "금정구", "남구", "동구", "동래구", "부산진구",
				"북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구",
				"중구", "해운대구", "기장군" ]
		, [ "고양시", "과천시", "광명시", "광주시", "구리시", "군포시",
				"김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시",
				"시흥시", "안산시", "안성시", "안양시", "양주시", "오산시",
				"용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시",
				"포천시", "하남시", "화성시", "가평군", "양평군", "여주군", "연천군" ]
		, [ "강릉시", "동해시", "삼척시", "속초시", "원주시", "춘천시",
				"태백시", "고성군", "양구군", "양양군", "영월군", "인제군",
				"정선군", "철원군", "평창군", "홍천군", "화천군", "횡성군" ]
		, [ "제천시", "청주시", "충주시", "괴산군", "단양군",
				"보은군", "영동군", "옥천군", "음성군", "증평군", "진천군", "청원군" ]
		, [ "계룡시", "공주시", "논산시", "보령시", "서산시",
				"아산시", "천안시", "금산군", "당진군", "부여군", "서천군",
				"연기군", "예산군", "청양군", "태안군", "홍성군" ]
		, [ "군산시", "김제시", "남원시", "익산시", "전주시",
				"정읍시", "고창군", "무주군", "부안군", "순창군", "완주군",
				"임실군", "장수군", "진안군" ]
		, [ "광양시", "나주시", "목포시", "순천시", "여수시",
				"강진군", "고흥군", "곡성군", "구례군", "담양군", "무안군",
				"보성군", "신안군", "영광군", "영암군", "완도군", "장성군",
				"장흥군", "진도군", "함평군", "해남군", "화순군" ]
		, [ "경산시", "경주시", "구미시", "김천시", "문경시",
				"상주시", "안동시", "영주시", "영천시", "포항시", "고령군",
				"군위군", "봉화군", "성주군", "영덕군", "영양군", "예천군",
				"울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군" ]
		, [ "거제시", "김해시", "마산시", "밀양시", "사천시",
				"양산시", "진주시", "진해시", "창원시", "통영시", "거창군",
				"고성군", "남해군", "산청군", "의령군", "창녕군", "하동군",
				"함안군", "함양군", "합천군" ]
		, [ "서귀포시", "제주시", "남제주군", "북제주군" ]
		
		];
		
		let index = $("select[name=sido] > option:selected").index(); // 선택지역의 구군 Array
		var $gugun = $(this).next(); // 선택영역 군구 객체
		$("option", $gugun).remove(); // 구군 초기화
		
		if (index == "0")
			$gugun.append("<option value=''>구/군 선택</option>");
		else {
			$gugun.append("<option value=''>구/군 선택</option>");
			$.each( area[index-1] ,function() {
				$gugun.append("<option value='"+this+"'>"+ this + "</option>");
			});
		}
	});

	$("select[name=sido]").change(function() {
		
		var option = $("select[name='sido'] > option:selected");
		
		$("input[name=region]").val("");
		
		if(option.val() != "시/도 선택"){
			$("input[name=region]").val(option.val());	
		}
	});
	
	$("select[name=gugun]").change(function() {
		
		var sidoOption = $("select[name='sido'] > option:selected");
		var gugunOption = $("select[name='gugun'] > option:selected");
		
		$("input[name=region]").val(sidoOption.val() + " " + gugunOption.val());
	});
	
</script>
<%@ include file="../part/foot.jspf"%>