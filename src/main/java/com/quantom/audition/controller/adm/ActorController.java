package com.quantom.audition.controller.adm;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quantom.audition.dto.Actor;
import com.quantom.audition.dto.File;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.service.CareerService;
import com.quantom.audition.service.FileService;
import com.quantom.audition.service.adm.ActorService;
import com.quantom.audition.util.Util;

@Controller
public class ActorController {
	
	@Autowired
	private ActorService actorService;
	
	@Autowired
	private CareerService careerService;
	
	@Autowired
	private FileService fileService;
	
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

		if(Util.getAsStr(param.get("artwork")) != null && Util.getAsStr(param.get("artwork")) != "" ) {
			careerService.setCareer(param);
		}else {
			param.put("careerId", "");
		}
		
		actorService.join(param);

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}
	
	@RequestMapping("/adm/actor/getActor")
	public String getActor(@RequestParam Map<String, Object> param, Model model, HttpServletRequest req) {
		
		return "/adm/actor/getActor";
	}
	
	@RequestMapping("/adm/actor/getActorListByNameAjax")
	@ResponseBody
	public ResultData getActorListByName(@RequestParam Map<String, Object> param) {
		String name = Util.getAsStr(param.get("name"));
		
		List<Actor> actors = actorService.getActorListByName(name);
		if(actors.isEmpty()) {
			return new ResultData("F-1", "일치하는 검색결과가 없습니다.");
		}
		
		return new ResultData("S-1", "배우리스트 검색성공!","actors",actors);
	}
	
	@RequestMapping("/adm/actor/getForPrintActorByIdAjax")
	@ResponseBody
	public ResultData getForPrintActorById(@RequestParam Map<String, Object> param) {
		int id = Util.getAsInt(param.get("id"));
		
		Actor forPrintactor = actorService.getForPrintActorById(id);
		
		File fileForProfile = null;
		if(fileForProfile == null) {
			fileForProfile = fileService.getFileRelTypeCodeAndRelIdAndTypeCodeAndType2Code("actor", id, "common", "attachment");
		}	
				
		if(forPrintactor == null) {
			return new ResultData("F-1", "일치하는 검색결과가 없습니다.");
		}
		
		return new ResultData("S-1", "배우 검색성공!","forPrintactor",forPrintactor,"fileForProfile",fileForProfile);
	}

}

