package com.quantom.audition.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quantom.audition.dto.ResultData;
import com.quantom.audition.service.ShareService;

@Controller
public class ShareController {
	@Autowired
	private ShareService shareService;

	@RequestMapping("/usr/share/doShareApplymentsAjax")
	@ResponseBody
	public ResultData doShareApplyments(@RequestParam Map<String, Object> param) {

		ResultData shareRd = shareService.doShareApplyments(param);

		return shareRd;
	}
}
