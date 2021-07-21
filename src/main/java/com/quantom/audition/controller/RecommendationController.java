package com.quantom.audition.controller;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quantom.audition.dto.ResultData;
import com.quantom.audition.service.RecommendationService;

@Controller
public class RecommendationController {

	@Autowired
	private RecommendationService recommendationService;
	
	@RequestMapping("usr/recommendation/doMakeRecommendMemberAjax")
	@ResponseBody
	public ResultData doRecommendMember(@RequestParam Map<String, Object> param) {
		
		ResultData recommendationRd = recommendationService.doMakeRecommendMember(param);
		
		return recommendationRd;
	}
	
	@RequestMapping("usr/recommendation/doModifyRecommendStatusAjax")
	@ResponseBody
	public ResultData doModifyRecommendStatus(@RequestParam Map<String, Object> param) {
		
		ResultData recommendationRd = recommendationService.doModifyRecommendStatus(param);
		
		return recommendationRd;
	}
	
	
	
	@RequestMapping("usr/recommendation/getRecommendationByRecommenderIdAjax")
	@ResponseBody
	public ResultData getRecommendationByRecommenderId(int recommenderId, int recommendeeId) {
		
		ResultData recommendationRd = recommendationService.getRecommendationByRecommenderId(recommenderId, recommendeeId);
		
		return recommendationRd;
	}

}
