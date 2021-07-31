package com.quantom.audition.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quantom.audition.dto.Career;
import com.quantom.audition.dto.File;
import com.quantom.audition.dto.ISNIRecord;
import com.quantom.audition.dto.Member;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.service.CareerService;
import com.quantom.audition.service.FileService;
import com.quantom.audition.service.IsniSearchService;
import com.quantom.audition.service.MemberService;
import com.quantom.audition.util.Util;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private CareerService careerService;
	
	@Autowired
	private IsniSearchService isniSearchService;

	@RequestMapping("/usr/member/findLoginInfo")
	public String showFindLoginInfo() {
		return "usr/member/findLoginInfo";
	}

	@RequestMapping("/usr/member/doFindLoginId")
	public String doFindLoginId(String name, String email, Model model) {
		Member member = memberService.getMemberByNameAndEmail(name, email);

		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", "해당 회원이 존재하지 않습니다.");
			return "common/redirect";
		}

		model.addAttribute("historyBack", true);
		model.addAttribute("msg", String.format("해당 회원의 로그인 아이디는 %s 입니다.", member.getLoginId()));
		return "common/redirect";
	}

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

	@RequestMapping("/usr/member/join")
	public String showWrite() {
		return "usr/member/join";
	}

	@RequestMapping("/usr/member/doJoin")
	public String doWrite(@RequestParam Map<String, Object> param, Model model) {
		Util.changeMapKey(param, "loginPwReal", "loginPw");

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

	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "usr/member/login";
	}

	@RequestMapping("/usr/member/checkPassword")
	public String showCheckPassword() {
		return "usr/member/checkPassword";
	}

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

		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

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
		
		Career career = careerService.getCareerByMember(loginedMemberId, loginedMember.getJobId());
		if(career != null) {
			Map<String,String> joinedCareer = careerService.getDatesAndArtworkOfCareerByMember(loginedMemberId,loginedMember.getJobId());

			model.addAttribute("joinedCareer", joinedCareer);
		}

		return "usr/member/modify";
	}

	@RequestMapping("/usr/member/doModify")
	public String doWrite(@RequestParam Map<String, Object> param, Model model, HttpServletRequest req) {
		Util.changeMapKey(param, "loginPwReal", "loginPw");

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		param.put("id", loginedMemberId);
		param.put("jobId", loginedMember.getJobId());
		
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
			
		return new ResultData("S-1", "ISNI에 일치하는 데이터를 찾았습니다.", isniRecord);
	}
}
