package com.quantom.audition.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@Controller
public class TestController {

	@RequestMapping("/test/mail/mailForm")
	public String showMain(Model model, HttpServletRequest req) {
	
		return "test/mail/mailForm";
	}
}