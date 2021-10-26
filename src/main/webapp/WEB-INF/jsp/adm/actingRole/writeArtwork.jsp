<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../../usr/part/head.jsp"%>


<script>
	//작성한 배역(actingRole)상세정보들을 담아 놓기위한 전역Map을 생성
	var actingRoles = new Map();
	
	//작성한 배역들에 데이터가 담겨있는지 검사하는 함수
	var checkAllActingRolesRd = function() {
		
		//데이터 유무 검사중 문제가 있을시 멈추기위한 boolean값 
		var needToStop = false;
		
		//---------------------------------------------------------------
		//캐스팅공고(artwork)의 form안에 작성되어있는 input[name^=role]에 데이터가 담겨있는지 loop통한 검사
		
		$('#artwork-form input[name^=role]').each(function(index,item){
			
			//item의 data-id 속성에 저장해놓은 식별자를 가져옴 
			var id = $(item).data("id");
			
			//작성한 배역상세정보들을 담아놓은 actingRoles에 식별자를 통해서 null을 체크한다.
			if(actingRoles.get(id) == null){
				
				//focus로 해당 input으로 이동할 경우 헤더때문에 input이 가려지는
				//문제로 인해서 tartgetOffset을 통해서 스크롤을 위로 올려준다음 focus줌.
				var targetOffset = $('input[name="role'+ id + '"]' ).offset();
				window.scrollTo({top : targetOffset.top - 300, behavior:'auto'});
				
				item.focus();

				var msg = "";
				
				//input[name=role]에 배역이름을 넣고 배역상세정보를 입력안한경우 
				if($.trim($(item).val()) != null && $.trim($(item).val()) != '' ){
					msg = $(item).val() + "의 배역정보를 입력해주세요.";
				}else{
					//배역이름조차 없는경우 식별자를 통해서 보여준다.
					msg = id + "번째 배역정보를 입력해주세요.";
				}
				
				//setPositionOfToastr를 통해서 알림을 띄어준다.
				var targetName = "role"+ $(item).data("id");
				var targetType = "input";
				var toastr = setPositionOfToastr(targetType,targetName,msg);
				
				needToStop = true;
				
				//$.each문의 break 역할을함
				return false;
				
			}else{
				//식별자에 해당하는 배역상세정보가 있는 경우 배역이름을 넣어준다.
				actingRoles.get(id).role = $.trim($(item).val());
			}
		});
		//---------------------------------------------------------------
		
		//checkAllActingRolesRd의 데이터유무 검사를 멈춘다.
		if(needToStop == true){
			return needToStop;
		}
		
		//---------------------------------------------------------------
		//actingRoles가 있는경우 for..of를 통해서 모든값이 잘들어가있는지 검사한다.
		//actingRole에 비어있는 값이있는 경우 key값을 통해서 showActingRoleModal을 실행시키게되면 
		//모달창의 input값에 값을채워 모달창을 띄어준다
		//이후 checkAndSaveCurrentActingRoleInfo를 통해서 toastr알림창을 띄어준다.
		for( let [key,actingRole] of actingRoles){
			 
			if(actingRole.gender == null || actingRole.gender == ''){
			
				showActingRoleModal(key);
				checkAndSaveCurrentActingRoleInfo();
				needToStop = true;
				break;
			}
			
			if(actingRole.age == null || actingRole.age == ''){
				
				showActingRoleModal(key);
				checkAndSaveCurrentActingRoleInfo();
				needToStop = true;
				break;
			}
			
			if(actingRole.job == null || actingRole.job == ''){
				
				showActingRoleModal(key);
				checkAndSaveCurrentActingRoleInfo();
				needToStop = true;
				break;
			}
			
			if(actingRole.feature == null || actingRole.feature == ''){
				
				showActingRoleModal(key);
				checkAndSaveCurrentActingRoleInfo();
				needToStop = true;
				break;
			}
			
			if(actingRole.schedule == null || actingRole.schedule == ''){
				
				showActingRoleModal(key);
				checkAndSaveCurrentActingRoleInfo();
				needToStop = true;
				break;
			}
			
			if(actingRole.shootingsCount == null || actingRole.shootingsCount == ''){
				
				showActingRoleModal(key);
				checkAndSaveCurrentActingRoleInfo();
				needToStop = true;
				break;
			}
			
			if(actingRole.region == null || actingRole.region == ''){
				
				showActingRoleModal(key);
				checkAndSaveCurrentActingRoleInfo();
				needToStop = true;
				break;
			}
			
			if(actingRole.startDate == null || actingRole.startDate == ''){
				
				showActingRoleModal(key);
				checkAndSaveCurrentActingRoleInfo();
				needToStop = true;
				break;
			}
			
			if(actingRole.endDate == null || actingRole.endDate == ''){
				
				showActingRoleModal(key);
				checkAndSaveCurrentActingRoleInfo();
				needToStop = true;
				break;
			}
			
			if(actingRole.pay == null || actingRole.pay == ''){
				
				showActingRoleModal(key);
				checkAndSaveCurrentActingRoleInfo();
				needToStop = true;
				break;
			}
			
			if(actingRole.shotAngle == null || actingRole.shotAngle == ''){
				
				showActingRoleModal(key);
				checkAndSaveCurrentActingRoleInfo();
				needToStop = true;
				break;
			}
			
			if(actingRole.requestedActing == null || actingRole.requestedActing == ''){
				
				showActingRoleModal(key);
				checkAndSaveCurrentActingRoleInfo();
				needToStop = true;
				break;
				
			//만약 오디션지원방식이 지정연기(requestedActing == 1)일 경우 대본을 첨부여부를 확인한다.
			}else if(actingRole.requestedActing == 1 ){
					
				if(actingRole.scriptStatus == 0 ){
					
					showActingRoleModal(key);
					checkAndSaveCurrentActingRoleInfo();
					needToStop = true;
					break;
				}
			}
		}
		//---------------------------------------------------------------
		
		if(needToStop == true){
			return needToStop;
		}
		
	}
	
	//artwork의 form 데이터 유효성검사
	async function ArtworkWriteForm__submit(form) {
		
		//toastr이 누를때마다 레이어가 생기는것을 방지
		if ($('.toast')) {
			window.toastr.remove();
		}
		
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}
		
		if (form.title.value.length == 0) {
			
			form.title.focus();
			
			var msg = "제목을 입력해주세요";
			var targetName = "title";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}
		
		form.investor.value = form.investor.value.trim();

		if (form.investor.value.length == 0) {
			form.investor.value = "개별안내";
		}

		form.productionName.value = form.productionName.value.trim();

		if (form.productionName.value.length == 0) {
			form.productionName.focus();

			var msg = "제작사를 입력해주세요.";
			var targetName = "productionName";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}

		if (form.genre.value.length == 0) {
			var targetOffset = $('select[name="genre"]').offset();
			window.scrollTo({top : targetOffset.top - 500, behavior:'auto'});
			
			form.genre.focus();
			
			var msg = "장르를 입력해주세요";
			var targetName = "genre";
			var targetType = "select";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}

		form.directorName.value = form.directorName.value.trim();

		if (form.directorName.value.length == 0) {
			form.directorName.value = "개별안내";
		}

		form.leadActor.value = form.leadActor.value.trim();

		if (form.leadActor.value.length == 0) {
			form.leadActor.value = "개별안내";
		}
		
		if(checkAllActingRolesRd() == true){
			return;
		}

		form.etc.value = form.etc.value.trim();

		if (form.etc.value == 0) {
			form.etc.focus();

			var msg = "줄거리를 입력해주세요.";
			var targetName = "etc";
			var targetType = "textarea";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}

		form.startDate.value = form.startDate.value.trim();

		if (form.startDate.value == 0) {
			form.startDate.focus();

			var msg = "모집시작일을 입력해주세요.";
			var targetName = "startDate";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}

		form.endDate.value = form.endDate.value.trim();

		if (form.endDate.value == 0) {
			form.endDate.focus();

			var msg = "마감일을 입력해주세요.";
			var targetName = "endDate";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}
		
		//캐스팅콜(artwork)의 대표이미지 파일업로드관련해서 검사
		var needToUpload = false;

		if (needToUpload == false
				&& form.file__artwork__0__common__attachment__1) {
			needToUpload = form.file__artwork__0__common__attachment__1
					&& form.file__artwork__0__common__attachment__1.value.length > 0;
		}

		//대표이미지 파일업로드할 필요가없다면 startWriteAndUploadActingRoleProcess를 실행하여 actingRole를 ajax통해 form전송 해준다.
		if (needToUpload == false) {
			
			//-1을 넘겨주는것은 파일업로드를 할 필요가 없다는 의미로 보내줌
			var actingRoleIdsStr = await startWriteAndUploadActingRoleProcess(-1);
			
			//actingRole를 작성한후, 해당하는 pk값을 가져와서
			form.actingRoleIdsStr.value = actingRoleIdsStr;
			
			//artwork의 form submit시 actingRole의 artworkId칼럼에 artwork pk값을 넣어준다.
			form.submit();
			
			
		} else {
			//대표이미지 파일업로드해야한다면 startUploadFiles를 통해서 파일업로드를 해준다.
			var fileIdsStr = await startUploadFiles(form);
			
			//파일업로드 한후 pk값을 fileIdsStr에 받아서 startWriteAndUploadActingRoleProcess에 인자로 넘겨준다.
			var actingRoleIdsStr = await startWriteAndUploadActingRoleProcess(fileIdsStr);
			
			// startWriteAndUploadActingRoleProcess 통해 작성된 actingRole의 pk값을 artwork의 form submit시 같이 보내준다.
			form.actingRoleIdsStr.value = actingRoleIdsStr;
			
			form.submit();
		}
	
	}
	
	//artwork의 파일업로드를 해준다.
	async function startUploadFiles(form) {
		
		var fileUploadFormData = new FormData(form);
		
		//파일업로드가 이루어지지 않았을경우를 startWriteAndUploadActingRoleProcess에 인자로넘겨줌
		var fileIdsStr = -1;

		$.ajax({
			url : '../../usr/file/doUploadAjax',
			data : fileUploadFormData,
			//processdata를 false로 두어서 queryString생성을 막는다.
			processData : false,
			//contentType을 false로 두어서 multipart/form-data로 전송되게한다.
			contentType : false,
			//async로 작동시킨다. ※for문으로 업로드실행시 비동기로 설정해놓을경우 오류가 발생하기 때문에 동기적으로 실행시킨다.
			async: false,
			//서버에서 받을 데이터값을 json으로 지정한다.
			dataType : "json",
			type : 'POST',
			success : function(data){
				//artwork file pk값을 저장시킨다.
				if (data && data.body && data.body.fileIdsStr) {
					fileIdsStr = data.body.fileIdsStr;
				}
			}
		});
	
		return fileIdsStr;
	}
	
	//actingRole의 form를 해준다.
	async function startWriteAndUploadActingRoleProcess(fileIdsStr) {
		
		//넘겨받은 artwork의 업로드된 file의 pk값이 -1이 아니라면, form전송시 input에 담아서 같이보내준다.
		if(fileIdsStr != -1){
			$('input[name="fileIdsStr"]').val(fileIdsStr);
		}
		
		var actingRole = null;
		
		var actingRoleIdsStr = -1;
		
		var actingRoleIdsStr = new Array();
		
		for (let [key, value] of actingRoles){
			var actingRole = value;
			
			//actingRole에 지정대본이 있는경우
			if (actingRole.scriptStatus == 1 ) {
				
				//actingRole을 startActingRoleUploadFile함수를 통해 파일업로드를 실행하고, 리턴값인 file pk값들을 actingRoleWithFileIds에 담는다.
				//이때 await를 통해서 함수를 동기적으로 만들어서 리턴값이 나올때까지 다음 코드가 실행되지 못하도록한다.
				var actingRoleWithFileIds = await startActingRoleUploadFile(actingRole);
				actingRoleIds = await startWriteActingRole(actingRoleWithFileIds);
				
				//actingRole이 작성되고 가져온 pk값들을 array에 담는다.
				actingRoleIdsStr.push(actingRoleIds);
			
			}else{
				
				actingRoleIds = await startWriteActingRole(actingRole);
				actingRoleIdsStr.push(actingRoleIds);
			}
		}
		
		//array값을 join을 ","기준으로 string값으로 변환시킨다.
		return actingRoleIdsStr.join(",");
	}
	
	//actingRole의 파일업로드를 해준다.
	async function startActingRoleUploadFile(actingRole) {
		
		//actingRole의 formdata를 담아서 ajax의 data에 담아서보낸다.
		var fileUploadFormData = actingRole.formData;
		
		$.ajax({
			url : '../../usr/file/doUploadAjax',
			data : fileUploadFormData,
			processData : false,
			contentType : false,
			dataType : "json",
			async: false,
			type : 'POST',
			success : function(data){
				if (data && data.body && data.body.fileIdsStr) {
					actingRole["fileIdsStr"] = data.body.fileIdsStr;
					
				}
			}
		});
		
		return actingRole;
	}
	
	//actingRole를 ajax를 통해서 작성해준다.
	async function startWriteActingRole (actingRole){
		var actingRoleObj = actingRole;
		
		var actingRoleIds = ''; 
		
		$.ajax({
			url : '../../adm/actingRole/doWriteAjax',
			data : JSON.stringify(actingRoleObj),
			processData : false,
			async: false,
			contentType: "application/json; charset=UTF-8",
			type : 'POST',
			success : function(data){
				if (data && data.body && data.body.newActingRoleId) {
					actingRoleIds = data.body.newActingRoleId;
				}
			}
		});
		
		return actingRoleIds;
	}
