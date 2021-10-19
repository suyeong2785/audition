package com.quantom.audition.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.xml.UtilNamespaceHandler;
import org.springframework.stereotype.Service;

import com.quantom.audition.dao.MemberDao;
import com.quantom.audition.dto.Career;
import com.quantom.audition.dto.Member;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.dto.Share;
import com.quantom.audition.util.Util;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private MailService mailService;
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;
	@Autowired
	private AttrService attrService;
	@Autowired
	private ShareService shareService;
	@Autowired
	private FileService fileService;
	@Autowired
	private CareerService careerService;

	// 회원번호로 회원 찾기
	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	// 회원가입 로직
	public int join(Map<String, Object> param) {
		memberDao.join(param);

		sendJoinCompleteMail((String) param.get("email"));

		int id = Util.getAsInt(param.get("id"));

		String fileIdsStr = (String) param.get("fileIdsStr");

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim()))
					.collect(Collectors.toList());

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int fileId : fileIds) {
				fileService.changeRelId(fileId, id);
			}
		}

		return id;
	}

	// 가입완료 이메일 송부 로직
	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append(String.format("<p><a href=\"%s\" target=\"_blank\">%s</a>로 이동</p>", siteMainUri, siteName));

		mailService.send(email, mailTitle, mailBodySb.toString());
	}

	// 가입가능한 아이디 여부 확인 로직
	public ResultData checkLoginIdJoinable(String loginId) {
		int count = memberDao.getLoginIdDupCount(loginId);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 로그인 아이디 입니다.", "loginId", loginId);
		}

		return new ResultData("F-1", "이미 사용중인 로그인 아이디 입니다.", "loginId", loginId);
	}

	// 아이디로 회원 조회 로직
	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public String genCheckPasswordAuthCode(int actorId) {
		String authCode = UUID.randomUUID().toString();
		attrService.setValue("member__" + actorId + "__extra__modifyPrivateAuthCode", authCode,
				Util.getDateStrLater(60 * 60));

		return authCode;
	}

	public ResultData checkValidCheckPasswordAuthCode(int actorId, String checkPasswordAuthCode) {
		if (attrService.getValue("member__" + actorId + "__extra__modifyPrivateAuthCode")
				.equals(checkPasswordAuthCode)) {
			return new ResultData("S-1", "유효한 키 입니다.");
		}

		return new ResultData("F-1", "유효하지 않은 키 입니다.");
	}

	public void modify(Map<String, Object> param) {
		memberDao.modify(param);

		if (param.get("loginPw") != null) {
			setNotUsingTempPassword(Util.getAsInt(param.get("id")));
		}

		int relId = Util.getAsInt(param.get("relId"));

		String fileIdsStr = (String) param.get("fileIdsStr");

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim()))
					.collect(Collectors.toList());

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int fileId : fileIds) {
				fileService.changeRelId(fileId, relId);
			}
		}

	}

	public Member getMemberByNameAndEmail(String name, String email) {
		return memberDao.getMemberByNameAndEmail(name, email);
	}

	public ResultData sendTempLoginPwToEmail(Member actor) {
		String title = "[" + siteName + "] 임시 패스워드 발송";
		String tempPassword = Util.getTempPassword(6);
		String body = "<h1>임시 패스워드 : " + tempPassword + "</h1>";
		body += "<a href=\"" + siteMainUri + "/usr/member/login\" target=\"_blank\">로그인 하러가기</a>";

		ResultData sendResultData = mailService.send(actor.getEmail(), title, body);

		if (sendResultData.isFail()) {
			return sendResultData;
		}

		setTempPassword(actor, tempPassword);

		return new ResultData("S-1", "계정의 이메일주소로 임시 패스워드가 발송되었습니다.");
	}

	private void setTempPassword(Member actor, String tempPassword) {
		Map<String, Object> modifyParam = new HashMap<>();
		modifyParam.put("id", actor.getId());
		modifyParam.put("loginPw", Util.sha256(tempPassword));
		modify(modifyParam);

		setUsingTempPassword(actor.getId());
	}

	public boolean usingTempPassword(int id) {
		String value = attrService.getValue("member", id, "extra", "usingTempPassword");

		if (value == null || value.equals("1") == false) {
			return false;
		}

		return true;
	}

	private void setUsingTempPassword(int id) {
		attrService.setValue("member", id, "extra", "usingTempPassword", "1", null);
	}

	private void setNotUsingTempPassword(int id) {
		attrService.remove("member", id, "extra", "usingTempPassword");
	}

	public ResultData getMembersByLoginId(String loginId) {
		List<Member> members = memberDao.getMembersByLoginId(loginId);
		System.out.println("loginId : " + loginId);
		System.out.println("members : " + members);
		if (members.isEmpty()) {
			return new ResultData("F-1", "일치하는 계정이 존재하지 않습니다.");
		}

		return new ResultData("S-1", String.format("%d개의 계정을 가져왔습니다.", members.size()), "members", members);
	}

	public ResultData getCastingDirectorsByLoginId(Map<String, Object> param) {

		List<Member> members = memberDao.getCastingDirectorsNameAndNickAndLoginIdNameByLoginId(param);
		
		if (members.isEmpty()) {
			return new ResultData("F-1", "일치하는 캐스팅디렉터가 존재하지 않습니다.");
		}
		
		return new ResultData("S-1", String.format("%d개의 캐스팅디렉터 정보를 가져왔습니다.", members.size()), "members",
				members);
	}

	public void doModifyMemberRecommendation(int id, int recommendationStatus) {
		memberDao.doModifyMemberRecommendation(id, recommendationStatus);

	}

	public Member getMemberByISNINumber(String ISNI_number) {
		return memberDao.getMemberByISNINumber(ISNI_number);
	}

	/**
	 * 회원가입 정보 유효성 판별
	 *
	 * @param param
	 * @return
	 */
	public ResultData checkJoinData(Map<String, Object> param) {

		if ( param.get("loginId") == null || param.get("loginId").equals("") ) {

			return new ResultData("F-1", "아이디를 다시 입력하여 주시기 바랍니다." );

		} else if ( param.get("loginPw") == null || param.get("loginPw").equals("")) {

			return new ResultData("F-1", "비밀번호를 다시 입력하여 주시기 바랍니다." );

		} else if ( param.get("name") == null || param.get("name").equals("") ) {

			return new ResultData("F-1", "이름을 다시 입력하여 주시기 바랍니다." );

		} else if ( param.get("age") == null || Util.getAsInt(param.get("age")) > 200 ) {

			return new ResultData("F-1", "나이를 다시 입력하여 주시기 바랍니다." );

		} else if ( param.get("gender") == null ) {

			return new ResultData("F-1", "성별을 다시 입력하여 주시기 바랍니다." );

		} else if ( param.get("nickname") == null || param.get("nickname").equals("") ) {

			return new ResultData("F-1", "활동명을 다시 입력하여 주시기 바랍니다." );

		} else if ( param.get("email") == null || param.get("email").equals("") ) {

			return new ResultData("F-1", "이메일을 다시 입력하여 주시기 바랍니다." );

		} else if ( param.get("cellphoneNo") == null || param.get("cellphoneNo").equals("") ) {

			return new ResultData("F-1", "핸드폰 번호를 다시 입력하여 주시기 바랍니다." );

		}

		return new ResultData("S-1", "유효한 정보입니다");

	}
	
	
	/**
	 * 이메일로 회원 찾기
	 * 
	 * @param email
	 * @return
	 */
	public Member getMemberByEmail(String email) {
		return memberDao.getMemberByEmail(email);
	}
	
	/**
	 * 이메일 중복체크 로직
	 *
	 * @param email
	 * @return
	 */
	public ResultData checkEmailDuple(String email) {
		
		Member findMember = getMemberByEmail(email);
		
		if ( findMember != null ) {
			return new ResultData("F-1", "이미 존재하는 이메일 입니다.");
		} else {
			return new ResultData("S-1", "가입하실 수 있는 이메일 입니다.");
		}
		
	}
 }
