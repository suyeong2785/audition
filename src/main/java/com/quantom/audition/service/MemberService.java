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

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

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

	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append(String.format("<p><a href=\"%s\" target=\"_blank\">%s</a>로 이동</p>", siteMainUri, siteName));

		mailService.send(email, mailTitle, mailBodySb.toString());
	}

	public ResultData checkLoginIdJoinable(String loginId) {
		int count = memberDao.getLoginIdDupCount(loginId);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 로그인 아이디 입니다.", "loginId", loginId);
		}

		return new ResultData("F-1", "이미 사용중인 로그인 아이디 입니다.", "loginId", loginId);
	}

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

		List<Member> members = memberDao.getCastingDirectorsByLoginId(param);

		if (members.isEmpty()) {
			return new ResultData("F-1", "일치하는 캐스팅디렉터가 존재하지 않습니다.");
		}

		List<Share> shares = shareService.getShareByRequesterIdAndRequesteeId(param);

		List<Integer> requesteeIds = new ArrayList<>();

		if (shares.isEmpty() == false) {
			for (Share share : shares) {
				requesteeIds.add(share.getRequesteeId());
			}
		}

		// 이미 요청신청을 보낸 캐스팅디렉터의 경우 members에서 해당 정보를 없애준다.
		// ConcurrentModificationException 에러가 일어나서 구아바의 stream사용
		List<Member> selectedMembers = members.stream().filter(member -> {
			for (int requesteeId : requesteeIds) {
				if (requesteeId == member.getId()) {
					return false;
				}
				return true;
			}
			
			return true;
		}).collect(Collectors.toList());

		return new ResultData("S-1", String.format("%d개의 캐스팅디렉터 정보를 가져왔습니다.", selectedMembers.size()), "members",
				selectedMembers);
	}

	public void doModifyMemberRecommendation(int id, int recommendationStatus) {
		memberDao.doModifyMemberRecommendation(id, recommendationStatus);

	}

	public Member getMemberByISNINumber(String ISNI_number) {
		return memberDao.getMemberByISNINumber(ISNI_number);
	}

}
