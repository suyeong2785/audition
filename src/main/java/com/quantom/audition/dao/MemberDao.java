package com.quantom.audition.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Member;

@Mapper
public interface MemberDao {
	
	Member getMemberById(@Param("id") int id);
	
	void join(Map<String, Object> param);

	int getLoginIdDupCount(@Param("loginId") String loginId);
	
	Member getMemberByLoginId(@Param("loginId") String loginId);
}
