package com.quantom.audition.controller.adm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
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
import com.quantom.audition.service.NotificationService;
import com.quantom.audition.util.Util;

/**
 * 캐스팅공고(artwork)에 해당하는 배역(actingRole)을 관리하는 컨트롤러 
 * Artwork - 지원공고
 */
@Controller
public class ActingRoleController {

	@Autowired
	private AppConfig appConfig;
	@Autowired
	private ActingRoleService actingRoleService;
	@Autowired
	private ArtworkService artworkService;
	@Autowired
	private NotificationService notificationService;

	
	@RequestMapping("/{authority}/actingRole/artworkListForAuditions")
	public String showList(Model model, HttpServletRequest req, @PathVariable("authority") String authority) {
		Map<String, Object> param = new HashMap<String, Object>();
		List<Artwork> artworks = artworkService.getForPrintArtworks();

		model.addAttribute("artworks", artworks);

		String url = "usr/actingRole/artworkListForAuditions";

		if (authority.equals("adm")) {
			url = "adm/actingRole/artworkListForAuditions";
		}

		return url;
	}

	@RequestMapping("/adm/actingRole/getActingRoleListByArtworkIdAjax")
	@ResponseBody
	public ResultData getActingRoleListByArtworkIdAjax(HttpServletRequest req,@RequestParam Map<String,Object> param) {
		
		Map<String, Object> rsDataBody = new HashMap<>();
		
		if(param.get("limitStart") != null && param.get("limitStart") != "") {
			param.put("limitStart", Integer.parseInt((String)param.get("limitStart")));
			param.put("limitTake", Integer.parseInt((String)param.get("limitTake")));	
		}
		
		List<ActingRole> actingRoles = actingRoleService.getActingRolesForPrintListByArtworkId(param);
		
		if(actingRoles.isEmpty()) {
			return new ResultData("F-1", "해당하는 작품의 배역리스트가 없습니다.");
		}

		rsDataBody.put("actingRoles", actingRoles);
		return new ResultData("S-1", "해당하는 작품의 배역리스트를 찾았습니다.",rsDataBody);
	}
	
	@RequestMapping("/usr/actingRole/getActingRoleByArtworkIdAndNameAndAgeAndGenderAjax")
	@ResponseBody
	public ResultData getActingRoleByArtworkIdAndNameAndAgeAndGenderAjax(HttpServletRequest req,@RequestParam Map<String,Object> param) {
		
		ActingRole actingRole = actingRoleService.getActingRoleByArtworkIdAndNameAndAgeAndGenderAjax(param);
		
		if(actingRole == null) {
			return new ResultData("F-1", "해당하는 작품의 배역리스트가 없습니다.");
		}

		return new ResultData("S-1", "해당하는 작품의 배역리스트를 찾았습니다.","actingRole",actingRole);
	}
	
	@RequestMapping("/adm/actingRole/checkActingRoleAvailableByArtworkIdAndNamesAndAgesAndGendersAjax")
	@ResponseBody
	public ResultData checkActingRoleAvailableByArtworkIdAndNamesAndAgesAndGendersAjax(HttpServletRequest req,
			@RequestParam(value="names[]") List<String> names, @RequestParam(value="artworkId") String artworkId) {
		
		List<ActingRole> actingRoles = actingRoleService.checkActingRoleAvailableByArtworkIdAndNamesAndAgesAndGendersAjax(names,artworkId);
		
		if(actingRoles.isEmpty()) {
			return new ResultData("F-1", "해당하는 작품의 배역리스트가 없습니다.");
		}

		return new ResultData("S-1", "해당하는 작품의 배역리스트를 찾았습니다.","actingRoles",actingRoles);
	}

	/**
	 * 오디션 등록 메소드(뷰)
	 * @param model
	 * @return
	 */
	@RequestMapping("/adm/actingRole/write")
	public String showWrite(Model model) {
		List<Artwork> artworks = artworkService.getArtworks();

		model.addAttribute("artworks", artworks);

		return "adm/actingRole/write";
	}

	/**
	 * 오디션 등록 메소드(로직)
	 * @param param
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping("/adm/actingRole/doWrite")
	public String doWrite(@RequestParam Map<String, Object> param, HttpServletRequest req, Model model) {

		int newActingRoleId = actingRoleService.write(param);

		String redirectUri = (String) param.get("redirectUri");
		redirectUri = redirectUri.replace("#id", newActingRoleId + "");

		return "redirect:" + redirectUri;
	}
	
	@RequestMapping("/adm/actingRole/doWriteAjax")
	@ResponseBody
	public ResultData doWriteAjax(@RequestBody Map<String, Object> param, HttpServletRequest req, Model model) {
		System.out.println("param : " + param);
		int newActingRoleId = actingRoleService.write(param);
		
		return new ResultData("S-1", String.format("%d번 역을 생성하였습니다.", newActingRoleId),"newActingRoleId",newActingRoleId);
	}

	@RequestMapping("/adm/actingRole/doModify")
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req, Model model) {
		Map<String, Object> newParam = Util.getNewMapOf(param, "id", "artworkId", "name", "age", "gender", "character",
				"scenesCount", "scriptStatus", "auditionStatus", "shootingsCount", "etc");
		int id = actingRoleService.modify(newParam);

		String redirectUri = (String) param.get("redirectUri");

		return "redirect:" + redirectUri;
	}
	
	@RequestMapping("/adm/actingRole/doModifyAjax")
	@ResponseBody
	public ResultData doModifyAjax(@RequestBody Map<String, Object> param, HttpServletRequest req, Model model) {
		int id = actingRoleService.modify(param);

		return new ResultData("S-1", String.format("%d번의 게시물을 수정했습니다.", id));
	}

	@RequestMapping("/adm/actingRole/doDelete")
	public String doModify(int id, String listUrl) {
		actingRoleService.delete(id);

		return "redirect:" + listUrl;
	}
	
	@RequestMapping("/adm/actingRole/doDeleteAjax")
	@ResponseBody
	public ResultData doDeleteAjax(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		actingRoleService.delete(Util.getAsInt(param.get("id")));
		notificationService.insertNotificationMessage(param);

		return new ResultData("S-1", String.format("%d번 게시물을 삭제했습니다.", Util.getAsInt(param.get("id"))), "id" , Util.getAsInt(param.get("id")));
	}

	@RequestMapping("/{authority}/actingRole/detailArtworkForAuditions")
	public String showDetail(Model model, @PathVariable("authority") String authority,
			@RequestParam Map<String, Object> param, HttpServletRequest req, String listUrl) {
		if (listUrl == null) {
			listUrl = "./list";
		}
		model.addAttribute("listUrl", listUrl);

		int id = Integer.parseInt((String) param.get("id"));

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		Artwork artwork = artworkService.getForPrintArtworkById(id);
		List<ActingRole> actingRoles = actingRoleService.getActingRolesForPrintAuditionsByArtworkId(id);

		model.addAttribute("actingRoles", actingRoles);
		model.addAttribute("artwork", artwork);

		String url = "usr/actingRole/detailArtworkForAuditions";

		if (authority.equals("adm")) {
			url = "adm/actingRole/detailArtworkForAuditions";
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
