package com.quantom.audition.controller.adm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quantom.audition.config.AppConfig;
import com.quantom.audition.dto.ActingRole;
import com.quantom.audition.dto.Artwork;
import com.quantom.audition.dto.Member;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.service.ActingRoleService;
import com.quantom.audition.service.ArtworkService;
import com.quantom.audition.util.Util;

@Controller
public class ActingRoleController {

	@Autowired
	private AppConfig appConfig;
	@Autowired
	private ActingRoleService actingRoleService;
	@Autowired
	private ArtworkService artworkService;

	@RequestMapping("/{authority}/actingRole/list")
	public String showList(Model model, HttpServletRequest req, @PathVariable("authority") String authority) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("typeCode", "thumbnail");
		param.put("memberId", (int) req.getAttribute("loginedMemberId"));

		List<ActingRole> actingRoles = actingRoleService.getActingRolesForPrintList(param);

		model.addAttribute("actingRoles", actingRoles);

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		String url = "usr/actingRole/list";

		if (authority.equals("adm")) {
			url = "adm/actingRole/list";
		}

		return url;
	}
	
	@RequestMapping("/adm/actingRole/getActingRoleListAjax")
	@ResponseBody
	public ResultData getActingRoleListAjax(HttpServletRequest req,@RequestParam Map<String,Object> param) {

		Map<String, Object> rsDataBody = new HashMap<>();
		
		List<ActingRole> actingRoles = actingRoleService.getActingRolesForPrintListByArtworkId(param);
		
		if(actingRoles.isEmpty()) {
			return new ResultData("F-1", "해당하는 작품의 배역리스트가 없습니다.");
		}

		rsDataBody.put("actingRoles", actingRoles);
		return new ResultData("S-1", "해당하는 작품의 배역리스트를 찾았습니다.",rsDataBody);
	}

	@RequestMapping("/adm/actingRole/write")
	public String showWrite(Model model) {
		List<Artwork> artworks = artworkService.getArtworks();

		model.addAttribute("artworks", artworks);

		return "adm/actingRole/write";
	}

	@RequestMapping("/adm/actingRole/doWrite")
	public String doWrite(@RequestParam Map<String, Object> param, HttpServletRequest req, Model model) {

		int newActingRoleId = actingRoleService.write(param);

		String redirectUri = (String) param.get("redirectUri");
		redirectUri = redirectUri.replace("#id", newActingRoleId + "");

		return "redirect:" + redirectUri;
	}

	@RequestMapping("/adm/actingRole/doModify")
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req, Model model) {
		Map<String, Object> newParam = Util.getNewMapOf(param, "id", "artworkId", "name", "age", "gender", "character",
				"scenesCount", "scriptStatus", "auditionStatus", "shootingsCount", "etc");
		actingRoleService.modify(newParam);

		String redirectUri = (String) param.get("redirectUri");

		return "redirect:" + redirectUri;
	}

	@RequestMapping("/adm/actingRole/doDelete")
	public String doModify(int id, String listUrl) {
		actingRoleService.delete(id);

		return "redirect:" + listUrl;
	}

	@RequestMapping("/{authority}/actingRole/detail")
	public String showDetail(Model model, @PathVariable("authority") String authority,
			@RequestParam Map<String, Object> param, HttpServletRequest req, String listUrl) {
		if (listUrl == null) {
			listUrl = "./list";
		}
		model.addAttribute("listUrl", listUrl);

		int id = Integer.parseInt((String) param.get("id"));

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		ActingRole actingRole = actingRoleService.getActingRoleForPrintDetailById(id);

		model.addAttribute("actingRole", actingRole);

		String url = "usr/actingRole/detail";

		if (authority.equals("adm")) {
			url = "adm/actingRole/detail";
		}

		return url;
	}

	@RequestMapping("/adm/actingRole/modify")
	public String showModify(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req,
			String listUrl) {
		if (listUrl == null) {
			listUrl = "./list";
		}
		model.addAttribute("listUrl", listUrl);

		int id = Integer.parseInt((String) param.get("id"));

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		ActingRole actingRole = actingRoleService.getForPrintActingRoleById(loginedMember, id);

		model.addAttribute("actingRole", actingRole);

		return "adm/actingRole/modify";
	}
}
