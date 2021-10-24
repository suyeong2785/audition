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
import com.quantom.audition.util.Util;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@Controller
public class TestController {

	@RequestMapping("/test/mail/mailForm")
	public String showMain(Model model, HttpServletRequest req) {
	
		return "test/mail/mailForm";
	}
}