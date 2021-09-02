package com.quantom.audition.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quantom.audition.dto.ResultData;
import com.quantom.audition.service.ShareService;
import com.quantom.audition.util.Util;

@Controller
public class ShareController {
	@Autowired
	private ShareService shareService;

	@RequestMapping("/usr/share/doShareArtworksAndActingRolesAjax")
	@ResponseBody
	public ResultData doShareArtworksAndActingRolesAjax(@RequestParam Map<String, Object> param) {

		ResultData shareRd = shareService.doShareArtworksAndActingRolesAjax(param);

		return shareRd;
	}
	
	@RequestMapping("/usr/share/doShareArtworksAndActingRoles")
	public String doShareArtworksAndActingRoles(Model model, @RequestParam Map<String, Object> param) {

		shareService.doShareArtworksAndActingRolesAjax(param);

		model.addAttribute("redirectUri", "/usr/home/main");

		return "common/redirect";
	}
	
	@RequestMapping("/usr/share/doModifyShareAnswerAjax")
	@ResponseBody
	public ResultData doModifyShareAnswer(@RequestParam Map<String, Object> param) {

		shareService.doModifyShareAnswer(param);
		
		int answer = Util.getAsInt((param).get("answer"));
		String requesterName = Util.getAsStr((param).get("name"));

		return new ResultData("S-1",String.format("%s님의 지원자 공유제안을 %s하였습니다.", requesterName, answer == 1? "수락":"거절"));
	}
	
	
}
