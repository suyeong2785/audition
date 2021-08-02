package com.quantom.audition.controller.adm;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.quantom.audition.dto.Career;
import com.quantom.audition.dto.Member;
import com.quantom.audition.service.CareerService;
import com.quantom.audition.service.adm.ActorService;
import com.quantom.audition.util.Util;

@Controller
public class ActorController {
	
	@Autowired
	private ActorService actorService;
	
	@Autowired
	private CareerService careerService;
	
	@RequestMapping("/adm/actor/join")
	public String join(Model model) {

		return "/adm/actor/join";
	}
	
	@RequestMapping("/adm/actor/doJoin")
	public String doJoin(@RequestParam Map<String, Object> param, Model model, HttpServletRequest req) {
		
		Util.changeMapKey(param, "careerDates", "date");
		Util.changeMapKey(param, "careerArtworks", "artwork");
		
		System.out.println("careerDates : " + param.get("careerDates"));
		System.out.println("careerArtworks : " + param.get("careerArtworks"));

		careerService.setCareer(param);
		
		actorService.join(param);

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}
	
	@RequestMapping("/adm/actor/getActor")
	public String getActor(@RequestParam Map<String, Object> param, Model model, HttpServletRequest req) {
		
		return "/adm/actor/getActor";
	}
	
}