</script>
<div class="con p-4">
	<span class="font-bold text-xl">Casting Call 등록</span>
</div>

<form id="artwork-form" method="POST"
	class="bg-gray-200 p-4 w-full h-full"
	onsubmit="ArtworkWriteForm__submit(this); return false;"
	action="doWriteArtwork">
	<input type="hidden" name="redirectUri"
		value="../../usr/actingRole/detailArtwork?id=#id">
	<input type="hidden" name="fileIdsStr">
	<input type="hidden" name="actingRoleIdsStr">
	<!-- 이전구조에 쓰이던 데이터라 필요없음 -->
	<input type="hidden" name="actingRole" />
	<input type="hidden" name="actingRoleGender" />
	<input type="hidden" name="actingRoleAge" />
	
	<input type="hidden" name="memberId" value="${loginedMemberId}" />

	<div class="con">
		<div class="text-sm font-bold">캐스팅콜 등록에 관한설명</div>
		<div class="text-xs pb-4">캐스팅 콜 등록에 관한 설명 설명 설명 설명 설명 설명 설명 설명
			설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명 설명</div>
		<div class="form-control-box pb-4 flex-grow">
			<input
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
				type="text" placeholder="영화제목" name="title" maxlength="100" />
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
		<div class="form-control-box mb-4 flex-grow relative">
			<select name="genre"
				class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
				<option selected="selected" value="">장르 선택</option>
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

		<div class="flex justify-center">
			<label class="flex-grow">
				<input id="artwork-file" class="text-sm cursor-pointer hidden "
					accept="${appConfig.getAttachemntFileInputAccept('img')}"
					name="file__artwork__0__common__attachment__1" type="file" />
				<div
					class="artwork-file-status mb-4 w-full text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600">
					대표 이미지를 선택해주세요</div>
			</label>
		</div>
		<div id="artwork-box" class="flex justify-center">
			<img id="artwork-profile" class="max-w-xs" src="" alt="" />
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
		<div class="form-control-box w-full">
			<textarea
				class="resize-none shadow appearance-none border rounded-lg w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline h-72"
				name="etc" placeholder="줄거리를 입력해주세요."></textarea>
		</div>
		<div class="text-center">모집일정</div>
		<div class="form-control-box w-full pb-4 flex items-center">
			<input
				class="border rounded-full flex-grow py-2 pl-2 focus:outline-none focus:shadow-outline"
				type="date" name="startDate" />
			<span>~</span>
			<input
				class="border rounded-full flex-grow py-2 pl-2 focus:outline-none focus:shadow-outline"
				type="date" name="endDate" />
		</div>

		<input
			class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
			type="submit" value="작성">
	</div>
