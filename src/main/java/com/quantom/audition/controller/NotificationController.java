package com.quantom.audition.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quantom.audition.dto.Applyment;
import com.quantom.audition.dto.Notification;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.service.ApplymentService;
import com.quantom.audition.service.NotificationService;
import com.quantom.audition.util.Util;

@Controller
public class NotificationController {
	@Autowired
	NotificationService notificationService;
	@Autowired
	ApplymentService applymentService;
	
	@RequestMapping("/usr/notification/getNotificationsRelatedToUserAjax")
	@ResponseBody
	public ResultData getNotificationsRelatedToUserAjax(@RequestParam Map<String, Object> param,HttpServletRequest req) {
		int loginedMemberId = Util.getAsInt(req.getAttribute("loginedMemberId"));
		//접속자가 지원한 지원목록

		List<Applyment> applyments = null;
		if(applymentService.getActingRolesRelatedToApplymentByMemberId(loginedMemberId) != null) {
			applyments = applymentService.getActingRolesRelatedToApplymentByMemberId(loginedMemberId);
		}
		List<Integer> applymentsIds = new ArrayList<>();
		if(applyments != null) {
			for(Applyment applyment : applyments) {
				if(applyment != null && applyment.getExtra() != null && applyment.getExtra().get("actingRoleId") != null) {
					System.out.println("applyment.getExtra().get(\"actingRoleId\") : " +  Util.getAsInt(String.valueOf(applyment.getExtra().get("actingRoleId"))));
					applymentsIds.add( Util.getAsInt(String.valueOf(applyment.getExtra().get("actingRoleId"))));
				}
				
			}
		}
		
		List<Notification> notifications = new ArrayList<Notification>();
		if(applymentsIds.size() != 0) {
			notifications = notificationService.getApplymentNotificationsRelatedToUser(loginedMemberId,applymentsIds);
		}
		
		if(notifications.isEmpty() == false) {
			return new ResultData("S-1", String.format("%d개의 알림을 가져왔습니다.",notifications.size()),"notifications",notifications,"notificationsSize",notifications.size());
		}else {
			return new ResultData("S-2", "가져올 알림이 없습니다.");
		}
	}

	@RequestMapping("/usr/notification/changeNotificationAlarmStatusAjax")
	@ResponseBody
	public ResultData changeNotificationAlarmStatusAjax(@RequestParam Map<String, Object> param) {
		
		notificationService.changeNotificationAlarmStatus(param);

		return new ResultData("S-1", String.format("%d번의 알림을 확인을했습니다.",Util.getAsInt(param.get("id"))));
	}
	
	@RequestMapping("/usr/notification/changeNotificationCheckStatusAjax")
	@ResponseBody
	public ResultData changeNotificationCheckStatusAjax(@RequestParam Map<String, Object> param) {
		
		notificationService.changeNotificationCheckStatus(param);

		return new ResultData("S-1", String.format("%d번의 알림을 확인을했습니다.",Util.getAsInt(param.get("id"))));
	}

	
	
}
