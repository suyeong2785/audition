package com.quantom.audition.controller.adm;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.quantom.audition.config.AppConfig;
import com.quantom.audition.dto.ActingRole;
import com.quantom.audition.dto.Artwork;
import com.quantom.audition.dto.Member;
import com.quantom.audition.service.ActingRoleService;
import com.quantom.audition.util.Util;

@Controller
public class ActingRoleController {

	@Autowired
	private AppConfig appConfig;
	@Autowired
	private ActingRoleService actingRoleService;

	@RequestMapping("/{authority}/actingRole/artworkList")
	public String showAdmArtworkList(Model model, @PathVariable("authority") String authority) {
		List<Artwork> artworks = actingRoleService.getForPrintArtworks();

		model.addAttribute("artworks", artworks);

		String url = "usr/actingRole/artworkList";

		if (authority.equals("adm")) {
			url = "adm/actingRole/artworkList";
		}

		return url;
	}

	@RequestMapping("/adm/actingRole/writeArtwork")
	public String showWriteArtwork(Model model) {
		return "adm/actingRole/writeArtwork";
	}

	@RequestMapping("/adm/actingRole/doWriteArtwork")
	public String doWriteArtwork(@RequestParam Map<String, Object> param, HttpServletRequest req, Model model) {
		int newArtworkId = actingRoleService.writeArtwork(param);

		String redirectUri = (String) param.get("redirectUri");
		redirectUri = redirectUri.replace("#id", newArtworkId + "");

		return "redirect:" + redirectUri;
	}

	@RequestMapping("/{authority}/actingRole/detailArtwork")
	public String showDetailArtwork(Model model, @PathVariable("authority") String authority,
			@RequestParam Map<String, Object> param, HttpServletRequest req, String listUrl) {

		int id = Integer.parseInt((String) param.get("id"));

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Artwork artwork = actingRoleService.getForPrintArtworkById(loginedMember, id);

		if (artwork.getActingRole() != null) {
			String actingRole = artwork.getActingRole();
			List<String> actingRoles = Arrays.asList(actingRole.split("_")).stream().map(s -> s.trim())
					.collect(Collectors.toList());
			model.addAttribute("actingRoles", actingRoles);
		}
		if (artwork.getActingRoleGender() != null) {
			String actingGender = artwork.getActingRoleGender();
			List<String> actingGenders = Arrays.asList(actingGender.split("_")).stream().map(s -> s.trim())
					.collect(Collectors.toList());
			model.addAttribute("actingGenders", actingGenders);

		}
		if (artwork.getActingRoleAge() != null) {
			String actingAge = artwork.getActingRoleAge();
			List<String> actingAges = Arrays.asList(actingAge.split("_")).stream().map(s -> s.trim())
					.collect(Collectors.toList());
			model.addAttribute("actingAges", actingAges);
		}

		model.addAttribute("artwork", artwork);

		String url = "usr/actingRole/detailArtwork";

		if (listUrl == null) {
			listUrl = "../../usr/actingRole/artworkList";
		}

		if (authority.equals("adm")) {
			
			url = "adm/actingRole/detailArtwork";
			listUrl = "adm/actingRole/artworkList";

		}
		
		model.addAttribute("listUrl", listUrl);

		return url;
	}

	@RequestMapping("/adm/actingRole/modifyArtwork")
	public String showModifyArtwork(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req,
			String listUrl) {
		if (listUrl == null) {
			listUrl = "./list";
		}
		model.addAttribute("listUrl", listUrl);

		int id = Integer.parseInt((String) param.get("id"));

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Artwork artwork = actingRoleService.getForPrintArtworkById(loginedMember, id);

		model.addAttribute("artwork", artwork);

		return "adm/actingRole/modifyArtwork";
	}

	@RequestMapping("/adm/actingRole/doModifyArtwork")
	public String doModifyArtwork(@RequestParam Map<String, Object> param, HttpServletRequest req, Model model) {
		Map<String, Object> newParam = Util.getNewMapOf(param, "id", "name", "productionName", "directorName", "etc");
		actingRoleService.modifyArtwork(newParam);

		String redirectUri = (String) param.get("redirectUri");

		return "redirect:" + redirectUri;
	}

	@RequestMapping("/adm/actingRole/doDeleteArtwork")
	public String doModifyArtwork(int id, String listUrl) {
		actingRoleService.deleteArtwork(id);

		return "redirect:" + listUrl;
	}

	@RequestMapping("/{authority}/actingRole/list")
	public String showList(Model model, HttpServletRequest req, @PathVariable("authority") String authority) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("typeCode", "thumbnail");
		param.put("memberId", (int) req.getAttribute("loginedMemberId"));

		List<ActingRole> actingRoles = actingRoleService.getActingRolesForPrintList(param);

		model.addAttribute("actingRoles", actingRoles);

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		model.addAttribute("actorCanWrite", appConfig.actorCanWrite("recruitment", loginedMember));

		String url = "usr/actingRole/list";

		if (authority.equals("adm")) {
			url = "adm/actingRole/list";
		}

		return url;
	}

	@RequestMapping("/adm/actingRole/write")
	public String showWrite(Model model) {
		List<Artwork> artworks = actingRoleService.getArtworks();

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