</form>

<!-- actingRole 배역정보입력 모달창 -->
<form id="actingRole-form" onsubmit="return false;">
	<div id="actingRole-modal" class="modal-background px-4 z-50">
		<div
			class="modal-content-no-bg w-full rounded-2xl bg-gray-200 p-4 max-height-80vh">
			<div class="grid gap-y-4">
				<div class="actingRole-name flex justify-center font-black text-xl"></div>
				<div class="flex items-center justify-center">
					<input name="role"
						class="clear-all shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
						type="hidden" placeholder="역할" />
					<div>
						<label for="man">남자 </label>
						<input id="man" name="gender" type="radio" value="남자" checked />
					</div>
					<div class="px-2">
						<label for="woman">여자 </label>
						<input id="woman" name="gender" type="radio" value="여자" />
					</div>
				</div>
				<input name="age"
					class="clear-all  shadow appearance-none border rounded-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="text" placeholder="연령" />
				<input name="job"
					class="clear-all  shadow appearance-none border rounded-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="text" placeholder="직업" />

				<div>
					<input name="feature"
						class="clear-all shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
						type="text" placeholder="주요사항(캐릭터 성격)" />
				</div>

				<div class="text-center">
					<span>촬영일정</span>
					<div>
						<label for="month">
							월
							<input id="month" name="scheduleOption" type="radio"
								value="month" checked />
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
				<div class="flex">
					<input
						class="clear-all shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
						type="month" name="schedule" />
				</div>

				<div class="flex">
					<input
						class="clear-all shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
						type="number" placeholder="촬영횟수" name="shootingsCount" />
				</div>
				<div class="flex">
					<input type="hidden" name="region" class="clear-all " />
					<select name="sido" id="sido1"
						class="clear-all text-center shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"></select>
					<select name="gugun" id="gugun1"
						class="clear-all text-center shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"></select>
				</div>

				<div class=" text-center">모집일정</div>
				<div class="w-full flex items-center">
					<span class="pr-2">From</span>
					<input
						class="clear-all border rounded-full flex-grow py-2 pl-2 focus:outline-none focus:shadow-outline"
						type="date" name="actingRole-startDate" />
				</div>
				<div class="w-full flex items-center">
					<span class="pr-2">Until</span>
					<input
						class="clear-all border rounded-full flex-grow py-2 pl-2 focus:outline-none focus:shadow-outline"
						type="date" name="actingRole-endDate" />
				</div>

				<div>
					<input name="pay"
						class="clear-all shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
						type="text" placeholder="출연료(회당,일당,개별협의 등)" />
				</div>
				<div class="w-full">
					<input type="hidden" name="guideVideoUrl" />
					<select name="shotAngle"
						class="clear-all text-center shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
						<option selected="selected" value="">선택해주세요</option>
						<option value="BS">Bust Shot</option>
						<option value="WS">Waist Shot</option>
						<option value="KS">Knee Shot</option>
						<option value="FS">Full Shot</option>
						<option value="CU">Close up(얼굴 위주)</option>
					</select>
				</div>

				<div class="w-full">
					<select name="requestedActing"
						class="clear-all text-center shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
						<option selected="selected" value="">선택해주세요</option>
						<option value="0">자유연기</option>
						<option value="1">지정연기</option>
					</select>
				</div>


				<div id="script-box" class=" flex-col justify-center mb-4 hidden ">
					<input type="text" class="w-0 h-0" name="scriptStatus" value="0" />
					<label class="flex-grow">
						<input type="file" class="clear-all text-sm cursor-pointer hidden"
							id="actingRole-script-input"
							name="file__actingRole__0__script__attachment__1"
							accept="${appConfig.getAttachemntFileInputAccept('document')}" />
						<div id="script"
							class="w-full text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600">
							대본을 업로드 해주세요.</div>
					</label>
				</div>
				<button onclick="javascript:checkAndSaveCurrentActingRoleInfo()"
					type="button"
					class="shadow appearance-none border rounded-full py-2 px-3 bg-green-300 text-white leading-tight focus:outline-none focus:shadow-outline">입력완료</button>
			</div>
		</div>
	</div>
