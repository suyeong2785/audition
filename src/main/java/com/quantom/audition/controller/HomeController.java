package com.quantom.audition.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;

import com.quantom.audition.config.AppConfig;
import com.quantom.audition.dto.ActingRole;
import com.quantom.audition.dto.Applyment;
import com.quantom.audition.dto.Artwork;
import com.quantom.audition.dto.Career;
import com.quantom.audition.dto.Job;
import com.quantom.audition.dto.Member;
import com.quantom.audition.dto.Share;
import com.quantom.audition.service.ActingRoleService;
import com.quantom.audition.service.ApplymentService;
import com.quantom.audition.service.ArtworkService;
import com.quantom.audition.service.CareerService;
import com.quantom.audition.service.RecruitmentService;
import com.quantom.audition.service.ShareService;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@Controller
public class HomeController {
	@Value("${custom.environment}")
	private String environment;
	
	@Autowired
	RecruitmentService recruitmentService;

	@Autowired
	AppConfig appConfig;

	@Autowired
	ApplymentService applymentService;

	@Autowired
	ShareService shareService;

	@Autowired
	CareerService careerService;

	@Autowired
	ActingRoleService actingRoleService;
	
	@Autowired
	ArtworkService artworkService;

	@RequestMapping("/usr/home/main")
	public String showMain(Model model, HttpServletRequest req) {
		// CastingCall(artworks) 가져오기
		List<Artwork> artworks = artworkService.getForPrintArtworks();

		model.addAttribute("artworks", artworks);

		// Auditions(actingRoles) 가져오기
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("typeCode", "thumbnail");
		param.put("memberId", (int) req.getAttribute("loginedMemberId"));

		List<ActingRole> actingRoles = actingRoleService.getActingRolesForPrintList(param);

		model.addAttribute("actingRoles", actingRoles);

		return "usr/home/main";
	}

	@RequestMapping("/")
	public String showIndex(Model model) {

		List<Artwork> artworks = artworkService.getForPrintArtworks();

		model.addAttribute("artworks", artworks);

		return "usr/home/main";
	}
	
	@RequestMapping("/usr/home/showCommonMyPage")
	public String showCommonMyPage(Model model, HttpServletRequest req) {

		return "usr/home/showCommonMyPage";
	}

	@RequestMapping("/adm/home/showMyPage")
	public String showMyPageAdmin(Model model, HttpServletRequest req) {
		Job job = recruitmentService.getJobByCode("actor");
		model.addAttribute("job", job);

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		model.addAttribute("actorCanWrite", appConfig.actorCanWrite("recruitment", loginedMember));

		// 상대 캐스팅디렉터의 지원자공유 요청들을 받아옴
		List<Share> requestedshares = shareService.getForPrintRequestedSharesByRequesteeId(loginedMember.getId());

		model.addAttribute("shares", requestedshares);

		// 수락한 지원자공유요청을 보낸 캐스팅디렉터의 id를 가져옴.
		List<Share> acceptedShares = shareService.getForPrintAcceptedSharesByRequesteeId(loginedMember.getId());

		// applyment들을 List에 담음
		List<Applyment> sharedApplyments = null;

		// requesterid에 일치하는 recruitment에 일치하는 applyments들을 가져와서 마이페이지에 보낸다.
		model.addAttribute("acceptedShares", acceptedShares);

		// 내가 올린 recruitments를 가져옴
		//List<Recruitment> recruitments = recruitmentService.getForPrintRecruitmentsByLoginId(loginedMember.getId());

		// recruitment의 역할을 artwork가 대체
		List<Artwork> artworks = artworkService.getForPrintArtworksByLoginId(loginedMember.getId());
		
		model.addAttribute("artworks", artworks);
		
		model.addAttribute("environment", environment);
		
		return "adm/home/showMyPage";
	}

	@RequestMapping("/usr/home/showMyPage")
	public String showMyPage(Model model, HttpServletRequest req) {
		Job job = recruitmentService.getJobByCode("actor");

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		List<Applyment> applymentResults = applymentService.getApplymenResultInfoByMemberId(loginedMember.getId());
		model.addAttribute("applymentResults", applymentResults);

		Career career = careerService.getCareerByMember(loginedMember.getCareerId());
		if (career != null) {
			Map<String, String> joinedCareer = careerService
					.getDatesAndArtworkOfCareerByMember(loginedMember.getCareerId());

			model.addAttribute("joinedCareer", joinedCareer);
		}

		return "usr/home/showMyPage";
	}
	
	@RequestMapping("/usr/home/showMyAudition")
	public String showMyAudition(Model model, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");

		List<Applyment> applymentResults = applymentService.getApplymenResultInfoByMemberId(loginedMember.getId());
		model.addAttribute("applymentResults", applymentResults);

		Career career = careerService.getCareerByMember(loginedMember.getCareerId());
		if (career != null) {
			Map<String, String> joinedCareer = careerService
					.getDatesAndArtworkOfCareerByMember(loginedMember.getCareerId());

			model.addAttribute("joinedCareer", joinedCareer);
		}

		return "usr/home/showMyAudition";
	}
	
	@RequestMapping("/usr/home/news")
	public String showMyNews(Model model, HttpServletRequest req) {
		
		System.getProperty("");
		
		
		return "usr/home/news";
	}

}
