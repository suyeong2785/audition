package com.quantom.audition.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quantom.audition.config.AppConfig;
import com.quantom.audition.dto.ActingRole;
import com.quantom.audition.dto.Applyment;
import com.quantom.audition.dto.Member;
import com.quantom.audition.dto.Notification;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.dto.Share;
import com.quantom.audition.service.ActingRoleService;
import com.quantom.audition.service.ApplymentService;
import com.quantom.audition.service.FileService;
import com.quantom.audition.service.NotificationService;
import com.quantom.audition.service.RecruitmentService;
import com.quantom.audition.service.ShareService;
import com.quantom.audition.util.Util;

@Controller
public class ApplymentController {
	@Autowired
	private ApplymentService applymentService;
	@Autowired
	private RecruitmentService recruitmentService;
	@Autowired
	private ActingRoleService actingRoleService;
	@Autowired
	private ShareService shareService;
	@Autowired
	private AppConfig appConfig;
	@Autowired
	private FileService fileService;
	@Autowired
	private NotificationService notificationService;

	@RequestMapping("/usr/applyment/getForPrintApplyments")
	@ResponseBody
	public ResultData getForPrintApplyments(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Map<String, Object> rsDataBody = new HashMap<>();

		param.put("relTypeCode", "recruitment");
		Util.changeMapKey(param, "recruitmentId", "relId");

		boolean actorIsWriter = recruitmentService.actorIsWriter(loginedMember, Util.getAsInt(param.get("relId")));

		if (actorIsWriter == false) {
			param.put("memberId", loginedMember.getId());
		}

		param.put("actor", loginedMember);
		List<Applyment> applyments = applymentService.getForPrintApplyments(param);
		rsDataBody.put("applyments", applyments);

		return new ResultData("S-1", String.format("%d개의 신청을 불러왔습니다.", applyments.size()), rsDataBody);
	}
	
	@RequestMapping("/usr/applyment/getForPrintApplymentsByResult")
	@ResponseBody
	public ResultData getForPrintApplymentsByResult(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Map<String, Object> rsDataBody = new HashMap<>();

		param.put("relTypeCode", "recruitment");
		Util.changeMapKey(param, "recruitmentId", "relId");

		boolean actorIsWriter = recruitmentService.actorIsWriter(loginedMember, Util.getAsInt(param.get("relId")));

		if (actorIsWriter == false) {
			param.put("memberId", loginedMember.getId());
		}

		param.put("actor", loginedMember);
		List<Applyment> applyments = applymentService.getForPrintApplymentsByResult(param);
		rsDataBody.put("applyments", applyments);

		return new ResultData("S-1", String.format("%d개의 신청을 불러왔습니다.", applyments.size()), rsDataBody);
	}

	@RequestMapping("/usr/applyment/getForPrintApplyment")
	@ResponseBody
	public ResultData getForPrintApplyment(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		Map<String, Object> rsDataBody = new HashMap<>();

		Applyment applyment = applymentService.getForPrintApplyment(param);
		rsDataBody.put("applyment", applyment);

		return new ResultData("S-1", "1개의 신청을 불러왔습니다.", rsDataBody);
	}
	
	@RequestMapping("/usr/applyment/getActingRolesRelatedToApplymentByArtworkIdAjax")
	@ResponseBody
	public ResultData getActingRolesRelatedToApplymentByArtworkIdAjax(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		
		int memberId = Util.getAsInt(req.getAttribute("loginedMemberId"));
		int artworkId = Util.getAsInt(param.get("artworkId"));
		Map<String, Object> rsDataBody = new HashMap<>();

		List<Applyment> applyments = applymentService.getActingRolesRelatedToApplymentByArtworkIdAjax(memberId, artworkId);
		List<Integer> applymentsIds = new ArrayList<>();
		for(Applyment applyment : applyments) {
			System.out.println("applyment.getExtra().get(\"id\") : " + applyment.getExtra().get("id"));
			applymentsIds.add( Util.getAsInt(String.valueOf(applyment.getExtra().get("id"))));
		}
		
		param.put("applymentsIds", applymentsIds);
		List<Notification> notifications = notificationService.getNotificationsRelatedToGetterIdAndRelIdAndRelTypeCode(param);
		
		rsDataBody.put("applyments", applyments);
		rsDataBody.put("notifications", notifications);

		return new ResultData("S-1", String.format("%d개의 신청을 불러왔습니다.", applyments.size()), rsDataBody);
	}
	
