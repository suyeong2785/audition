package com.quantom.audition.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quantom.audition.dto.Career;
import com.quantom.audition.dto.ISNIRecord;
import com.quantom.audition.dto.Member;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.service.CareerService;
import com.quantom.audition.service.FileService;
import com.quantom.audition.service.IsniSearchService;
import com.quantom.audition.service.MemberService;
import com.quantom.audition.util.Util;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MemberController {
	
	
	private final MemberService memberService;
	private final FileService fileService;
	private final CareerService careerService;
	private final IsniSearchService isniSearchService;


	/**
	 * 회원정보 찾기 메소드
	 * 
	 * @return
	 */
	@RequestMapping("/usr/member/findLoginInfo")
	public String showFindLoginInfo() {
		return "usr/member/findLoginInfo";
	}

	/**
	 * 회원 아이디 찾기 메소드
	 * 
	 * @param name
	 * @param email
	 * @param model
	 * @return
	 */
	@RequestMapping("/usr/member/doFindLoginId")
	public String doFindLoginId(String name, String email, Model model) {
		
		
		
		Member member = memberService.getMemberByNameAndEmail(name, email);

		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", "해당 회원이 존재하지 않습니다.");
			return "common/redirect";
		} else {
			
			memberService.sendLoginIdEmail(email, member.getLoginId());
			
			model.addAttribute("redirectUri", "/usr/member/login");
			model.addAttribute("msg", "메일이 발송되었습니다.");
			return "common/redirect";
			
		}

	}

	/**
	 * 회원 비밀번호 찾기 메소드
	 * 
	 * @param loginId
	 * @param email
	 * @param redirectUri
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/usr/member/doFindLoginPw")
	public String doFindLoginPw(String loginId, String email, String redirectUri, Model model, HttpServletRequest req) {
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", "해당 회원이 존재하지 않습니다.");
			return "common/redirect";
		}

		if (member.getEmail().equals(email) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", "이메일이 올바르지 않습니다.");
			return "common/redirect";
		}

		ResultData sendTempLoginPwToEmailResultData = memberService.sendTempLoginPwToEmail(member);

		if (sendTempLoginPwToEmailResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", sendTempLoginPwToEmailResultData.getMsg());
			return "common/redirect";
		}

		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("msg", sendTempLoginPwToEmailResultData.getMsg());
		return "common/redirect";
	}

	/**
	 * 회원가입 페이지
	 * 
	 * @return
	 */
	@RequestMapping("/usr/member/join")
	public String showWrite() {
		return "usr/member/join";
	}

	/**
	 * 회원가입 메소드
	 * 
	 * @param param
	 * @param model
	 * @return
	 */
	@RequestMapping("/usr/member/doJoin")
	public String doWrite(@RequestParam Map<String, Object> param, Model model) {
		
		// @ModelAttribute 암호화된 비밀번호 DB에 저장용
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		
		ResultData isAvailableJoinData = memberService.checkJoinData(param);

		if ( isAvailableJoinData.isFail() ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", isAvailableJoinData.getMsg());
			return "common/redirect";
		}

		ResultData checkLoginIdJoinableResultData = memberService
				.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));

		if (checkLoginIdJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", checkLoginIdJoinableResultData.getMsg());
			return "common/redirect";
		}

		int newMemberId = memberService.join(param);

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	/*
	 * 로그인 페이지 이동
	 */
	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "usr/member/login";
	}

	/*
	 * 정보수정 이전 비밀번호 확인 페이지 
	 */
	@RequestMapping("/usr/member/checkPassword")
	public String showCheckPassword() {
		return "usr/member/checkPassword";
	}

	/**
	 * 정보수정 이전 비밀번호 확인 로직
	 * 
	 * @param loginPwReal
	 * @param redirectUri
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/usr/member/doCheckPassword")
	public String doCheckPassword(String loginPwReal, String redirectUri, Model model, HttpServletRequest req) {
		
		String loginPw = loginPwReal;
		Member loginedMember = (Member) req.getAttribute("loginedMember");

		if (loginedMember.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}

		String authCode = memberService.genCheckPasswordAuthCode(loginedMember.getId());

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/usr/home/main";
		}

		redirectUri = Util.getNewUri(redirectUri, "checkPasswordAuthCode", authCode);

		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	/**
	 * 로그인 로직
	 * 
	 * @param loginId
	 * @param loginPwReal
	 * @param redirectUri
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("/usr/member/doLogin")
	public String doLogin(String loginId, String loginPwReal, String redirectUri, Model model, HttpSession session) { 
		
		String loginPw = loginPwReal;
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}
		
		session.setAttribute("loginedMember", member);
		session.setAttribute("loginedMemberId", member.getId());
		session.setAttribute("loginedDate", (String)Util.getNowDateStr());

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/usr/home/main";
		}

		boolean usingTempPassword = memberService.usingTempPassword(member.getId());

		if (usingTempPassword) {
			redirectUri = "/usr/member/checkPassword?redirectUri=%2Fusr%2Fmember%2Fmodify";
			model.addAttribute("msg", "현재 임시 패스워드를 사용하고 있습니다. 비밀번호를 변경해주세요.");
		} else {
			model.addAttribute("msg", String.format("%s님 반갑습니다.", member.getNickname()));
		}
		
		if(redirectUri.contains("doShareArtworksAndActingRoles")) {
			redirectUri += ("&requesteeId=" + member.getId());
			model.addAttribute("msg", String.format("%s님 반갑습니다.지원자 공유제안이 있습니다.", member.getNickname()));
		}
		
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	/*
	 * 로그아웃 로직
	 */
	@RequestMapping("/usr/member/doLogout")
	public String doLogout(HttpSession session, Model model, String redirectUri) {
		session.removeAttribute("loginedMemberId");
		session.removeAttribute("loginedDate");
		session.removeAttribute("fileForProfile");

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/usr/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		return "common/redirect";
	}

	/**
	 * 회원정보 수정 페이지
	 * 
	 * @param session
	 * @param model
	 * @param req
	 * @param checkPasswordAuthCode
	 * @return
	 */
	@RequestMapping("/usr/member/modify")
	public String showModify(HttpSession session, Model model, HttpServletRequest req, String checkPasswordAuthCode) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		
		ResultData checkValidCheckPasswordAuthCodeResultData = memberService
				.checkValidCheckPasswordAuthCode(loginedMemberId, checkPasswordAuthCode);

		if (checkPasswordAuthCode == null || checkPasswordAuthCode.length() == 0) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", "비밀번호 체크 인증코드가 없습니다.");
			return "common/redirect";
		}

		if (checkValidCheckPasswordAuthCodeResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", checkValidCheckPasswordAuthCodeResultData.getMsg());
			return "common/redirect";
		}
		
		Career career = null;
		if(loginedMember.getCareerId() != 0) {
			career = careerService.getCareerByMember(loginedMember.getCareerId());
		}
		
		if(career != null) {
			Map<String,String> joinedCareer = careerService.getDatesAndArtworkOfCareerByMember(loginedMember.getCareerId());
			
			model.addAttribute("joinedCareer", joinedCareer);
		}

		return "usr/member/modify";
	}

	/**
	 * 회원정보 수정 로직
	 * 
	 * @param param
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/usr/member/doModify")
	public String doWrite(@RequestParam Map<String, Object> param, Model model, HttpServletRequest req) {
		Util.changeMapKey(param, "loginPwReal", "loginPw");

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		param.put("id", loginedMemberId);
		param.put("jobId", loginedMember.getJobId());
		
		Util.changeMapKey(param, "careerDates","date");
		Util.changeMapKey(param, "careerArtworks","artwork");
		
		Career career = careerService.getCareerByMember(loginedMember.getCareerId());
	
		if (career == null) {
			careerService.setCareer(param);
		}else {
			param.put("id", career.getId());
			careerService.modifyCareerByMemberIdAndJobId(param);
		}
		
		param.put("id", loginedMemberId);
		memberService.modify(param);
		
		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/getCastingDirectorListAjax")
	@ResponseBody
	public ResultData getCastingDirectorListAjax(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		int loginedMemberId = (int)req.getAttribute("loginedMemberId");
		param.put("requesterId", loginedMemberId);
		
		ResultData membersRd = memberService.getCastingDirectorsByLoginId(param);
		
		return membersRd;
	}
	
	@RequestMapping("/usr/member/getIsniSearchResultAjax")
	@ResponseBody
	public ResultData getIsniSearchResultAjax(String id) {
		ISNIRecord isniRecord = null;
		try {
			isniRecord = isniSearchService.get(id);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		if(isniRecord == null) {
			return new ResultData("F-1", "ISNI에 일치하는 데이터가 없습니다.");
		}
		return new ResultData("S-1", "ISNI에 일치하는 데이터를 찾았습니다.", isniRecord);
	}
	
	@RequestMapping("/usr/member/getMemberByISNINumberAjax")
	@ResponseBody
	public ResultData getMemberByISNINumberAjax(String ISNI_number) {
		Member memberByISNI = memberService.getMemberByISNINumber(ISNI_number);
		if(memberByISNI != null) {
			return new ResultData("F-1", "이미 사용중인 ISNI 번호입니다.");
		}
		
		return new ResultData("S-1", "사용가능한 ISNI 번호입니다.");
	}
	
	
	/**
	 * 이메일 중복체크 AJAX
	 * 
	 * @param email
	 * @return
	 */
	@RequestMapping("/usr/member/emailDupleAjax")
	@ResponseBody
	public ResultData checkEmailDuple(String email) {
		return memberService.checkEmailDuple(email);
	}
	
	/**
	 * 로그인 아이디 중복체크 AJAX
	 * 
	 * @param loginId
	 * @return
	 */
	@RequestMapping("/usr/member/loginIdDupleAjax")
	@ResponseBody
	public ResultData checkLoginIdDuple(String loginId) {
		return memberService.checkLoginIdJoinable(loginId);
	}
	
	/**
	 * 인증코드 생성 및 이메일 발송 로직
	 * 
	 * @param email
	 * @return
	 */
	@RequestMapping("/usr/member/sendCodeAjax")
	@ResponseBody
	public ResultData emailCheck(String email) {
		return memberService.verifyCode(email);
	}
	
	/**
	 * 코드 일치검사
	 * 
	 * @param email
	 * @param code
	 * @return
	 */
	@RequestMapping("/usr/member/verifyCheck")
	@ResponseBody
	public ResultData checkVerifyCode(String email, String code) {
		return memberService.checkCode(email, code);
	}
	
}
