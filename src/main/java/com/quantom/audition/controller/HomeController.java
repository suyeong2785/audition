package com.quantom.audition.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.quantom.audition.config.AppConfig;
import com.quantom.audition.dto.Applyment;
import com.quantom.audition.dto.Job;
import com.quantom.audition.dto.Member;
import com.quantom.audition.dto.Recruitment;
import com.quantom.audition.service.ApplymentService;
import com.quantom.audition.service.RecruitmentService;

@Controller
public class HomeController {
	@Autowired
	RecruitmentService recruitmentService;
	
	@Autowired
	AppConfig appConfig;
	
	@Autowired
	ApplymentService applymentService;
	
	@RequestMapping("/usr/home/main")
	public String showMain() {
	    return "redirect:/usr/recruitment/actor-list";
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

		List<Recruitment> recruitments = recruitmentService.getForPrintRecruitments();

		model.addAttribute("recruitments", recruitments);


		return "adm/home/showMyPage";
	}
	
	@RequestMapping("/usr/home/showMyPage")
	public String showMyPage(Model model, HttpServletRequest req) {
		Job job = recruitmentService.getJobByCode("actor");
		
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		
		List<Applyment> applymentResults = applymentService.getApplymenResultInfoByMemberId(loginedMember.getId());
		model.addAttribute("applymentResults",applymentResults);
		
		return "usr/home/showMyPage";
	}
}
