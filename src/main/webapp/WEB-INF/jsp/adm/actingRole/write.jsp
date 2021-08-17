<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/head.jspf"%>
<%@ include file="../../part/toastuiEditor.jspf"%>

<script>

	function ActingRoleWriteForm__submit(form) {
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			form.name.focus();
			alert('');

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
			form.investor.value = "개별안내";
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
			form.directorName.value = "개별안내";
			return;
		}

		form.leadActor.value = form.leadActor.value.trim();

		if (form.leadActor.value.length == 0) {
			form.leadActor.value = "개별안내";
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

			if (form.file__actingRole__0__thumbnail__attachment__1) {
				needToUpload = form.file__artwork__0__common__attachment__1 
				&& form.file__artwork__0__common__attachment__1.value.length > 0;
				
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
	action="doWrite"
	onsubmit="ActingRoleWriteForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="detailArtwork?id=#id">
	<input type="hidden" name="fileIdsStr">
	<input type="hidden" name="memberId" value="${loginedMemberId}" />

	<div class="con">
		<div class="text-sm font-bold">캐스팅콜 등록에 관한설명</div>
		<div class="text-xs pb-4">캐스팅 콜 등록에 관한 설명 설명 설명 설명 설명 설명 설명 설명
			설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명</div>
		
		<!-- 섬네일 -->
		<div class="flex justify-center">
			<label class="flex-grow">
				<input id="actingRole-file" class="text-sm cursor-pointer hidden "
					accept="${appConfig.getAttachemntFileInputAccept('img')}"
					name="file__actingRole__0__thumbnail__attachment__1" type="file">
				<div id="actingRole-thumbnail"
					class=" mb-4 w-full text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600">
					대표 이미지를 선택해주세요</div>
			</label>
		</div>
		
		<!-- 영화목록 -->
		<div class="mb-4 flex-grow relative">
			<select name="genre"
				class="text-center shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				style="width: 100%; text-align-last: center;">
				<option hidden="" disabled="disabled" selected="selected" value="">선택하세요</option>
				<c:forEach items="${artworks}" var="artwork">
					<option value="${artwork.actingRole}"
						value2="${artwork.actingRoleGender}"
						value3="${artwork.actingRoleAge}">${artwork.name}</option>
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
				<label for="month">월
					<input id ="month" name="scheduleOption" type="radio" value="month" />
				</label>
				<label for="date">
					일
					<input id ="date" name="scheduleOption" type="radio" value="date"/>
				</label>
				<label for="typing">
					직접입력
					<input id="typing" name="scheduleOption" type="radio" value="typing"/>
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
				type="number" placeholder="촬영횟수" name="shootingCount" />
		</div>
		
		<!-- 촬영지역 -->
		<div class="text-center pb-4">지역</div>
		
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
				type="text" placeholder="출연료(선택 또는 작성)" name="pay"
				maxlength="100" />
		</div>
		
		<!-- 오디션영상 촬영앵글 -->
		<div class="text-center pb-4">오디션영상 요청사항</div>
		<div class="w-full pb-4">
			<select name="shotAngle"
				class="text-center shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
				<option value="BS">Bust Shot</option>
				<option value="WS">Waist Shot</option>
				<option value="KS">Knee Shot</option>
				<option value="FS">Full Shot</option>
				<option value="CU">Close up(얼굴 위주)</option>
			</select>
		</div>

		<!-- 오디션영상 지정/자유연기 -->
		<div class="w-full pb-4">
			<select name="scriptStatus"
				class="text-center shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
				<option value="0">자유연기</option>
				<option value="1">지정연기</option>
			</select>
		</div>

		<!-- 오디션 대본 -->
		<div class="w-full pb-4">
			<label class="flex-grow">
				<input type="file" class="text-sm cursor-pointer hidden "
					id="actingRole-script-input"
					name="file__actingRole__0__script__attachment__1"
					accept="${appConfig.getAttachemntFileInputAccept('document')}" />
				<div id="script"
					class="hidden w-full text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600">
					대본을 업로드 해주세요.</div>
			</label>
		</div>

		<!-- 오디션 가이드영상 -->
		<div class="w-full pb-4">
			<label class="flex-grow">
				<input id="actingRole-video-input" type="file"
					class="text-sm cursor-pointer hidden "
					name="file__actingRole__0__guide__attachment__1"
					accept="${appConfig.getAttachemntFileInputAccept('video')}" />
				<div id="guide-video"
					class=" w-full text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600">
					가이드 영상을 올려주세요</div>
			</label>
			<video id="actingRole-video"
				class="hidden pt-4 mx-auto max-height-360" controls src=""></video>
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
	const actingRoleThumbnail = $('#actingRole-file');
	
	actingRoleThumbnail.on('change', function() {

		const files = actingRoleThumbnail[0].files;
		const file = files[0];

		if (files.length != 0) {
			const fileName = file.name;
			
			$('#actingRole-thumbnail').html("파일이름 : " + fileName);

		} else {
			//파일이 없는 경우 내용을 지워준다.
			$('#actingRole-thumbnail').html("대표 이미지를 선택해주세요");
		}
	});
	
	// 지정연기/자유연기 여부에 따라 대본첨부 input 표시
	$('select[name="scriptStatus"]').change(function() {
		$('#script').css("display","none");
		
		var optionVal = $("select[name='scriptStatus'] > option:selected").val();
		
		if(optionVal == "1"){
			$('#script').css("display","block");
		}

	});
	
	//pdf파일 첨부시 #script에 파일이름을 표시해준다.
	const scriptInput = $('#actingRole-script-input');
	const script = $('#script');
	
	scriptInput.change(function(){
		const files = scriptInput[0].files;
		const file = scriptInput[0].files[0];
		
		if(files.length != 0){
			
			let fileName = file.name;
			script.html("파일이름 : " + fileName);
			script.css("display","block");
			
		}else {
			//파일이 없는 경우 내용을 지워준다.
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
					
					$("#guide-video").html("파일이름 : " + fileName + "<br>" + "총 재생시간 : "
							+ (oneMinute > 0 ? oneMinute + "분 " : "") + 
					(duration - oneMinute * 60) + "초");
				}
				
			});

		} else {
			//파일이 없는 경우 내용을 지워준다.
			videoForDisplay.css("display","none");
			$("#guide-video").html("가이드 영상을 올려주세요.");
			videoForDisplay.attr("src", "");
			URL.revokeObjectURL(file);
		}
	});
	
	$('#actingRole-file').on('change', function() {

		const files = $("#actingRole-file")[0].files;
		const file = $("#actingRole-file")[0].files[0];

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

			actingRoles = actingRole.split('_');
			actingRoleGenders = actingRoleGender.split('_');
			actingRoleAges = actingRoleAge.split('_');

			var html = '';

			html += '<option value="">선택하세요</option>';
			for (var i = 0; i < actingRoles.length; i++) {
				html += '<option value="'+ actingRoles[i] + '" value2="'+ actingRoleGenders[i] + '" value3="'+ actingRoleAges[i] + '">'
						+ actingRoles[i]
						+ '/'
						+ actingRoleGenders[i]
						+ '/'
						+ actingRoleAges[i] + '</option>';
			}

			$('select[name="actingRole"]').removeAttr(
					"disabled");
			$('select[name="actingRole"]').append(html);

		} else {
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
			nameVal = $('input[name="name"]').val();
			console.log("nameVal : " + nameVal);
			
			$('input[name="gender"]').val(option.attr("value2")); //지정 value2 값
			genderVal = $('input[name="gender"]').val();
			console.log("genderVal : " + genderVal);
			
			$('input[name="age"]').val(option.attr("value3"));
			ageVal = $('input[name="age"]').val();
			console.log("ageVal : " + ageVal);
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
		
		$("input[name=region]").val(option.val());
	});
	
	$("select[name=gugun]").change(function() {
		
		var sidoOption = $("select[name='sido'] > option:selected");
		var gugunOption = $("select[name='gugun'] > option:selected");
		
		$("input[name=region]").val(sidoOption.val() + " " + gugunOption.val());
	});
	
</script>
<%@ include file="../part/foot.jspf"%>