</form>

<script>

	var actingRoleCount = 0;
	//회원모달창 켜졌을경우 외부영역 클릭 시 팝업 닫기
	$('.modal-background')
			.mouseup(
					function(e) {
						if ($('.modal-content-no-bg').has(e.target).length === 0) {
							$('.modal-background').css("display", "none");
							saveCurrentActingRoleInfo();
						}
					});

	function showActingRoleModal(actingRoleId) {
		//alert("showActingRoleModal실행 : "+ actingRoleId);
		
		var input = $('input[name="role' + actingRoleId + '"]');

		if (input.val() !== '' && typeof input !== "undefined") {
			$('.actingRole-name').html(input.val() + " 정보입력");

			$('#actingRole-modal').data("id", actingRoleId);
			$('#actingRole-form input[name="role"]').val(input.val());
			
			if(actingRoles.size > 0 && typeof actingRoles.get(actingRoleId) != "undefined"){
				actingRole = actingRoles.get(actingRoleId);
				
				if(actingRole["scheduleType"] == "month"){
					$('#actingRole-form [name="schedule"]').attr("type","month");
				}else if(actingRole["scheduleType"] == "date"){
					$('#actingRole-form [name="schedule"]').attr("type","date");
				}else{
					$('#actingRole-form [name="schedule"]').attr("type","text");
				}
				
				$.each(actingRole, function(index, value){
					if(index == "region"){
						if(value != null && value != '' ){ 
							var sido = value.split(" ")[0];
							var gugun = value.split(" ")[1];
							
							$('#actingRole-form [name="sido"]').val(sido).prop('selected',true).trigger('change');
							$('#actingRole-form [name="gugun"]').val(gugun).attr('selected','selected');
						}else{
							$('#actingRole-form [name="sido"]').val("시/도 선택");
						}
					}else if(index == "startDate"){
						$('#actingRole-form [name="actingRole-'+ index +'"]').val(value);
					}else if(index == "endDate"){
						$('#actingRole-form [name="actingRole-'+ index +'"]').val(value);
					}else if(index == "scriptStatus"){
						if(value == 0){
							$('#actingRole-form [name="requestedActing"]').val(value);
						}else if(value == 1){
							$('#actingRole-form [id="script-box"]').val();
						}						
					}else if(index == "endDate"){
						$('#actingRole-form [name="actingRole-'+ index +'"]').val(value);
					}else if(index == "requestedActing" && value == 1){
						$('#actingRole-form [name="'+ index +'"]').val(value);
						$('#script-box').css("display", "flex");
					}else if(index == "requestedActing" && value == 0){
						$('div[id=script]').text("대본을 업로드 해주세요.");
						$('#script-box').css("display", "none");
					}else if(index == "script"){
						$('#actingRole-form div[id="'+ index +'"]').html(value);
					}else if(index == "feature"){
						value = value.replaceAll("\*","\"");
						$('#actingRole-form [name="'+ index +'"]').val(value);
					}else if(index == "gender"){
						$('#actingRole-form input:radio[name="gender"]:input[value='+ value +']').prop("checked", true);
					}else{
						$('#actingRole-form [name="'+ index +'"]').val(value);	
					}
				});	
			}else{
				var allContent = $('.clear-all');
				
				for(var i = 0; i < allContent.length; i++){
					
					allContent[i].value = "";
				}
				
				$('input:radio[name="scheduleOption"]:input[value="month"]').prop("checked", true).trigger('change');
				$('input:radio[name="gender"]:input[value="남자"]').prop("checked", true);
				$('#actingRole-form [name="sido"]').val("시/도 선택");
				$('div[id=script]').html("대본을 업로드 해주세요.");
				$('#script-box').css("display", "none");
				
			}
				
			$('#actingRole-modal').css("display", "flex");
				
		} else {
			alert("배역이름 작성 후,상세정보 입력이 가능합니다.");
			input.focus();
		}

	}
	
	function saveCurrentActingRoleInfo(){
		
		var id = $('#actingRole-modal').data("id");
		
		var savedActingRole = actingRoles.get(id);
		
		if(savedActingRole == "undefined" || savedActingRole == null){
			
			var actingRole = new Object();
			
			actingRole["startDate"] = $('input[name="actingRole-startDate"]').val();
			actingRole["endDate"] = $('input[name="actingRole-endDate"]').val();
			actingRole["role"]= $('input[name="role' + id + '"]').val();
			actingRole["pay"] = $('input[name="pay"]').val();
			actingRole["age"] = $('input[name="age"]').val();
			actingRole["gender"] = $('input:radio[name="gender"]:checked').val();
			actingRole["job"] = $('input[name="job"]').val();
			actingRole["feature"] = ($('input[name="feature"]').val()).replaceAll("\"","*");
			actingRole["region"] = $('input[name="region"]').val();
			actingRole["schedule"] = $('input[name="schedule"]').val();
			actingRole["shotAngle"] = $('select[name="shotAngle"]').val();
			
			actingRole["guideVideoUrl"] = $('input[name="guideVideoUrl"]').val();
			actingRole["scriptStatus"] = $('input[name="scriptStatus"]').val();
			actingRole["shootingsCount"] = $('input[name="shootingsCount"]').val();
			actingRole["requestedActing"] = $('select[name="requestedActing"]').val();
			
			var needToUpload = false;
			
			var scriptInput = $('#actingRole-script-input');

			if (scriptInput.val() != ''
					&& scriptInput.val() != null) {
				needToUpload = scriptInput.val().length > 0;
			}

			if (needToUpload != false) {
				var formData = new FormData($('#actingRole-form')[0]);

				actingRole["formData"] = formData;
				
				var scriptInput = $('#actingRole-script-input');
				var script = $('#script');

				const files = scriptInput[0].files;
				const file = scriptInput[0].files[0];

				var fileName = file.name;
				actingRole["script"] = "파일이름 : " + fileName;
				
			}
			
			var requestedActing = $('select[name="requestedActing"]');
			
			if($.trim(requestedActing.val()) == 0 || $.trim(requestedActing.val()) == '' || $.trim(requestedActing.val()) == null){
				
				$('input[name="scriptStatus"]').val("0");
				$('#actingRole-script-input').val("");
				
				delete actingRole["formData"];
				delete actingRole["script"];
			}
			
			var scriptStatus = $('input[name="scriptStatus"]');
			
			if(scriptStatus.val() == 0 ){
				$('#actingRole-script-input').val("");
				
				delete actingRole["formData"];
				delete actingRole["script"];
			}
			
			actingRoles.set(id , actingRole);
			
		}else{
			savedActingRole["startDate"] = $('input[name="actingRole-startDate"]').val();
			savedActingRole["endDate"] = $('input[name="actingRole-endDate"]').val();
			savedActingRole["role"]= $('input[name="role' + id + '"]').val();
			savedActingRole["pay"] = $('input[name="pay"]').val();
			savedActingRole["age"] = $('input[name="age"]').val();
			savedActingRole["gender"] = $('input:radio[name="gender"]:checked').val();
			savedActingRole["job"] = $('input[name="job"]').val();
			savedActingRole["feature"] = ($('input[name="feature"]').val()).replaceAll("\"","*");
			savedActingRole["region"] = $('input[name="region"]').val();
			savedActingRole["schedule"] = $('input[name="schedule"]').val();
			savedActingRole["shotAngle"] = $('select[name="shotAngle"]').val();
			
			savedActingRole["guideVideoUrl"] = $('input[name="guideVideoUrl"]').val();
			savedActingRole["scriptStatus"] = $('input[name="scriptStatus"]').val();
			savedActingRole["shootingsCount"] = $('input[name="shootingsCount"]').val();
			savedActingRole["requestedActing"] = $('select[name="requestedActing"]').val();
			
			if(savedActingRole["formData"] != "" && savedActingRole["formData"] != "undefined"){
				
				var needToUpload = false;
				
				var file__actingRole__0__script__attachment__1 = $('input[name="file__actingRole__0__script__attachment__1"]');

				if (file__actingRole__0__script__attachment__1.val() != ''
						&& file__actingRole__0__script__attachment__1.val() != null) {
					needToUpload = file__actingRole__0__script__attachment__1.val().length > 0;
				}

				if (needToUpload != false) {
					var formData = new FormData($('#actingRole-form')[0]);

					savedActingRole["formData"] = formData;
					
					var scriptInput = $('#actingRole-script-input');
					var script = $('#script');

					const files = scriptInput[0].files;
					const file = scriptInput[0].files[0];

					var fileName = file.name;
					savedActingRole["script"] = "파일이름 : " + fileName;
				}
				
				var requestedActing = $('select[name="requestedActing"]');
				
				if($.trim(requestedActing.val()) == 0 || $.trim(requestedActing.val()) == '' || $.trim(requestedActing.val()) == null){
					
					$('input[name="scriptStatus"]').val("0");
					$('#actingRole-script-input').val("");
					
					delete savedActingRole["formData"];
					delete savedActingRole["script"];
				}
				
				var scriptStatus = $('input[name="scriptStatus"]');
				
				if(scriptStatus.val() == 0 ){
					$('#actingRole-script-input').val("");
					
					delete savedActingRole["formData"];
					delete savedActingRole["script"];
				}
				
				actingRoles.set(id , savedActingRole);
			}
			
		}
		
		console.log(actingRole);
		console.log(actingRoles);
	}

	function checkAndSaveCurrentActingRoleInfo() {
		if ($('.toast')) {
			window.toastr.remove();
		}
		
		var id = $('#actingRole-modal').data("id");
		
		//alert("checkAndSaveCurrentActingRoleInfo실행  "+ id);
		
		var actingRole = new Object();
		
		var gender = $('input:radio[name="gender"]:checked');
		
		if($.trim(gender.val()) == '' || $.trim(gender.val()) == null){
			gender.focus();
			
			var msg = "성별을 입력해주세요";
			var targetName = "gender";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}
		
		var age = $('input[name="age"]');
		
		if($.trim(age.val()) == '' || $.trim(age.val()) == null){
			age.focus();
			
			var msg = "나이를 입력해주세요";
			var targetName = "age";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}
		
		var job = $('input[name="job"]');
		
		if($.trim(job.val()) == '' || $.trim(job.val()) == null){
			job.focus();
			
			var msg = "직업을 입력해주세요";
			var targetName = "job";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}
		
		var feature = $('input[name="feature"]');
		
		if($.trim(feature.val()) == '' || $.trim(feature.val()) == null){
			feature.focus();
			
			var msg = "주요사항(캐릭터성격)을 입력해주세요";
			var targetName = "feature";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}
		
		var schedule = $('input[name="schedule"]');
		
		if($.trim(schedule.val()) == '' || $.trim(schedule.val()) == null){
			schedule.focus();
			
			var msg = "일정을 입력해주세요";
			var targetName = "schedule";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}
		
		var shootingsCount = $('input[name="shootingsCount"]');
		
		if($.trim(shootingsCount.val()) == '' || $.trim(shootingsCount.val()) == null){
			shootingsCount.focus();
			
			var msg = "촬영횟수를 입력해주세요";
			var targetName = "shootingsCount";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}
		
		var region = $('input[name="region"]');
		
		if($.trim(region.val()) == '' || $.trim(region.val()) == null){
			region.focus();
			
			var msg = "촬영지역을 입력해주세요";
			var targetName = "sido";
			var targetType = "select";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}
		
		var startDate = $('input[name="actingRole-startDate"]');
		
		if($.trim(startDate.val()) == '' || $.trim(startDate.val()) == null){
			startDate.focus();
			
			var msg = "모집시작날을 등록해주세요";
			var targetName = "actingRole-startDate";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}
		
		var endDate = $('input[name="actingRole-endDate"]');
		
		if($.trim(endDate.val()) == '' || $.trim(endDate.val()) == null){
			endDate.focus();
			
			var msg = "모집마지막날을 등록해주세요";
			var targetName = "actingRole-endDate";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}
		
		var pay = $('input[name="pay"]');
		
		if($.trim(pay.val()) == '' || $.trim(pay.val()) == null){
			pay.val("개별협의");
		}
		
		var shotAngle = $('select[name="shotAngle"]');
		
		if($.trim(shotAngle.val()) == '' || $.trim(shotAngle.val()) == null){
			shotAngle.focus();
			
			var msg = "촬영방식을 입력해주세요";
			var targetName = "shotAngle";
			var targetType = "select";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
		}
 
		//가이드영상 주소넣어줌
		if ($('select[name="shotAngle"]').val() != 0) {
			if ($('select[name="shotAngle"]').val() == "BS") {
				$('input[name="guideVideoUrl"]').val("v=rtOvBOTyX00");
			} else if ($('select[name="shotAngle"]').val() == "WS") {
				$('input[name="guideVideoUrl"]').val("v=JRfuAukYTKg");
			} else if ($('select[name="shotAngle"]').val() == "KS") {
				$('input[name="guideVideoUrl"]').val("v=uO59tfQ2TbA");
			} else if ($('select[name="shotAngle"]').val() == "FS") {
				$('input[name="guideVideoUrl"]').val("v=kTHNpusq654");
			} else if ($('select[name="shotAngle"]').val() == "CU") {
				$('input[name="guideVideoUrl"]').val("v=PT2_F-1esPk");
			}
		}
		
		var requestedActing = $('select[name="requestedActing"]');
		
		if($.trim(requestedActing.val()) == '' || $.trim(requestedActing.val()) == null){
			requestedActing.focus();
			
			var msg = "연기방식을 입력해주세요";
			var targetName = "requestedActing";
			var targetType = "select";
			var toastr = setPositionOfToastr(targetType,targetName,msg);
			return;
			
		}else if($.trim(requestedActing.val()) == 1 ){
			
			var scriptStatus = $('input[name="scriptStatus"]');
			
			if($.trim(scriptStatus.val()) == 0 ){
				scriptStatus.focus();
				
				var msg = "대본을 업로드해주세요";
				var targetName = "scriptStatus";
				var targetType = "input";
				var toastr = setPositionOfToastr(targetType,targetName,msg);
				return;
				
			}else{
				var needToUpload = false;
				
				var scriptInput = $('#actingRole-script-input');

				if (scriptInput.val() != ''
						&& scriptInput.val() != null) {
					needToUpload = scriptInput.length > 0;
				}

				if (needToUpload != false) {
					var formData = new FormData($('#actingRole-form')[0]);

					actingRole["formData"] = formData;
				}
			}
		}else if($.trim(requestedActing.val()) == 0 ){
			
			$('input[name="scriptStatus"]').val("0");
			$('#actingRole-script-input').val("");
			
			delete actingRole["formData"];
			delete actingRole["script"];
		}
		
		var scriptStatus = $('input[name="scriptStatus"]');
		
		if(scriptStatus.val() == 0 ){
			$('#actingRole-script-input').val("");
			
			delete actingRole["formData"];
			delete actingRole["script"];
		}
		
		actingRole["startDate"] = $('input[name="actingRole-startDate"]').val();
		actingRole["endDate"] = $('input[name="actingRole-endDate"]').val();
		actingRole["role"]= $('input[name="role' + id + '"]').val();
		actingRole["pay"] = $('input[name="pay"]').val();
		actingRole["age"] = $('input[name="age"]').val();
		actingRole["gender"] = $('input:radio[name="gender"]:checked').val();
		actingRole["job"] = $('input[name="job"]').val();
		actingRole["feature"] = ($('input[name="feature"]').val()).replaceAll("\"","*");
		actingRole["region"] = $('input[name="region"]').val();
		actingRole["schedule"] = $('input[name="schedule"]').val();
		actingRole["shotAngle"] = $('select[name="shotAngle"]').val();
		
		actingRole["guideVideoUrl"] = $('input[name="guideVideoUrl"]').val();
		actingRole["scriptStatus"] = $('input[name="scriptStatus"]').val();
		actingRole["shootingsCount"] = $('input[name="shootingsCount"]').val();
		actingRole["requestedActing"] = $('select[name="requestedActing"]').val();
		
		actingRoles.set(id , actingRole);
		
		$('.modal-background').css("display", "none");
		
		console.log(actingRole);
		console.log(actingRoles);
		
	}

	$('#artwork-file').on('change', function() {
		
		var artworkFileStatus = $('.artwork-file-status');

		const files = $("#artwork-file")[0].files;
		const file = $("#artwork-file")[0].files[0];

		if (files.length != 0) {
			const imgurl = URL.createObjectURL(file);
			$('#artwork-profile').attr("src", imgurl);
			$('#artwork-box').css("padding", "0 0 10px");
			
			var fileName = file.name;
			artworkFileStatus.html("파일이름 : " + fileName);

			URL.revokeObjectURL(file);

		} else {
			//파일이 없는 경우 내용을 지워준다.
			$('#artwork-profile').attr("src", "");
			$('#artwork-box').css("padding", "0");
			
			artworkFileStatus.html("대본을 업로드 해주세요.");
		}
	});

	function addActingRoleBox() {

		actingRoleCount = actingRoleCount + 1;

		let html = '';

		html += '<div class="actingRole-input flex flex-grow">';
		html += '<input name="role'+ actingRoleCount +'" data-id="' + actingRoleCount + '" class="w-10 shadow appearance-none border rounded-l-full flex-grow mb-2 py-2 pl-2 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="text" placeholder="역할" />';
		html += '<button type="button" class="bg-gray-500 appearance-none border rounded-r-full mb-2 py-2 pl-2 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" onclick="javascript:showActingRoleModal('
				+ actingRoleCount + ')">배역정보입력</button>';
		html += '<button class="text-2xl self-start" onclick="removeActingRoleBox(this,'+ actingRoleCount +')">';
		html += '<i class="far fa-minus-square"></i>';
		html += '</button>';
		html += '</div>';

		$('#actingRole-input-box').append(html);

	}

	function removeActingRoleBox(val,actingRoleCount) {
		if(actingRoles && actingRoles.has(actingRoleCount)){
			actingRoles.delete(actingRoleCount);
		}
		
		console.log(actingRoles);
		
		if($('div.actingRole-input').length == 1){
			$('#actingRole-box-switch').attr("data-displayStatus", 1);
			$('#actingRole-box-switch').css("display", "flex");

			$('.actingRole-box').css("display", "none");
			$('.actingRole-box').empty();
		}else{
			$(val).closest("div.actingRole-input").remove();
		}
	}

	function removeActingRoleBoxAndShowSwitch(val) {
		if(actingRoles && actingRoles.has(actingRoleCount)){
			actingRoles.clear();
		}
		
		$('#actingRole-box-switch').attr("data-displayStatus", 1);
		$('#actingRole-box-switch').css("display", "flex");

		$('.actingRole-box').css("display", "none");
		$('.actingRole-box').empty();
	}

	function showActingRoleBox() {
		actingRoleCount = actingRoleCount + 1;

		$('#actingRole-box-switch').attr("data-displayStatus", -1);
		$('#actingRole-box-switch').css("display", "none");

		html = '';

		html += '<button type="button" class="self-start text-2xl" onclick="javascript:addActingRoleBox()">';
		html += '<i class="far fa-plus-square"></i>';
		html += '</button>';

		html += '<div id="actingRole-input-box" class="flex-grow pl-2">';
		html += '<div class="actingRole-input flex flex-grow">';
		html += '<input name="role'+ actingRoleCount +'" data-id="' + actingRoleCount + '" class="w-10 shadow appearance-none border rounded-l-full flex-grow mb-2 py-2 pl-2 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="text" placeholder="역할" />';
		html += '<button type="button" class="bg-gray-500 appearance-none border rounded-r-full mb-2 py-2 pl-2 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" onclick="javascript:showActingRoleModal('
				+ actingRoleCount + ')">배역정보입력</button>';
		html += '<button class="text-2xl self-start" onclick="removeActingRoleBox(this,'+ actingRoleCount +')">';
		html += '<i class="far fa-minus-square"></i>';
		html += '</button>';
		html += '</div>';
		html += '</div>';

		$('.actingRole-box').prepend(html);
		$('.actingRole-box').css("display", "flex");
	}

	// 지정연기/자유연기 여부에 따라 대본첨부 input 표시

	$('select[name="requestedActing"]').change(
			function() {
				$('#script-box').css("display", "none");

				var optionVal = $(
						'select[name="requestedActing"] > option:selected')
						.val();

				if (optionVal == "1") {
					$('#script-box').css("display", "flex");
				}else{
					$('input[name="scriptStatus"]').val("0");
					$('#actingRole-script-input').val("");
				}

			});

	//pdf파일 첨부시 #script에 파일이름을 표시해준다.
	var scriptInput = $('#actingRole-script-input');
	var script = $('#script');
	var scriptResult = $('input[name="scriptStatus"]');

	scriptInput.on('change', function() {

		const files = scriptInput[0].files;
		const file = scriptInput[0].files[0];

		if (files.length != 0) {

			var fileName = file.name;
			scriptResult.val('1');
			script.html("파일이름 : " + fileName);

		} else {
			//파일이 없는 경우 내용을 지워준다.
			scriptResult.val('0');
			script.html("대본을 업로드 해주세요.");
		}

	});

	//촬영일정 입력방법 선택에따라 input type 바꿔줌
	$('input[name="scheduleOption"]').change(function() {
		if ($('input[name="scheduleOption"]:checked').val() == "month") {
			$('input[name="schedule"]').attr("type", "month");
		} else if ($('input[name="scheduleOption"]:checked').val() == "date") {
			$('input[name="schedule"]').attr("type", "date");
		} else {
			$('input[name="schedule"]').attr("type", "text");
		}
	});

	$("select[name=sido]").each(
			function() {

				var area0 = [ "시/도 선택", "서울특별시", "인천광역시", "대전광역시", "광주광역시",
						"대구광역시", "울산광역시", "부산광역시", "경기도", "강원도", "충청북도",
						"충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주도" ];

				$selsido = $(this);

				$.each(area0, function() {
					$selsido.append("<option value='"+this+"'>" + this
							+ "</option>");
				});
				
				$selsido.next().append("<option value=''>구/군 선택</option>");
			});

	// 시/도 선택시 구/군 설정

	$("select[name=sido]")
			.change(
					function() {

						area = [
								[ "강남구", "강동구", "강북구", "강서구", "관악구", "광진구",
										"구로구", "금천구", "노원구", "도봉구", "동대문구",
										"동작구", "마포구", "서대문구", "서초구", "성동구",
										"성북구", "송파구", "양천구", "영등포구", "용산구",
										"은평구", "종로구", "중구", "중랑구" ],
								[ "계양구", "남구", "남동구", "동구", "부평구", "서구", "연수구",
										"중구", "강화군", "옹진군" ],
								[ "대덕구", "동구", "서구", "유성구", "중구" ],
								[ "광산구", "남구", "동구", "북구", "서구" ],
								[ "남구", "달서구", "동구", "북구", "서구", "수성구", "중구",
										"달성군" ],
								[ "남구", "동구", "북구", "중구", "울주군" ],
								[ "강서구", "금정구", "남구", "동구", "동래구", "부산진구",
										"북구", "사상구", "사하구", "서구", "수영구", "연제구",
										"영도구", "중구", "해운대구", "기장군" ],
								[ "고양시", "과천시", "광명시", "광주시", "구리시", "군포시",
										"김포시", "남양주시", "동두천시", "부천시", "성남시",
										"수원시", "시흥시", "안산시", "안성시", "안양시",
										"양주시", "오산시", "용인시", "의왕시", "의정부시",
										"이천시", "파주시", "평택시", "포천시", "하남시",
										"화성시", "가평군", "양평군", "여주군", "연천군" ],
								[ "강릉시", "동해시", "삼척시", "속초시", "원주시", "춘천시",
										"태백시", "고성군", "양구군", "양양군", "영월군",
										"인제군", "정선군", "철원군", "평창군", "홍천군",
										"화천군", "횡성군" ],
								[ "제천시", "청주시", "충주시", "괴산군", "단양군", "보은군",
										"영동군", "옥천군", "음성군", "증평군", "진천군",
										"청원군" ],
								[ "계룡시", "공주시", "논산시", "보령시", "서산시", "아산시",
										"천안시", "금산군", "당진군", "부여군", "서천군",
										"연기군", "예산군", "청양군", "태안군", "홍성군" ],
								[ "군산시", "김제시", "남원시", "익산시", "전주시", "정읍시",
										"고창군", "무주군", "부안군", "순창군", "완주군",
										"임실군", "장수군", "진안군" ],
								[ "광양시", "나주시", "목포시", "순천시", "여수시", "강진군",
										"고흥군", "곡성군", "구례군", "담양군", "무안군",
										"보성군", "신안군", "영광군", "영암군", "완도군",
										"장성군", "장흥군", "진도군", "함평군", "해남군",
										"화순군" ],
								[ "경산시", "경주시", "구미시", "김천시", "문경시", "상주시",
										"안동시", "영주시", "영천시", "포항시", "고령군",
										"군위군", "봉화군", "성주군", "영덕군", "영양군",
										"예천군", "울릉군", "울진군", "의성군", "청도군",
										"청송군", "칠곡군" ],
								[ "거제시", "김해시", "마산시", "밀양시", "사천시", "양산시",
										"진주시", "진해시", "창원시", "통영시", "거창군",
										"고성군", "남해군", "산청군", "의령군", "창녕군",
										"하동군", "함안군", "함양군", "합천군" ],
								[ "서귀포시", "제주시", "남제주군", "북제주군" ]

						];

						let index = $("select[name=sido] > option:selected")
								.index(); // 선택지역의 구군 Array
						var $gugun = $(this).next(); // 선택영역 군구 객체
						$("option", $gugun).remove(); // 구군 초기화

						if (index == "0")
							$gugun.append("<option value=''>구/군 선택</option>");
						else {
							$gugun.append("<option value=''>구/군 선택</option>");
							$.each(area[index - 1], function() {
								$gugun.append("<option value='"+this+"'>"
										+ this + "</option>");
							});
						}
					});

	$("select[name=sido]").change(function() {

		var option = $("select[name='sido'] > option:selected");

		$("input[name=region]").val("");

		if (option.val() != "시/도 선택") {
			$("input[name=region]").val(option.val());
		}
	});

	$("select[name=gugun]").change(
			function() {

				var sidoOption = $("select[name='sido'] > option:selected");
				var gugunOption = $("select[name='gugun'] > option:selected");

				$("input[name=region]").val(
						sidoOption.val() + " " + gugunOption.val());
		});
</script>
<%@ include file="../part/foot.jsp"%>