	@RequestMapping("/usr/applyment/getForPrintApplymentRelatedToResultAjax")
	@ResponseBody
	public ResultData getForPrintApplymentRelatedToResultAjax(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		Map<String, Object> rsDataBody = new HashMap<>();
		
		Applyment applyment = applymentService.getForPrintApplymentRelatedToResult(param);
		rsDataBody.put("applyment", applyment);

		return new ResultData("S-1", "1개의 신청을 불러왔습니다.", rsDataBody);
	}
	
	@RequestMapping("/adm/applyment/showMyApplyments")
	public String showMyApplyments(Model model,@RequestParam Map<String, Object> param) {
		
		List<Applyment> applyments = applymentService.getForPrintApplymentsByRelIdAndRelTypeCode(param);
		List<Share> shares = shareService.getAccesibleRequesteesByActingRoleId(param);
		
		model.addAttribute("applyments", applyments);
		model.addAttribute("shares", shares);
		model.addAttribute("artworkId", param.get("artworkId"));
		model.addAttribute("artworkTitle", param.get("artworkTitle"));
		model.addAttribute("actingRoleId", param.get("actingRoleId"));
		model.addAttribute("actingRoleGender", param.get("actingRoleGender"));
		model.addAttribute("actingRoleAge", param.get("actingRoleAge"));
		model.addAttribute("actingRole", param.get("actingRole"));
		model.addAttribute("artworkFileUrl", param.get("artworkFileUrl"));
		
		return "/adm/applyment/showMyApplyments";
	}
	
	@RequestMapping("/usr/applyment/write")
	public String write(Model model,int id, HttpServletRequest request,@RequestParam Map<String, Object> param) {
		
		ActingRole actingRole = actingRoleService.getActingRoleForPrintDetailById(id);
		model.addAttribute("actingRole", actingRole);
		model.addAttribute("artworkFileUrl", param.get("artworkFileUrl"));
		model.addAttribute("artworkTitle", param.get("artworkTitle"));
		model.addAttribute("artworkId", param.get("artworkId"));
		model.addAttribute("artworkType", param.get("artworkType"));
		
		return "usr/applyment/write";
	}
	
	@RequestMapping("/usr/applyment/doWrite")
	public String doWrite(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		Map<String, Object> rsDataBody = new HashMap<>();

		Member loginedMember = (Member) request.getAttribute("loginedMember");
		param.put("memberId", request.getAttribute("loginedMemberId"));

		int newApplymentId = applymentService.writeApplyment(param);

		String redirectUri = (String) param.get("redirectUri");

		return "redirect:" + redirectUri;
	}

	@RequestMapping("/usr/applyment/doWriteApplymentAjax")
	@ResponseBody
	public ResultData doWriteApplymentAjax(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		Map<String, Object> rsDataBody = new HashMap<>();

		Member loginedMember = (Member) request.getAttribute("loginedMember");
		param.put("memberId", request.getAttribute("loginedMemberId"));

		ResultData checkWriteApplymentAvailableResultData = applymentService.checkActorCanWriteApplyment(loginedMember,
				(String) param.get("relTypeCode"), Util.getAsInt(param.get("relId")));

		if (checkWriteApplymentAvailableResultData.isFail()) {
			fileService.deleteFiles((String) param.get("fileIdsStr"));

			return checkWriteApplymentAvailableResultData;
		}

		int newApplymentId = applymentService.writeApplyment(param);
		rsDataBody.put("applymentId", newApplymentId);

		return new ResultData("S-1",
				String.format("신청이 완료되었습니다, " + appConfig.getModifyAvailablePerioMinutes() + "분 이내에만 삭제, 수정이 가능합니다.",
						newApplymentId),
				rsDataBody);
	}

	@RequestMapping("/usr/applyment/doDeleteApplymentAjax")
	@ResponseBody
	public ResultData doDeleteApplymentAjax(int id, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Applyment applyment = applymentService.getForPrintApplymentById(id);

		if ((boolean)req.getAttribute("isAdmin") == false) {
			if (applymentService.actorCanDelete(loginedMember, applyment) == false) {
				return new ResultData("F-1", String.format("%d번 신청을 삭제할 권한이 없습니다.", id));
			}

		}

		applymentService.deleteApplyment(id);

		return new ResultData("S-1", String.format("%d번 신청을 삭제하였습니다.", id));
	}
	
