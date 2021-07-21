package com.quantom.audition.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Recommendation;

@Mapper
public interface RecommendationDao {

	void doMakeRecommendMember(Map<String, Object> param);

	Recommendation getRecommendationByRecommenderId(@Param("recommenderId") int recommenderId, @Param("recommendeeId") int recommendeeId);

	void doModifyRecommendStatus(Map<String, Object> param);

}
