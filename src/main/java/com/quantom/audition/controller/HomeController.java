package com.quantom.audition.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.quantom.audition.config.AppConfig;
import com.quantom.audition.dto.Job;
import com.quantom.audition.dto.Member;
import com.quantom.audition.dto.Recruitment;
import com.quantom.audition.service.RecruitmentService;

@Controller
public class HomeController {
	@Autowired
	RecruitmentService recruitmentService;
	
	@Autowired
	AppConfig appConfig;
	
	@RequestMapping("/usr/home/main")
	public String showMain() {
	    return "redirect:/usr/recruitment/actor-list";
	}
	
	@RequestMapping("/")
	public String showIndex() {
		return "usr/home/main";
	}
	
	@RequestMapping("/adm/home/showMyPage")
	public String showMyPage(Model model, HttpServletRequest req) {
		Job job = recruitmentService.getJobByCode("actor");
		model.addAttribute("job", job);

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		model.addAttribute("actorCanWrite", appConfig.actorCanWrite("recruitment", loginedMember));

		List<Recruitment> recruitments = recruitmentService.getForPrintRecruitments();

		model.addAttribute("recruitments", recruitments);


		return "adm/home/showMyPage";
	}
}
