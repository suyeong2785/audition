package com.quantom.audition.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;

import com.quantom.audition.config.AppConfig;
import com.quantom.audition.dto.Applyment;
import com.quantom.audition.dto.Career;
import com.quantom.audition.dto.Job;
import com.quantom.audition.dto.Member;
import com.quantom.audition.dto.Recruitment;
import com.quantom.audition.dto.Share;
import com.quantom.audition.service.ApplymentService;
import com.quantom.audition.service.CareerService;
import com.quantom.audition.service.IsniSearchService;
import com.quantom.audition.service.RecruitmentService;
import com.quantom.audition.service.ShareService;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@Controller
public class HomeController {
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
	

	
	@RequestMapping("/usr/home/main")
	public String showMain() {
	    return "usr/home/main";
	}
	
	@RequestMapping("/")
	public String showIndex() {
		return "usr/home/main";
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
		List<Recruitment> recruitments = recruitmentService.getForPrintRecruitmentsByLoginId(loginedMember.getId());

		model.addAttribute("recruitments", recruitments);


		return "adm/home/showMyPage";
	}
	
	@RequestMapping("/usr/home/showMyPage")
	public String showMyPage(Model model, HttpServletRequest req) {
		Job job = recruitmentService.getJobByCode("actor");
		
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		
		List<Applyment> applymentResults = applymentService.getApplymenResultInfoByMemberId(loginedMember.getId());
		model.addAttribute("applymentResults",applymentResults);
		
		Career career = careerService.getCareerByMember(loginedMember.getCareerId());
		if(career != null) {
			Map<String,String> joinedCareer = careerService.getDatesAndArtworkOfCareerByMember(loginedMember.getCareerId());

			model.addAttribute("joinedCareer", joinedCareer);
		}
		
		return "usr/home/showMyPage";
	}
	
}
