<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jsp"%>

<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
	function MemberJoinForm__submit(form) {
		if ($('.toast')) {
			window.toastr.remove();
		}

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

			var msg = "로그인 아이디를 입력해주세요.";
			var targetName = "loginId";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		if (form.loginId.value.length < 4) {
			form.loginId.focus();

			var msg = "로그인 아이디 4자 이상 입력해주세요.";
			var targetName = "loginId";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length == 0) {
			var targetOffset = $('input[name="loginPw"]').offset();
			window.scrollTo({
				top : targetOffset.top - 500,
				behavior : 'auto'
			});

			form.loginPw.focus();

			var msg = "로그인 비밀번호를 입력해주세요.";
			var targetName = "loginPw";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		if (form.loginPw.value.length < 5) {
			var targetOffset = $('input[name="loginPw"]').offset();
			window.scrollTo({
				top : targetOffset.top - 500,
				behavior : 'auto'
			});

			form.loginPw.focus();

			var msg = "로그인 비밀번호를 5자 이상 입력해주세요.";
			var targetName = "loginPw";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		if (form.loginPwConfirm.value.length == 0) {
			var targetOffset = $('input[name="loginPwConfirm"]').offset();
			window.scrollTo({
				top : targetOffset.top - 500,
				behavior : 'auto'
			});

			form.loginPwConfirm.focus();

			var msg = "로그인 비밀번호 확인을 입력해주세요.";
			var targetName = "loginPwConfirm";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		if (form.loginPw.value != form.loginPwConfirm.value) {
			var targetOffset = $('input[name="loginPwConfirm"]').offset();
			window.scrollTo({
				top : targetOffset.top - 500,
				behavior : 'auto'
			});

			form.loginPwConfirm.focus();

			var msg = "로그인 비밀번호 확인이 일치하지 않습니다.";
			var targetName = "loginPwConfirm";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			form.name.focus();

			var msg = "이름을 입력해주세요.";
			var targetName = "name";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		form.age.value = form.age.value.trim();

		if (form.age.value.length == 0) {
			form.age.focus();

			var msg = "나이를 입력해주세요.";
			var targetName = "age";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		form.nickname.value = form.nickname.value.trim();

		if (form.nickname.value.length == 0) {
			form.nickname.focus();

			var msg = "활동명을 입력해주세요.";
			var targetName = "nickname";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		//이메일 형식 정규식으로 검사해야함....
		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			form.email.focus();

			var msg = "이메일을 입력해주세요.";
			var targetName = "email";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);
			return;

		} else if (form.email.value.length != 0
				&& $('#email').data("authentication") == "-1") {
			form.email.focus();

			var msg = "'이메일 인증을 완료해주세요.";
			var targetName = "email";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);
			return;
		}

		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		form.cellphoneNo.value = form.cellphoneNo.value.replaceAll('-', '');
		form.cellphoneNo.value = form.cellphoneNo.value.replaceAll(' ', '');

		if (form.cellphoneNo.value.length == 0) {
			form.cellphoneNo.focus();

			var msg = "휴대전화번호를 입력해주세요.";
			var targetName = "cellphoneNo";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		if (form.cellphoneNo.value.length < 10) {
			form.cellphoneNo.focus();

			var msg = "휴대폰번호를 10자 이상 입력해주세요.";
			var targetName = "cellphoneNo";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		if (isCellphoneNo(form.cellphoneNo.value) == false) {
			form.cellphoneNo.focus();

			var msg = "휴대전화번호를 정확히 입력해주세요.";
			var targetName = "cellphoneNo";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}
		
		if ( $('input[name="userAgreement"]').is(":checked") == false ) {
			form.cellphoneNo.focus();

			var msg = "이용약관을 체크해주세요.";
			var targetName = "userAgreement";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}
		
		if ($('input[name="personalClause"]').is(":checked") == false) {
			form.cellphoneNo.focus();

			var msg = "개인정보 수집 및 이용에 대한 동의를 체크해주세요.";
			var targetName = "personalClause";
			var targetType = "input";
			var toastr = setPositionOfToastr(targetType, targetName, msg);

			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);

		var startUploadFiles = function(onSuccess) {
			var needToUpload = false;

			if (needToUpload == false
					&& form.file__member__0__common__attachment__1) {
				needToUpload = form.file__member__0__common__attachment__1
						&& form.file__member__0__common__attachment__1.value.length > 0;
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
<div class="m-auto p-4" style="max-width: 400px">
	<span class="font-bold text-xl">회원가입</span>
</div>
<form method="POST" class="bg-gray-200 p-4 w-full h-full"
	action="doJoin"
	onsubmit="javascript:MemberJoinForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/">
	<input type="hidden" name="loginPwReal">
	<input type="hidden" name="fileIdsStr">
	<div class="m-auto" style="max-width: 400px">
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input id="loginId"
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="text" placeholder="로그인 아이디" name="loginId" maxlength="30" />
				<div id="loginId-duple-result"></div>
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="password" placeholder="로그인 비밀번호" name="loginPw"
					maxlength="30" />
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="password" placeholder="로그인 비밀번호확인" name="loginPwConfirm"
					maxlength="30" />
			</div>
		</div>

		<div class="flex justify-center">
			<label class="flex-grow">
				<input id="join-file" type="file"
					class="text-sm cursor-pointer hidden "
					accept="${appConfig.getAttachemntFileInputAccept('img')}"
					name="file__member__0__common__attachment__1" />
				<div
					class="member-file-status mb-4 w-full text-center text bg-gray-500 text-white border border-gray-300 rounded-full font-semibold cursor-pointer p-1 px-3 hover:bg-gray-600">
					프로필 사진을 선택해주세요</div>
			</label>
		</div>
		<div id="join-profile-box" class="flex justify-center">
			<img id="join-profile" class="max-w-xs" src="" alt="" />
		</div>


		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="text" placeholder="이름" name="name" maxlength="20" />
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="number" placeholder="나이" name="age" maxlength="20" />
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<label>
					<input type="radio" name="gender" value="woman" checked>
					여성
				</label>
				<label>
					<input type="radio" name="gender" value="man">
					남성
				</label>
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="text" placeholder="활동명" name="nickname" maxlength="20" />
			</div>
		</div>
		<div>
			<div class="form-control-box mb-4 flex-grow relative">
				<select name="authority"
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
					<option value="1">캐스팅디렉터</option>
					<option value="2">배우</option>
				</select>
				<div
					class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
					<i class="fas fa-chevron-down"></i>
				</div>
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex flex-col flex-grow">
				<div class="flex flex-grow rounded-full shadow appearance-none">
					<input id="email" data-authentication="-1"
						class="leading-tight appearance-none rounded-full flex-grow py-2 pl-2 text-gray-700 border-t border-l border-b focus:outline-none focus:shadow-outline"
						type="email" placeholder="이메일" name="email" maxlength="50" />
					<button type="button" id="email-button"
						class="hidden bg-gray-500 appearance-none rounded-r-full px-4 text-white hover:bg-gray-700 border-t border-r border border-b border-gray-500"
						onclick="sendEmailAuthenticationVal()">인증번호발송</button>
				</div>
				<div id="email-duple-result"></div>
				<div id="email-verify-box" class="hidden flex-grow pt-4">
					<div class="flex flex-grow relative">
						<input type="text" id="email-verify"
							class="shadow appearance-none border rounded-l-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" />
						<div id="authentication-timer"
							class="absolute top-2/4 right-0 transform -translate-x-1/2 -translate-y-1/2 text-opacity-60 text-gray-600"></div>
					</div>
					<button type="button" id="email-verify-button"
						class="whitespace-nowrap bg-gray-500 appearance-none rounded-r-full px-4 text-white hover:bg-gray-700 border-t border-r border border-b border-gray-500"
						onclick="verifyAuthenticationCode()">인증확인</button>

				</div>
			</div>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow">
				<input
					class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					type="tel" placeholder="휴대전화번호" name="cellphoneNo" maxlength="12" />
			</div>
		</div>
		<!-- 오디션트리 이용약관 -->
		<div class="flex justify-between">
			<div>
				<input type="checkbox" name="userAgreement"/>
				<span>Audictiontree 이용약관</span>
			</div>
			<button type="button" class="bg-green-500 hover:bg-green-700 text-white font-bold rounded-full px-4 " onclick="showUserAgreement()">자세히보기</button>
		</div>

		<div id="userAgreement" class="bg-white hidden" style="height: 100px; overflow-y: scroll;">
			<h3>개인 회원 약관 (개정 및 적용 2020. 06. 10)</h3>
			<h2>제1장 총칙</h2>
			<h3>제1조 (목적)</h3>
			<p>본 약관은 ㈜퀀텀디앤씨(이하 "회사"라 합니다)가 운영하는 웹사이트(이하 “사이트”라 합니다) 및 모바일
				애플리케이션(이하 “애플리케이션”이라 하며, 사이트와 애플리케이션을 총칭하여 “사이트 등”이라 합니다)을 통해 서비스를
				제공함에 있어 회사와 이용자의 이용조건 및 제반 절차, 기타 필요한 사항의 규정을 목적으로 합니다.</p>

			<h3>제2조 (용어의 정의)</h3>
			본 약관에서 사용하는 용어의 정의는 아래와 같습니다.
			<p>① “사이트”라 함은 회사가 서비스를 이용자에게 제공하기 위하여 제작, 운영하는 사이트를 말합니다. 현재 회사가
				운영하는 사이트의 접속 주소는 아래와 같습니다. www.audictiontree.com</p>
			<p>② "애플리케이션"이라 함은 회사와 계열사가 이용자에게 서비스를 제공하기 위하여IOS, 안드로이드 등 운영체제와
				관계없이 스마트폰 또는 기타 휴대용 단말기에서 이용할 수 있도록 제작, 운영하는 프로그램을 말합니다. 현재 회사가 운영하는
				애플리케이션의 이름은 아래와 같습니다. 오딕션어리 등</p>
			<p>③ "서비스"라 함은 채용 및 오디션 정보, 이력서 및 기업정보 제공 기타의 서비스를 통하여 구직•채용시장에서
				구직자와 기업의 연결을 돕는 플랫폼 서비스입니다. 구체적으로는 회사가 기업 또는 구직자가 구인, 구직과 교육을 목적으로
				등록하는 각종 자료를 DB화하여 각각의 목적에 맞게 분류 가공, 집계하여 정보를 제공하는 서비스 및 기타 구인 및 구직이
				원활히 이루어지도록 하기 위하여 사이트 등에서 제공하는 모든 서비스를 말합니다. 회사가 제공하는 서비스는 유형에 따라 무료
				또는 유료로 제공됩니다. 서비스의 자세한 내용은 제8조에서 정하는 바에 따릅니다.</p>
			<p>④ "이용자"라 함은 사이트 등에 접속하여 본 약관에 따라 회사가 제공하는 서비스를 이용하는
				회원(제작자(기업)회원 및 아티스트(개인)회원을 포함) 및 비회원을 말합니다.</p>

			<p>⑤ "개인회원"이라 함은 본 서비스를 이용하기 위하여 본 약관에 동의하고 회사와 서비스 이용계약을 체결하여
				개인회원ID를 부여받은 이용자를 말합니다.</p>

			<p>⑥ “비회원”이라 함은 회사와 서비스 이용계약을 체결하지 않은 채 사이트 등을 통하여 회사가 제공하는 서비스를
				이용하는 이용자를 말합니다.</p>
			<p>⑦ "서비스 이용계약"이라 함은 회사가 개인회원을 위해 제공하는 서비스를 계속적으로 이용하기 위하여 회사와
				이용자 사이에 체결되는 계약을 말합니다.</p>
			<p>⑧ "이용자ID" 또는 "개인회원ID"라 함은 개인회원의 식별 및 서비스 이용을 위하여 개인회원이 선정하거나
				회사가 부여하는 문자와 숫자의 조합을 말합니다.</p>
			<p>⑨ "비밀번호"라 함은 회사의 서비스를 이용하려는 사람이 개인회원ID를 부여 받은 자와 동일인임을 확인하고
				개인회원의 권익을 보호하기 위하여 개인회원이 선정하거나 회사가 부여하는 문자와 숫자의 조합을 말합니다.</p>
			<p>⑩ “계정”이라 함은 개인회원의 개인정보, 이력서 등을 등록, 관리할 수 있도록 회사가 개인회원에게 제공하는
				공간을 말합니다.</p>
			<p>
			<h3>제3조 (약관의 명시와 개정)</h3>
			① 회사는 본 약관의 내용과 상호, 영업소 소재지, 사업자등록번호, 연락처 등을 이용자가 알 수 있도록 초기 화면에
			게시하거나 기타의 방법으로 이용자에게 공지합니다. 약관의 내용은 이용자가 사이트 등의 링크를 통한 연결화면을 통하여 볼 수
			있도록 할 수 있습니다.
			</p>
			<p>② 회사는 약관의 규제 등에 관한법률, 전기통신기본법, 전기통신사업법, 정보통신망이용촉진등에관한법률 등 관련법을
				위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.</p>
			<p>③ 회사가 약관을 개정할 경우에는 개정 약관 적용일 최소 7일전(약관의 변경이 개인회원에게 불리하거나 기업회원의
				권리•의무의 중요한 변경의 경우에는 30일전)부터 웹사이트 초기화면 공지사항 또는 이메일을 통해 사전 공지합니다.</p>
			<p>④ 개인회원은 변경된 약관에 대해 거부할 권리가 있으며, 개인회원은 변경된 약관이 공지된 지 15일 이내에 변경
				약관에 대한 거부 의사를 표시할 수 있습니다. 만약, 개인회원이 거부 의사를 표시하지 않고 서비스를 계속 이용하는 경우,
				회사는 개인회원이 변경 약관 적용에 동의하는 것으로 봅니다.</p>
			<p>⑤ 개인회원이 제4항에 따라 변경 약관 적용을 거부할 의사를 표시한 경우, 회사는 개인회원에게 15일의 기간을
				정하여 사전 통지 후 해당 개인회원과의 서비스 이용계약 또는/및 별도로 체결된 계약을 해지할 수 있습니다.</p>
			<p>⑥ 이 약관은 오딕션어리를 통해 온라인으로 공시하고 회원의 동의와 회사의 승낙으로 효력을 발생하며, 합리적인
				사유가 발생할 경우 회사는 관련 법령에 위배되지 않는 범위 안에서 개정할 수 있습니다. 개정된 약관은 정당한 절차에 따라
				오딕션어리를 통해 공지함으로써 효력을 발휘합니다.</p>
			<p>
			<h3>제4조 (약관 외 준칙)</h3>
			① 약관에서 규정하지 않은 사항에 관해서는 약관의 규제 등에 관한 법률, 정보통신망 이용 촉진 및 정보보호 등에 관한 법률,
			개인정보 보호법, 전기통신기본법, 전기통신사업법 등의 관계법령에 따라 규율됩니다.
			</p>
			<p>② 개인회원이 유료 서비스를 구입함에 있어 유료 서비스 이용조건에 관하여 별도로 약정하는 경우, 본 약관에
				우선하여 해당 약정이 적용됩니다. 그 밖에 회사가 운영하는 개별 서비스 이용약관이 별도로 있는 경우 해당 서비스 이용약관이
				본 약관에 우선하여 적용됩니다.</p>
			<p>③ 회원이 회사와 개별 계약을 체결하여 서비스를 이용하는 경우, 개인회원의 서비스 이용과 관련된 권리 의무는
				순차적으로 개별 계약, 개별 서비스 이용약관, 본 약관에서 정한 내용에 따라 규율됩니다.</p>
			<h3>제5조 (개인회원에 대한 고지, 통지 및 공지)</h3>
			<p>회사는 개인회원에게 서비스 정책, 이용약관, 판매약관, 개인정보 처리방침 등 일체의 약관, 서비스 이용 관련
				일정한 사항이나 정보를 알리거나 안내할 목적으로 개인회원에게 각종 고지나 통지를 이행할 수 있으며, 사이트 등의 게시판이나
				화면에 일정한 사항을 게시하여 공지함으로써 각 개인회원에 대한 각종 고지나 통지를 갈음할 수 있습니다. 이와 관련하여
				고지∙통지 수단, 공지 방법, 공지 기간 등의 상세한 내용은 개인정보 처리방침을 확인 바랍니다.</p>

			<h2>제2장 회원 가입</h2>
			<h3>제6조 (서비스 이용계약의 성립)</h3>
			<p>① 서비스 이용계약은 개인회원 서비스를 이용하고자 하는 자(이하 “이용희망자”라 합니다)의 본 약관과 개인정보
				처리방침의 내용에 대한 동의 및 회원 가입 신청에 대하여 회사가 승낙함으로써 성립합니다.</p>
			<p>② 사이트 등을 통한 회원 가입시 이용희망자는 본 약관 및 개인정보 처리방침에 대한 동의 표시 및 회원 가입
				신청을 하여야 하며, 회사는 이용희망자가 본 약관 및 개인정보 처리방침의 내용을 읽고 동의한 것으로 봅니다.</p>
			<p>③ 페이스북 등 외부 서비스와의 연동을 통한 회원 가입시 이용희망자는 본 약관, 개인정보 처리방침 및 서비스
				제공을 위한 회사의 외부 서비스 계정 정보 접근 및 활용에 대한 동의 표시 및 회원 가입 신청을 하여야 하며, 회사는
				이용희망자가 본 약관 및 개인정보 처리방침의 내용을 읽고 동의한 것으로 봅니다.</p>
			<p>④ 이용희망자가 제2항 또는 제3항에 따라 회원 가입 신청을 한 후, 회사가 이용희망자에게 승낙의 의사가 담긴
				이메일 또는 서면 기타 회사가 정한 수단으로 통지함으로써 서비스 이용계약이 성립합니다.</p>

			<p>⑤ 이용자는 본 약관 및 회사의 개인정보 처리방침에서 정한 항목을 제공하여야 합니다.</p>

			<p>⑥ 회사는 본인 확인을 위하여 필요시 이용자에게 본인 인증을 요구할 수 있습니다. 이 경우 이용자는 휴대폰인증
				등 회사가 제공하는 본인인증방식 중 하나를 선택하여 본인 인증절차를 거쳐야 하며, 이용자가 자신의 실명으로 본인 인증절차를
				거치지 않은 경우, 회사에 대하여 일체의 권리를 주장할 수 없습니다.</p>

			<h3>제7조 (개인회원 가입 신청의 승낙과 제한)</h3>
			<p>① 회사는 전조의 규정에 의한 이용희망자에 대하여 다음 각 호의 사유를 모두 충족할 경우 회사가 제공하는 절차에
				따라 개인회원 가입을 승낙합니다. 회사의 업무수행 및 서비스 제공을 위한 설비의 여유•기술상 지장이 없는 경우 본 약관에서
				정하는 승낙 제한 또는 거절, 보류 사유에 해당하지 않는 경우</p>
			<p>② 다음 각 호 중 어느 하나에 해당할 경우, 회사는 이용희망자의 개인회원 가입 신청을 승낙하지 아니하며,
				개인회원이 제2호 또는 제3호에 해당하는 행위를 한 경우, 회사는 이에 대한 민사상 손해배상청구, 관계법령에 따른
				형사처벌이나 행정제재를 위한 법적 절차를 진행할 수 있습니다. 이용희망자가 만 15세 미만인 경우 개인회원 가입 신청
				및/또는 실명인증 시에 실명이 아닌 이름을 이용하였거나 타인의 명의를 도용한 경우 개인회원 가입 신청 시에 개인회원 정보를
				허위로 기재한 경우</p>
			<h2>제3장 서비스의 이용</h2>
			<h3>제8조 (서비스의 내용)</h3>
			<p>① 회사가 제공하는 서비스의 내용은 다음 각 호와 같습니다. 이력서 등록 또는 인재 데이터베이스 등록 서비스
				온라인 오디션지원 서비스 오디션 공고 추천 서비스 구인/구직과 관련된 제반 서비스 이용자간의 교류와 소통(콘텐츠 공유를
				포함)을 위한 플랫폼 제공 서비스. 단 본 호의 서비스에 있어 회사의 역할은 플랫폼 제공으로 한정되고, 교류와 소통(콘텐츠
				공유를 포함)의 주체는 이용자들입니다. 자료 거래에 관련된 서비스 기타 제1호 내지 제8호까지의 서비스와 관련된 제반
				서비스 제1호 내지 제8호의 서비스 외에 회사가 추가로 개인회원에게 제공하는 일체의 구직 관련 서비스</p>
			<p>② 회사는 필요한 경우 서비스의 내용을 추가 또는 변경할 수 있습니다. 다만, 서비스의 내용의 추가 또는
				변경으로 인하여 개인회원의 권리•의무에 중요한 영향을 미치는 경우, 회사는 추가 또는 변경된 서비스 내용을 그 적용일로부터
				30일 전에 공지합니다.</p>
			<h3>제9조 (개인회원 정보, 이력서의 등록 및 제공)</h3>
			<p>① 개인회원의 이력서는 개인회원이 회원가입 또는 이력서 작성 및 수정시 희망한 형태로 등록 및 제공됩니다.</p>

			<p>② 개인회원은 이력서의 인재정보 등록/미등록 지정, 이력서상의 연락처 공개/비공개를 자유롭게 선택할 수
				있습니다.</p>

			<p>③ 개인회원이 이력서의 인재정보 등록 및 제공을 희망하였을 경우, 회사는 개인회원이 다음 각 호의 사항에 대하여
				동의한 것으로 보며, 기업회원에게 유료 또는 무료로 이력서 열람 서비스 및/또는 이력서 추천 서비스를 제공할 수 있습니다.
				이력서 열람 및/또는 이력서 추천 등에 관한 세부 내용은 개인정보 처리방침 이력서 노출청책을 확인 바랍니다. 기업회원의
				개인회원 이력서 열람 회사가 개인회원 이력서를 기업회원에게 추천</p>
			<p>④ 다음 각 호의 하나에 해당할 경우, 회사는 개인회원이 등록한 이력서의 제공을 중지합니다. 개인회원의 계정이
				본 약관 제21조에 의하여 휴면계정으로 되었을 경우 개인회원이 서비스 이용계약 해지 등으로 회원 자격을 상실한 때</p>
			<p>⑤ 안정적인 서비스 제공을 위한 테스트 및 모니터링, 고객문의 응대 등의 용도로 개인회원의 이력서 정보가 열람될
				수 있습니다.</p>
			<p>⑥ 개인회원의 등록 정보 또는 사이트 등에서의 조회 활동 등을 기준으로 당해 개인회원에게 적합한 채용공고가
				추천될 수 있습니다.</p>
			<p>⑦ 개인회원의 업무능력 등에 관한 정보(이하 “업무관련정보”)는 개인회원의 동의 하에 수집되어 이를 필요로 하는
				기업회원에게 열람될 수 있습니다. 회사는 업무관련정보 이용, 수집 등에 대하여 관여하지 않으며, 업무관련정보의 정확성,
				진실성 등에 대하여 보증하지 않습니다.</p>
			<h3>제10조(제휴를 통한 서비스)</h3>
			<p>① 개인회원의 이력서 항목 중 인재정보에 등록되고, 개인회원에 의해 공개 설정된 항목은 별도의 동의절차를 거쳐
				회사의 제휴매체(웹 사이트, 신문, 잡지 등의 온•오프라인 매체)에게 열람될 수 있습니다.</p>
			<p>② 제1항의 서비스 제공을 위한 개인회원에 대한 사전 고지 및 동의절차, 제휴매체 목록의 공지 등에 대한
				세부내용은 개인정보 처리방침의 이력서 노출정책을 확인 바랍니다.</p>

			<h3>제11조 (서비스의 요금)</h3>
			<p>① 개인회원 가입과 이력서 등록은 원칙적으로 무료입니다. 다만 기업회원 또는 사이트에 방문한 기업체에게 자신의
				이력서 정보를 보다 효과적으로 노출시키기 위하여 회사가 제공하는 별도의 서비스는 유료로 제공될 수 있습니다.</p>
			<p>② 채용공고 및 기업정보 열람은 원칙적으로 무료이나, 일부 정보 또는 서비스는 이용자에게 유료로 제공될 수
				있습니다.</p>
			<p>③ 회사는 유료서비스의 이용요금을 사이트 등에 게시하여 공지합니다.</p>
			<p>④ 회사는 유료서비스 이용금액을 변경할 수 있으며, 이용요금 변경시 변경된 이용요금 내용 및 변경 내용 적용일을
				명시하여 변경 내용 적용일 7일전 또는 관련 법률에서 정한 기한 전까지 개인회원에게 사전 공지합니다.</p>
			<p>⑤ 제3항에 따라 공지된 이용요금 변경 내용은 변경 내용 적용일부터 모든 개인회원에게 적용됩니다. 다만,
				이용요금 변경 내용 적용일 이전에 체결된 계약금액에 영향을 미치지 아니합니다.</p>

			<h3>제12조 (이용요금의 과오납, 과소 청구와 정산)</h3>
			<p>개인회원이 지급한 이용요금의 과오납 등 사유가 있는 경우, 회사는 다음 각 호에 해당하는 조치를 취합니다. 과다
				납입한 이용요금에 대해서는 과다 납입된 금액을 환급하며, 개인회원이 동의할 경우 다음 달에 청구될 이용요금에서 해당
				금액만큼을 차감하여 청구합니다. 이용요금을 환급 받아야 할 개인회원이 체납한 이용요금이 있을 경우, 환급해야 할
				이용요금에서 체납된 이용요금을 우선 공제하고 남은 금액을 반환합니다. 이용요금을 과소 청구한 경우, 회사는 개인회원에게
				과소 청구된 금액을 합산하여 다음달 이용요금과 함께 청구하며, 다음달 청구할 이용요금이 없을 경우 이용요금이 과소
				청구되었음을 확인한 즉시 청구합니다.</p>
			<h3>제13조 (이용요금의 환불)</h3>
			<p>① 회사는 다음 각 호에 경우에는 이용요금을 환불합니다. 다만, 제2호 및 제3호의 하나에 해당하면서 유료
				상품이나 유료 서비스의 이용이 정상적으로 가능하였던 일부 기간이 있을 경우, 해당 기간에 상응하는 이용금액을 공제한 나머지
				금액을 환불합니다. 유료 상품이나 유료 서비스의 이용이 개시되지 않은 경우 회사의 네트워크 또는 시스템 장애로 서비스
				이용이 불가능한 경우 회사의 귀책사유로 인하여 유료 서비스의 이용이 어려운 경우 기타 판매약관으로 정하는 경우</p>
			<p>② 다음 각 호에 해당할 경우, 회사는 개인회원에게 이용요금을 환불하지 않으며, 별도로 개인회원에 대한
				손해배상을 청구할 수 있습니다. 회사가 본 약관 제20조 제3항에 따라 제재조치를 취한 경우 기타 서비스 요금의 환불이
				적절하지 않은 것으로 판매약관에서 정하는 경우</p>
			<p>③ 이용요금을 환불받고자 하는 개인회원은 환불 사유를 명시한 서면으로 회사에 이용요금의 환불을 요청(이하 “환불
				요청”이라 합니다)하여야 합니다.</p>
			<p>④ 회사는 개인회원으로부터 환불 요청을 받은 날로부터 3영업일 이내에 개인회원의 환불 요청이 회사가 정한 환불
				요건을 갖추었는지 여부를 판단하여 개인회원에게 그 내용을 통지합니다.</p>
			<p>⑤ 개인회원의 환불 요청이 환불 요건에 부합하는 것으로 판단될 경우, 회사는 제4항의 통지일로부터 3영업일
				이내에 판매약관에서 정한 금액을 환불합니다.</p>
			<p>⑥ 기타 이용요금의 환불 관련 상세 사항은 판매약관에서 정하는 바에 따릅니다.</p>
			<h3>제14조 (서비스 이용시간 및 제공 중지)</h3>
			<p>① 회사는 특별한 사유가 없는 한 연중무휴, 1일 24시간 서비스를 제공합니다. 다만, 일부 서비스의 경우 그
				종류나 성질을 고려하여 별도로 이용시간을 정할 수 있으며, 회사는 그 이용 시간을 개인회원에게 사전 공지합니다.</p>
			<p>② 회사는 서비스 개선을 위한 시스템 업데이트 기타 유지보수 작업 등을 진행하고자 하는 경우, 사전에 서비스
				중단 시간과 작업 내용을 고지하여 일시적 서비스 중단을 시행할 수 있습니다.</p>
			<p>③ 회사의 성실한 의무 이행에도 불구하고 다음 각 호의 사유로 서비스 중지 등 회원의 손해가 발생한 경우,
				회사는 그로 인한 책임을 부담하지 않습니다. 천재지변 또는 이에 준하는 불가항력으로 인한 손해 회원의 귀책으로 발생한 손해
				제3자의 고의 또는 과실로 발생한 손해 기타 회사의 고의 또는 과실 없이 발생한 손해</p>
			<p>④ 제2항 내지 제3항에 해당하지 않는 사유로 인하여 유료 회원이 입은 손해는 본 약관 및 법령에 따라
				배상합니다.</p>
			<h3>제15조 (서비스 정보의 제공 또는 기타 광고의 게재)</h3>
			<p>① 회사는 개인회원에게 서비스 이용•개선을 위해 필요한 사항을 알리거나 각종 상품•서비스 소개, 홍보 등을 위한
				정보를 우편물, 이메일이나 애플리케이션 푸쉬 알림, 모바일 장치, IoT 등 신종 기술 및 기기를 이용한 방법으로 제공할
				수 있습니다.</p>
			<p>② 회사는 사이트 등에 기타 광고 등을 게재할 수 있으며, 전 항의 방법으로 그 수신을 동의한 개인회원에게 기타
				광고 등을 전달할 수 있습니다.</p>
			<p>③ 회사는 사이트 등에 게재되어 있는 광고주의 홍보활동에 개인회원이 참여하거나 교신 또는 거래를 함으로써
				발생하는 모든 손실과 손해에 대해 일체의 책임을 지지 않습니다.</p>
			<p>④ 개인회원은 서비스 이용 시 사이트 등에 노출되는 광고 게재에 대해 동의하는 것으로 인정됩니다.</p>

			<h3>제16조 (게시물 등 작성에 따른 책임과 회사의 정보 수정•삭제 권한)</h3>
			<p>① 게시물 등은 개인회원이 사이트 등에 등록한 개인정보 및 이력서와 기타 사이트 등에 게시한 일체의 게시물을
				말합니다.</p>
			<p>② 개인회원은 게시물 등을 사실에 기반하여 진실하고 성실하게 작성하여야 하며, 만일 게시물 등의 내용이 사실이
				아니거나 부정확하게 작성되어 발생하는 모든 책임은 전적으로 당해 게시물 등을 등록한 개인회원에게 있습니다. 회사는
				개인회원이 작성한 게시물 등의 정확성 및 진실성을 보증하지 않으며, 게시물에 대한 일체의 책임을 부담하지 않습니다.</p>
			<p>③ 모든 게시물 등의 작성 및 관리는 당해 게시물 등을 작성한 개인회원 본인이 하는 것이 원칙입니다. 개인회원의
				사정상 위탁 또는 대행관리를 하더라도 게시물 등 작성의 책임은 회원에게 있고, 개인회원은 주기적으로 자신의 자료를 확인하여
				항상 정확성을 유지하도록 관리해야 합니다.</p>
			<p>④ 회사는 회원이 작성한 콘텐츠가 다음 각 호에 해당한다고 판단되는 경우, 이를 삭제하거나 게시를 거부할 수
				있습니다. 음란 게시물 청소년에게 유해한 게시물 차별•갈등을 조장하는 게시물 도배 광고 또는 홍보 스팸성 게시물 계정의
				양도나 거래를 내용으로 하는 게시물 타인을 사칭하는 게시물 기타 법령에 위반되거나 그에 준하는 게시물</p>
			<p>⑤ 개인회원이 등록한 게시물 등으로 인해 제3자로부터 허위사실 또는 명예훼손 등을 이유로 삭제 요청이 접수된
				경우 또는 회원이 등록한 게시물 등으로 인하여 사이트 등의 원활한 운영에 영향을 미친다고 판단되는 경우, 회사는 개인회원의
				해당 게시물 등을 직권으로 삭제할 수 있으며, 개인회원에게 해당 게시물 등의 삭제 사실 및 사유를 사후 통지할 수
				있습니다. 제17조 (자료 내용의 활용 및 온라인 입사 지원 정보)</p>
			<p>① 개인회원이 사이트 등에 등록한 이력서 등 정보는 개인을 식별할 수 없는 형태로 제공되어 다음 각 호의 자료로
				활용될 수 있으며, 제2호에 해당하는 경우 해당 자료는 매체를 통해 언론에 배포될 수 있습니다. 다만, 정보통신망 이용촉진
				및 정보보호 등에 관한 법률, 개인정보 보호법 등 관련 법령에 따른 개인정보는 채용 관련 정보 제공 및 활용대상에서
				제외됩니다. 회사의 서비스 개선을 위한 통계자료 취업 및 관련 동향의 통계자료</p>
			<p>② 온라인 입사 지원 및 기타 서비스 이용 과정에서 정당한 절차를 통하여 기업회원에게 제공된 개인회원의 이력서
				등 정보는 해당 기업의 인사자료이며, 이에 대한 관리 의무는 해당 기업의 정책에 따릅니다.</p>
			<h3>제18조 (회사의 의무)</h3>
			<p>① 회사는 본 약관에서 정한 내용에 따라 안정적∙계속적으로 서비스를 제공할 수 있도록 최선을 다하여 노력합니다.
			</p>
			<p>② 서비스의 이용이나 운영과 관련된 개인회원의 불만사항이 접수되는 경우, 회사는 이를 지체없이 처리하여 그
				결과를 회신할 수 있도록 노력합니다. 다만, 불만사항 내용 확인 및 경위 파악, 접수 내용 처리 등에 상당한 시간이 소요될
				경우, 회사는 그 사유와 처리일정을 개인회원에게 통지합니다.</p>
			<p>③ 회사는 유료 결제와 관련한 결제사항 정보를 5년간 보존합니다.</p>
			<p>④ 회사는 천재지변 등 예측하지 못한 일이 발생하거나 시스템의 장애가 발생하여 서비스가 중단될 경우 이에 대한
				손해에 대해서는 책임을 지지 않습니다. 다만 자료의 복구나 정상적인 서비스 지원이 되도록 최선을 다할 의무를 부담합니다.</p>

			<h3>제19조 (개인회원의 의무)</h3>
			<p>① 개인회원은 관계법령과 본 약관의 규정, 회사의 서비스 운영정책 기타 고지된 서비스 이용상의 유의 사항을
				준수하여야 하며, 기타 회사의 업무에 지장을 초래하는 행위를 하여서는 아니됩니다.</p>
			<p>② 개인회원이 신청한 유료서비스는 등록 또는 신청과 동시에 회사와 채권, 채무 관계가 발생하며, 개인회원은
				이용요금을 회사가 지정한 기일 내에 납부하여야 합니다.</p>
			<p>③ 개인회원이 결제 수단으로 신용카드를 사용할 경우 비밀번호 등의 관리책임은 개인회원에게 있습니다. 단,
				사이트의 결함에 따른 정보유실의 발생에 대한 책임은 개인회원이 부담하지 않습니다.</p>
			<p>④ 개인회원은 서비스를 이용하여 얻은 정보를 회사의 사전동의 없이 복사, 복제, 번역, 출판, 방송 기타의
				방법으로 사용하거나 이를 타인에게 제공할 수 없습니다.</p>
			<p>⑤ 개인회원은 본 서비스를 구직 이외의 목적으로 사용할 수 없으며, 다음 각 호의 행위를 하여서는 안 됩니다.
				다른 회원의 아이디를 부정 사용하는 행위 범죄행위를 목적으로 하거나 기타 범죄행위와 관련된 행위 타인의 명예를 훼손하거나
				모욕하는 행위 타인의 지적재산권 등의 권리를 침해하는 행위 해킹행위 또는 바이러스의 유포 행위 타인의 의사에 반하여 광고성
				정보 등 일정한 내용을 계속적으로 전송하는 행위 서비스의 안정적인 운영에 지장을 주거나 줄 우려가 있다고 판단되는 행위
				사이트의 정보 및 서비스를 이용한 영리 행위 그 밖에 선량한 풍속, 기타 사회질서를 해하거나 관계법령에 위반하는 행위</p>

			<h3>제20조 (서비스 이용계약 해지/서비스중지/자료삭제)</h3>
			<p>① 개인회원이 서비스 이용계약을 해지하고자 할 경우, 고객센터 또는 "개인회원 탈퇴" 메뉴를 이용해 회사에 대한
				해지 신청을 합니다. 회사는 즉시 가입해지(회원탈퇴)에 필요한 조치를 취합니다.</p>
			<p>② 개인회원이 서비스 이용계약을 해지한 경우, 회사는 해지 즉시 개인회원의 모든 정보를 파기합니다. 다만, 관련
				법령 및 개인정보 처리방침에 따라 회사가 개인회원 정보를 보유할 수 있는 경우는 보유 목적에 필요한 최소한의 정보를 보관할
				수 있습니다.</p>
			<p>③ 다음의 사항에 해당하는 경우 회사는 개인회원의 사전 동의를 얻지 않고 서비스 이용 제한, 이력서 삭제 조치
				또는 개인회원의 자격박탈 등의 조치(이하 “회사의 제재조치”)를 취할 수 있습니다. 유료서비스 이용 요금을 납부하지 않았을
				때 제7조 제2항의 각 호 중 어느 하나에 해당하는 행위를 하였을 때 본 서비스에서 제공되는 정보를 유용하였을 때 회원이
				등록한 게시물 등의 내용이 사실과 다르거나 조작되었을 때 관련 법규에 위반하거나 선량한 풍속 기타 사회통념상 허용되지 않는
				행위를 하였을 때 기타 본 서비스의 명예를 훼손하였거나 회사가 판단하기에 적합하지 않은 목적으로 회원가입을 하였을 때</p>
			<p>④ 회원은 제3항에 따른 회사의 제재조치에 대하여 이의 사유 및 증빙자료를 제출하는 방식으로 회사에게 이의를
				신청할 수 있습니다. 회원의 이의 신청을 접수한 경우, 회사는 제출된 이의 사유 및 증빙자료 기타 관련 사항을 신중히
				검토하여 이의 신청에 대한 판단을 하고 그 결과를 통지합니다. 이에 대한 상세한 내용은 개인정보 처리방침을 확인 바랍니다.
			</p>
			<p>⑤ 개인회원이 유료서비스를 이용하는 중 회사의 책임에 의해 정상적인 서비스가 제공되지 않을 경우 회원은 본
				서비스의 해지를 요청할 수 있으며 회사는 해지일까지 이용일수를 1일 기준금액으로 계산하여 이용금액을 공제후 환급합니다.</p>
			<h3>제21조 (휴면계정)</h3>
			<p>개인회원이 선택한 개인정보 보유기간 동안 로그인을 하지 않은 경우 해당 개인회원의 계정은 휴면계정이 되어 회원
				로그인을 비롯한 모든 서비스에 대한 이용이 정지되고, 회사는 휴면계정 및 개인정보를 다른 계정과 별도로 관리합니다.</p>
			<h3>제22조 (손해배상 및 면책)</h3>
			<p>① 회사가 본 약관의 제 9조, 제 18조 등의 규정에 위반한 행위로 개인회원에게 손해를 입히거나 기타 회사가
				제공하는 모든 서비스와 관련하여 회사의 책임 있는 사유로 인해 개인회원에게 손해가 발생한 경우, 회사는 그 손해를
				배상하여야 합니다.</p>
			<p>② 개인회원이 본 약관의 제 7조, 제 16조, 제 19조 등의 규정에 위반한 행위로 회사 및 제3자에게 손해를
				입히거나 개인회원의 책임 있는 사유에 의해 회사 및 제3자에게 손해를 입힌 경우에는 개인회원은 그 손해를 배상하여야
				합니다.</p>
			<p>③ 회사는 개인회원의 본 서비스를 통한 구직활동에 대하여 어떠한 책임도 부담하지 않습니다. 또한, 회사는 회사가
				무료로 제공하는 서비스의 이용과 관련하여 개인정보 처리방침에서 정하는 내용에 위반하지 않은 한 이용자에게 어떠한 손해도
				책임지지 않습니다.</p>
			<p>④ 회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우 서비스 제공에 관한
				책임이 면제됩니다.</p>
			<p>⑤ 회사는 서비스 이용과 관련하여 개인회원에게 발생한 손해 가운데 개인회원의 고의 또는 과실로 인한 서비스
				이용의 장애 및 손해에 대하여 어떠한 책임도 부담하지 않습니다.</p>
			<h3>제23조 (회원의 개인정보보호)</h3>
			<p>회사는 이용자의 개인정보를 보호하기 위하여 노력합니다. 회사는 정보통신망 이용 촉진 및 정보 보호 등에 관한
				법률, 개인정보 보호법을 준수하고, 개인정보 보호를 위하여 사이트 등에 개인정보 처리방침을 고지합니다.</p>
			<h3>제24조 (분쟁의 해결)</h3>
			<p>① 회사와 개인회원은 서비스와 관련하여 발생한 분쟁을 원만하게 해결하기 위하여 필요한 모든 노력을 하여야
				합니다.</p>
			<p>② 전항의 노력에도 불구하고, 회사와 개인회원 간에 발생한 분쟁에 관한 소송이 제기될 경우, 민사소송법에 따른
				관할법원을 제1심 관할법원으로 지정합니다.</p>
			<p>부칙 제1조 (시행일) 이 약관은 2021년 4월 26일부터 시행한다. (주)퀀텀디앤씨</p>
		</div>
		<!-- 오디션트리 개인정보동의서 -->
		<div class="flex justify-between">
			<div>
				<input type="checkbox" name="personalClause" />
				<span>개인정보 수집 및 이용에 대한 동의</span>
			</div>
			<div class="bg-green-500 hover:bg-green-700 text-white font-bold rounded-full px-4 " onclick="showPersonalClause()">자세히보기</div>
		</div>
		<div id="personalClause" class="hidden bg-white" style="height: 100px; overflow-y: scroll">
			<h2>1. 개인정보 수집 및 이용 현황</h2>
			<p>(주) 미일 (이하 '회사'는) 고객님의 개인 정보를 중요시하며, "정보 통신망 이용 촉진 및 정 보 보호"에
				관한 법률을 준수하고 있습니다. 회사는 개인 정보 취급 방침을 통하여 고객님 께서 제공하시는 개인 정보가 어떠한 용도와
				방식으로 이용되고 있으며, 개인 정보 보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.</p>
			<p>회사는 개인 정보 취급 방침을 개정하는 경우 웹 사이트 공지 사항 (또는 개별 공지)을 통하여 공지 할
				것입니다.</p>
			<p>본 방침은 : 2021 년 5 월 4 일부터 시행됩니다.</p>

			<h3>■ 수집하는 개인 정보 항목</h3>
			<p>회사는 회원 가입, 상담, 서비스 신청 등등을 위해 아래와 같은 개인 정보를 수집하고 있습니다.</p>
			<p>수집 항목 : 이름, 생년월일, 성별, 로그인 ID, 비밀번호, 자택 주소, 휴대 전화 번호, 이메일, 프로필
				작성시 입력하는 신체 정보 및 연기자 스타일 정보, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보, 결제 기록을
				개인 정보 수집 방법 : 홈페이지 (회원 가입, 아이디 비밀번호 확인, 고객 센터 메일 문의 등), 전화 / 팩스를 통 한
				회원 가입</p>
			<h3>■ 개인 정보의 수집 및 이용 목적</h3>
			<p>회사는 수집 한 개인 정보를 다음의 목적을 위해 활용합니다.</p>
			<h4>회원 관리</h4>
			<p>회원 관리 회원제 서비스 이용에 따른 본인 확인, 개인 식별, 불량 회원의 부정 이용 방지와 비인가 사용 방지,
				가입의사 확인, 연령 확인, 만 14 세 미만 아동 개인 정보 수집시 법정 대리인 동의 여부 확인, 불만 처리 등 민원
				처리, 고지 사항 전달</p>

			<h4>마케팅 및 광고에 활용</h4>
			신규 서비스 (제품) 개발 및 특화, 이벤트 등 광고성 정보 전달, 접속 빈도 파악 또는 회원의 서비스 이용에 대 한 통계

			<h3>■ 개인 정보의 보유 및 이용 기간</h3>
			<p>회사는 개인 정보 수집 및 이용 목적이 달성 된 후에는 예외없이 해당 정보를 지체없이 파기합니다.</p>

			<h3>■ 개인 정보의 파기 절차 및 방법</h3>
			<p>회사는 원칙적으로 개인 정보 수집 및 이용 목적이 달성 된 후에는 해당 정보를 지체없이 파기합니다. 파기 절차
				및 방법은 다음과 같습니다.</p>

			<h4>파기 절차</h4>
			<p>회원님이 회원 가입 등을 위해 입력하신 정보는 목적이 달성 된 후 별도의 DB로 옮겨져 (종이의 경우 별도의
				서류함) 내부 방침 및 기타 관련 법령에 의한 점보 보호 사유에 따라 (보유 및 이용 기간 참조) 일정 기간 저장된 후
				파기되어집니다.</p>
			<p>별도 DB로 옮겨진 개인 정보는 법률에 의한 경우가 아니고서는 보유되어지는 이외의 다른 목적으로 이용 되지
				않습니다.</p>
			<h4>파기 방법</h4>
			<p>전자적 파일 형태로 저장된 개인 정보는 기록을 재생할 수없는 기술적 방법을 사용하여 삭제합니다. 종이에 출력 된
				개인 정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.</p>
			<h3>■ 개인 정보 제공</h3>
			<p>회사는 이용자의 개인 정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로합니다.</p>
			<h4>이용자들이 사전에 동의 한 경우</h4>
			<p>법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사 기관의 요구가있는 경우</p>
			<p>수집 한 개인 정보의 위탁 회사는 고객님의 동의없이 고객님의 정보를 외부 업체에 위탁하지 않습니다. 향후 그러한
				필요가 생길 경우, 위탁 대상자와 위탁 업무 내용에 대해 고객님에게 통지하고 필요한 경우 사전 동의를 받도록하겠습니다.</p>

			<h3>■ 이용자 및 법정 대리인의 권리와 그 행사 방법</h3>
			<p>이용자 및 법정 대리인은 언제든지 등록되어있는 자신 혹은 당해 만 14 세 미만 아동의 개인 정보를 조회하거나
				수정할 수 있으며 가입 해지를 요청할 수도 있습니다.</p>
			<p>이용자 혹은 만 14 세 미만 아동의 개인 정보 조회 / 수정을 위해서는 '개인 정보 변경'(또는 '회원 정보
				수정'등)을 가입 해지 (동의 철회)를 위해서는"회원 탈퇴 "를 클릭하여 본인 확인 절차를 거치 신 후 직접 열람, 정정
				또는 탈퇴가 가능합니다. 혹은 개인 정보 관리 책임자에게 서면, 전화 또는 이메일로 연락하시면 지체없이 조치하겠습니다.</p>
			<p>귀하가 개인 정보와 외 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지 당해 개인 정보를 이용 또는
				제공하지 않습니다. 또한 잘못된 개인 정보를 제 3 자에게 이미 제공 한 경우에는 정정 처리 결과를 제 3 자에 게
				지체없이 통지하여 점점이 이루어 지도록하겠습니다.</p>
			<h3>■ 개인 정보 자동 수집 장치의 설치, 운영 및 그 거부에 관한 사항</h3>
			<p>회사는 귀하의 정보를 수시로 저장하고 찾아내는 '쿠키(COOKIE)'등을 운용합니다. 쿠키란 웹 사이트를
				운영하는데 이용되는 서버가 귀하의 브라우저에 보내는 아주 작은 텍스트 파일로서 귀하의 컴퓨터 하드 디스크에 저장됩니다.
				회사는 다음과 같은 목적을 위해 쿠키를 사용합니다.</p>
			<h4>쿠키 등 사용 목적</h4>
			<p>회원과 비회원의 접속 빈도 나 방문 시간 등을 분석, 이용자의 취향과 관심 분야를 파악 및 자취 추적, 각종이
				벤트 참여 정도 및 방문 회수 파악 등을 통한 타겟 마케팅 및 개인 맞춤 서비스 제공</p>
			<p>귀하는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서, 귀하는 웹 브라우저에서 옵션을 설정함으로써 모든
				쿠키를 허용하거나, 쿠키가 저장 될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부 할 수도 있습니다.</p>
			<h4>쿠키 설정 거부 방법</h4>
			<p>예 : 쿠키 설정을 거부하는 방법으로는 회원님이 사용하시는 웹브라우저의 옵션을 선택 함으로로써 모든 쿠키를
				허용하거나 쿠키를 저장할 때마다 확인을 거치거나, 모든 쿠키의 저장을 거부 할 수 있습니다.</p>
			<p>설정 방법 예(인터넷 익스플로어의 경우) : 웹 브라 무저 상단의 도구 > 인터넷 옵션 > 개인 정보</p>
			<p>단, 귀하 께서 쿠키 설치를 거부 하였을 경우 서비스 제공에 어려움이있을 수 있습니다.</p>
			<p>개인 정보에 관한 민원 서비스 회사는 고객의 개인 정보를 보호하고 개인 정보와 관련한 불만을 처리하기 위하여
				아래와 같이 관련 부서 및 개인 정보 관리 책임자를 지정하고 있습니다.</p>
			<h4>고객 서비스 담당 부서 : 운영팀 이메일 : jnydevelopment@gmail.com</h4>
			<p>귀하께서는 회사의 서비스를 이용 하시며 발생하는 모든 개인 정보 보호 관련 민원을 개인 정보 관리 책임자 혹 온
				담당 부서로 신고하실 수 있습니다. 회사는 이용자들의 신고 사항에 대해 신속하게 중분 한 답변을 드릴 것입니다.</p>
			<p>기타 개인 정보 침해에 대한 신고 나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.</p>
			<p>개인 분쟁 조정위원회 www.kopico.go.kr/main/main.do/ 연락처 : 1833-6972</p>
			<p>정보 보호 마크 인증위원회 www.eprivacy.or.kr/ 연락처 : 02-550-9500</p>
			<p>대 검찰 청 인터넷 범죄 수사 센터 https://spo.go.kr/ 연락처 : 1301</p>
			<p>경찰청 사이버 테러 대응 센터 https://cyberbureau.police.go.kr/ 연락처 : 182</p>
		</div>
		<div>
			<div class="form-control-box pb-4 flex-grow flex">
				<input
					class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
					type="submit" value="가입">
				<button
					class="w-full bg-green-500 hover:bg-green-700 text-white font-bold py-2 rounded-full px-4"
					type="button" onclick="history.back();">취소</button>
			</div>
		</div>
	</div>
</form>

<script>
	//프로필사진 업로드 유무 화면에 표시해줌
	$('#join-file').on('change', function() {

		var memberFileStatus = $('.member-file-status');

		const files = $("#join-file")[0].files;
		const file = $("#join-file")[0].files[0];

		if (files.length != 0) {
			const imgurl = URL.createObjectURL(file);
			$('#join-profile').attr("src", imgurl);
			$('#join-profile-box').css("padding", "0 0 10px");

			//파일의 이름을 '프로필사진을 선택해주세요' 대신에 보여준다.
			var fileName = file.name;
			memberFileStatus.html("파일이름 : " + fileName);

			URL.revokeObjectURL(file);

		} else {
			//파일이 없는 경우 내용을 지워준다.
			$('#join-profile').attr("src", "");
			$('#join-profile-box').css("padding", "0");

			memberFileStatus.html("프로필 사진을 선택해주세요");
		}
	});

	//로그인 아이디 실시간 체크
	$('#loginId').on(
			"propertychange change keyup paste",
			function() {

				let loginId = $('#loginId').val();

				if (loginId.length == 0) {
					$('#loginId-duple-result').empty();
				} else {
					$.ajax({
						url : '../../usr/member/loginIdDupleAjax',
						data : {
							loginId : loginId
						},
						dataType : "json",
						type : 'GET',
						success : function(data) {
							if (data && data.msg) {
								if (data.fail == false) {
									$('#loginId-duple-result').html(
											'<div class="text-green-500 pt-4">'
													+ data.msg + '</span>');
								} else {
									$('#loginId-duple-result').html(
											'<div class="text-red-500 pt-4">'
													+ data.msg + '</span>');
								}
							}
						}
					});
				}

			});

	//이메일 실시간 체크
	$('#email')
			.on(
					"propertychange change keyup paste",
					function() {

						//이메일 체크 정규식
						//(21-10-24) 이메일에 . / - /_ 허용
						var regExp = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i;

						//이메일 인증박스 안보이게함
						$('#email-verify-box').css("display", "none");

						//타이머를 없애줌
						$('#authentication-timer').html("");

						//이메일 인풋에 인증안되어있음으로 변경 
						$("#email").data("authentication", "-1");

						//이메일 값 가져오기
						let email = $('#email').val();

						//타이머 삭제 및 타임 초기화
						clearInterval(timer);
						time = 299

						if (email.length == 0) {
							$('#email-duple-result').empty();
							$('#email').css("border-radius", "9999px");
							$('#email-button').css("display", "none");

						} else if (email.length != 0
								&& regExp.test(email) == false) {

							$('#email-duple-result').empty();
							$('#email').css("border-radius", "9999px");
							$('#email-button').css("display", "none");

						} else if (email.length != 0 && regExp.test(email)) {
							$
									.ajax({
										url : '../../usr/member/emailDupleAjax',
										data : {
											email : email
										},
										dataType : "json",
										type : 'GET',
										success : function(data) {
											if (data && data.msg) {
												if (data.fail == false) {
													$('#email-duple-result')
															.html(
																	'<div class="text-green-500 pt-4">'
																			+ data.msg
																			+ '</span>');
													$('#email')
															.css(
																	{
																		"border-top-right-radius" : "0px",
																		"border-bottom-right-radius" : "0px"
																	});
													$('#email-button').css(
															"display", "block");
												} else {
													$('#email-duple-result')
															.html(
																	'<div class="text-red-500 pt-4">'
																			+ data.msg
																			+ '</span>');
													$('#email').css(
															"border-radius",
															"9999px");
													$('#email-button').css(
															"display", "none");
												}
											}
										}
									});
						}
					});

	//이메일 인증번호 전송함수
	function sendEmailAuthenticationVal() {

		if ($('.toast')) {
			window.toastr.remove();
		}

		let email = $('#email').val();

		if (typeof timer == "undefined") {
			$('#email-duple-result').empty();

			$.ajax({
				url : '../../usr/member/sendCodeAjax',
				data : {
					email : email
				},
				dataType : "json",
				type : 'GET',
				success : function(data) {
					if (data && data.msg) {
						if (data.fail == false) {

							var msg = data.msg;
							var targetName = "email";
							var targetType = "id";
							var toastr = setPositionOfToastr(targetType,
									targetName, msg);

							$('#email-verify-box').css("display", "flex");

							startAuthentiactionTimer();

						} else {
							var msg = data.msg;
							var targetName = "email";
							var targetType = "id";
							var toastr = setPositionOfToastr(targetType,
									targetName, msg);

						}
					}
				}
			});

		} else {
			if (time == 299) {
				$('#email-duple-result').empty();

				$.ajax({
					url : '../../usr/member/sendCodeAjax',
					data : {
						email : email
					},
					dataType : "json",
					type : 'GET',
					success : function(data) {
						if (data && data.msg) {
							if (data.fail == false) {

								var msg = data.msg;
								var targetName = "email";
								var targetType = "id";
								var toastr = setPositionOfToastr(targetType,
										targetName, msg);

								$('#email-verify-box').css("display", "flex");

								time = 299;
								startAuthentiactionTimer();

								html = '';
								html += '<span>인증확인</span>';

								$("#email-verify-button").html(html);

							} else {
								var msg = data.msg;
								var targetName = "email";
								var targetType = "id";
								var toastr = setPositionOfToastr(targetType,
										targetName, msg);

							}
						}
					}
				});

			} else {
				var msg = "인증번호 재발송까지 " + min + "분 " + sec + "초 남았습니다.";
				var targetName = "email";
				var targetType = "id";
				var toastr = setPositionOfToastr(targetType, targetName, msg);
			}
		}

	}

	//타이머(setInterval)를 담을 함수 -> 나중에 clearInterval(timer)를 통해서 타이머를 없앨수있음
	var timer;

	//타이머 시간설정
	var time = 299;
	var min = "";
	var sec = "";

	//인증시간 타이머 함수
	function startAuthentiactionTimer() {
		clearInterval(timer);

		timer = setInterval(function() {

			min = parseInt(time / 60);
			sec = time % 60;

			if (min != 0) {
				$('#authentication-timer').html(
						'<span>' + min + "분 " + sec + "초" + '</span>');
			} else {
				$('#authentication-timer').html(
						'<span>' + sec + "초" + '</span>');
			}

			if (time == 0) {
				clearInterval(timer);
				$('#authentication-timer').html('<span>인증실패</span>');
			} else {
				time--;
			}

		}, 1000);

	}

	//인증번호 일치하는지 확인하는 함수
	function verifyAuthenticationCode() {
		if ($('.toast')) {
			window.toastr.remove();
		}

		let email = $('#email').val();
		let emailAuthenCode = $('#email-verify').val();

		if (emailAuthenCode.length == 0) {
			var msg = "인증번호를 입력해주세요.";
			var targetName = "email-verify";
			var targetType = "id";
			var toastr = setPositionOfToastr(targetType, targetName, msg);
			return;

		} else {

			$.ajax({
				url : '../../usr/member/verifyCheck',
				data : {
					email : email,
					code : emailAuthenCode
				},
				dataType : "json",
				type : 'GET',
				success : function(data) {
					if (data && data.msg) {
						if (data.fail == false) {

							var msg = "인증번호가 일치합니다.";
							var targetName = "email-verify";
							var targetType = "id";
							var toastr = setPositionOfToastr(targetType,
									targetName, msg);

							html = '';
							html += '<span>인증완료</span>';
							html += '<i class="fas fa-check"></i>';

							$("#email-verify-button").html(html);
							$("#email").data("authentication", "1");
							clearInterval(timer);
							$('#authentication-timer').empty();

						} else {

							var msg = "인증번호가 잘못입력되었습니다.";
							var targetName = "email-verify";
							var targetType = "id";
							var toastr = setPositionOfToastr(targetType,
									targetName, msg);

						}
					}
				}
			});
		}

	}
	
	function showPersonalClause(){
		$('#personalClause').toggle();
	}
	
	function showUserAgreement(){
		$('#userAgreement').toggle();
	}
</script>
<%@ include file="../part/foot.jsp"%>