	@RequestMapping("/usr/applyment/doChangeApplymentResultAjax")
	@ResponseBody
	public ResultData doChangeApplymentResult(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		int id = Util.getAsInt(param.get("id"));
		Applyment applyment = applymentService.getForPrintApplymentById(id);

		if ((boolean)req.getAttribute("isAdmin") == false) {
			if (applymentService.actorCanModify(loginedMember, applyment) == false) {
				return new ResultData("F-1", String.format("%d번 신청을 수정할 권한이 없습니다.", id));
			}
		}

		applymentService.changeApplymentResult(param);

		if(Util.getAsInt(param.get("result")) == 1) {
			return new ResultData("S-1", String.format("%d번 지원자를 합격시키셨습니다.", id));
		}
		
		return new ResultData("S-1", String.format("%d번 지원자를 탈락시키셧습니다.", id));
	}

	@RequestMapping("/usr/applyment/doModifyApplymentAjax")
	@ResponseBody
	public ResultData doModifyApplymentAjax(@RequestParam Map<String, Object> param, HttpServletRequest req, int id) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Applyment applyment = applymentService.getForPrintApplymentById(id);

		if (applymentService.actorCanModify(loginedMember, applyment) == false) {
			return new ResultData("F-1", String.format("%d번 신청을 수정할 권한이 없습니다.", id));
		}

		Map<String, Object> modfiyApplymentParam = Util.getNewMapOf(param, "id", "body");
		ResultData rd = applymentService.modfiyApplyment(modfiyApplymentParam);

		return rd;
	}

	@RequestMapping("/usr/applyment/doSetVisible")
	@ResponseBody
	public ResultData doSetVisible(HttpServletRequest req, int id, String value) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Applyment applyment = applymentService.getForPrintApplymentById(id);

		if (applymentService.actorCanToggle(loginedMember, applyment) == false) {
			return new ResultData("F-1", String.format("%d번 신청을 수정할 권한이 없습니다.", id));
		}

		ResultData rd = applymentService.changeHideStatus(id, value.trim().equals("hide"));

		return rd;
	}
	
	@RequestMapping("/usr/applyment/notifyUserOfApplymentResultAjax")
	@ResponseBody
	public ResultData notifyUserOfApplymentResult(@RequestParam Map<String, Object> param) {
		
		List<Applyment> applyments = applymentService.notifyUserOfApplymentResult(param);

		if(applymentService.notifyUserOfApplymentResult(param).size() != 0 ) {
			return new ResultData("S-1", String.format("%d개 검색결과가 있습니다.", applyments.size()),"applyments",applyments,"applymentsSize",applyments.size());
		}else {
			return new ResultData("S-2","검색결과가 없습니다.","applymentsSize", 0);
		}
		
	}
	
	@RequestMapping("/usr/applyment/changeApplymentAlarmStatusAjax")
	@ResponseBody
	public ResultData changeApplymentAlarmStatus(@RequestParam Map<String, Object> param) {
		
		applymentService.changeApplymentAlarmStatus(param);

		return new ResultData("S-1", String.format("%d번 지원정보 알람확인하셨습니다.", Util.getAsInt(param.get("id"))));
	}
	
	@RequestMapping("/usr/applyment/getRowNumbersOfApplymentsByMemberIdAndArtworkIdAjax")
	@ResponseBody
	public ResultData getRowNumbersOfApplymentsByMemberIdAndArtworkId(@RequestParam Map<String, Object> param) {
		
		List<Map<String, Object>> actingRoleListRowNumHashMapList = applymentService.getRowNumbersOfApplymentsByMemberIdAndArtworkId(param);

		return new ResultData("S-1", String.format("요청하신 작품에 지원하신 배역의 결과는 총 %d개입니다.", actingRoleListRowNumHashMapList.size()),"actingRoleListRowNumHashMapList",actingRoleListRowNumHashMapList);
	}

	@RequestMapping("/usr/applyment/changeApplymentCheckStatusAjax")
	@ResponseBody
	public ResultData changeApplymentCheckStatusAjax(@RequestParam Map<String, Object> param) {
		
		applymentService.changeApplymentCheckStatus(param);

		return new ResultData("S-1", String.format("%d번 역할을 확인하셨습니다.",Util.getAsInt(param.get("id"))));
	}
	
}
