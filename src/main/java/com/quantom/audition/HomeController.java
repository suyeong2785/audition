package com.quantom.audition;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	
	@RequestMapping("/home/main")
	public String showMain() {
		return "home/main";
	}
}
