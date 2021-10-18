package com.quantom.audition.controller.adm;

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
import com.quantom.audition.service.ShareService;
import com.quantom.audition.util.Util;

/**
 * 캐스팅공고(artwork)를 관리하는 컨트롤러
 */
@Controller
public class ArtworkController {

	@Autowired
	private AppConfig appConfig;

	@Autowired
	private ArtworkService artworkService;
	
	@Autowired
	private ShareService shareService;
	
	@Autowired
	private ActingRoleService actingRoleService;

	/**
	 * 지원공고 리스트 (adm 과 나머지) // 진행중인 캐스팅(마이페이지)
	 * 
	 * adm -> 진행중인캐스팅 (지원공고 수정 가능)
	 * @param model
	 * @param authority
	 * @param req
	 * @return
	 */
	@RequestMapping("/{authority}/actingRole/artworkList")
	public String showAdmArtworkList(Model model, @PathVariable("authority") String authority,HttpServletRequest req) {
		int memberId = Util.getAsInt(req.getAttribute("loginedMemberId"));
		List<Artwork> artworks = artworkService.getArtworksForArtworkListPageByMemberId(memberId);

		model.addAttribute("artworks", artworks);

		String url = "usr/actingRole/artworkList";

		if (authority.equals("adm")) {
			url = "adm/actingRole/artworkList";
		}

		return url;
	}

	/**
	 * 지원공고 작성 메소드(뷰)
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/adm/actingRole/writeArtwork")
	public String showWriteArtwork(Model model) {
		return "adm/actingRole/writeArtwork";
	}

	/**
	 * 지원공고 작성 메소드(메소드)
	 * 
	 * @param param
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping("/adm/actingRole/doWriteArtwork")
	public String doWriteArtwork(@RequestParam Map<String, Object> param, HttpServletRequest req, Model model) {
		int newArtworkId = artworkService.writeArtwork(param);

		String redirectUri = (String) param.get("redirectUri");
		redirectUri = redirectUri.replace("#id", newArtworkId + "");

		return "redirect:" + redirectUri;
	}

	/**
	 * 지원공고 상세보기 메소드  ( 유저 / 어드민 나뉘어있음 ) 
	 * 
	 * 어드민은 사용하지 않음
	 * @param model
	 * @param authority
	 * @param param
	 * @param req
	 * @param listUrl
	 * @return
	 */
	@RequestMapping("/{authority}/actingRole/detailArtwork")
	public String showDetailArtwork(Model model, @PathVariable("authority") String authority,
			@RequestParam Map<String, Object> param, HttpServletRequest req, String listUrl) {

		int id = Integer.parseInt((String) param.get("id"));

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Artwork artwork = artworkService.getForPrintArtworkById(id);
		List<ActingRole> actingRoles = actingRoleService.getActingRolesForPrintAuditionsByArtworkId(id);

		model.addAttribute("artwork", artwork);
		model.addAttribute("actingRoles", actingRoles);

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

	/**
	 * 지원공고 수정 (진행중인 캐스팅 수정 -> 마이페이지에서 접근 가능) (뷰)
	 * 
	 * @param model
	 * @param param
	 * @param req
	 * @param listUrl
	 * @return
	 */
	@RequestMapping("/adm/actingRole/modifyArtwork")
	public String showModifyArtwork(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req,
			String listUrl) {
		if (listUrl == null) {
			listUrl = "./list";
		}
		model.addAttribute("listUrl", listUrl);

		int id = Integer.parseInt((String) param.get("id"));

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Artwork artwork = artworkService.getForPrintArtworkForCastingCallModifyById(id);
		List<ActingRole> actingRoles = actingRoleService.getActingRolesForPrintCastingCallModifyByArtworkId(id);

		model.addAttribute("artwork", artwork);
		model.addAttribute("actingRoles", actingRoles);

		return "adm/actingRole/modifyArtwork";
	}

	
	/**
	 * 지원공고 수정 (진행중인 캐스팅 수정 -> 마이페이지에서 접근 가능) (로직)
	 * 
	 * @param param
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping("/adm/actingRole/doModifyArtwork")
	public String doModifyArtwork(@RequestParam Map<String, Object> param, HttpServletRequest req, Model model) {

		artworkService.modifyArtwork(param);

		String redirectUri = (String) param.get("redirectUri");

		return "redirect:" + redirectUri;
	}
	
	@RequestMapping("/adm/actingRole/doDeleteArtworkAjax")
	@ResponseBody
	public ResultData doDeleteArtworkAjax(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		int id = Util.getAsInt(param.get("id"));
		
		artworkService.deleteArtwork(param);

		return new ResultData("S-1", String.format("해당게시물을 삭제했습니다.", id));
	}
}
