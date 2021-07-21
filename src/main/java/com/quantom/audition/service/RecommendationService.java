package com.quantom.audition.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quantom.audition.dao.RecommendationDao;
import com.quantom.audition.dto.Recommendation;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.util.Util;

@Service
public class RecommendationService {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private RecommendationDao recommendationDao;
	
	public ResultData doMakeRecommendMember(Map<String, Object> param) {
		recommendationDao.doMakeRecommendMember(param);
		
		int recommendationStatus = Util.getAsInt(param.get("recommendationStatus"));
		int recommendeeId = Util.getAsInt(param.get("recommendeeId"));
		
		memberService.doModifyMemberRecommendation( recommendeeId, recommendationStatus);
		
		int id = Util.getAsInt(param.get("id"));
		
		if(id == -1 ){
			return new ResultData("F-1", String.format("추천하지 못하였습니다."));
		}
		
		return new ResultData("S-1", String.format("%d개의 추천을 하였습니다.", id));
	}

	public ResultData getRecommendationByRecommenderId(int recommenderId, int recommendeeId) {
		Recommendation recommendation = recommendationDao.getRecommendationByRecommenderId(recommenderId,recommendeeId);
	
		if(recommendation == null) {
			return new ResultData("F-1", "추천자에 해당하는 추천이 없습니다.");
		}
		
		return new ResultData("S-1", "추천자에 해당하는 추천을 가져왔습니다.","recommendation",recommendation);
	}

	public ResultData doModifyRecommendStatus(Map<String, Object> param) {
		recommendationDao.doModifyRecommendStatus(param);
		
		int recommendationStatus = Util.getAsInt(param.get("recommendationStatus"));
		int recommendeeId = Util.getAsInt(param.get("recommendeeId"));
		
		memberService.doModifyMemberRecommendation(recommendeeId,recommendationStatus);
		
		if(recommendationStatus == 1  ) {
			return new ResultData("S-1", "해당하는 지원자를 추천했습니다.");
		}
		
		return new ResultData("S-2", "해당하는 지원자의 추천을 취소했습니다.");
	}
}
