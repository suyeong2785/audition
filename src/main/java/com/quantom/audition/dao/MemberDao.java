package com.quantom.audition.dao;

import java.util.List;
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

	void modify(Map<String, Object> param);

	Member getMemberByNameAndEmail(@Param("name") String name, @Param("email") String email);

	List<Member> getMembersByLoginId(@Param("loginId") String loginId);

	List<Member> getCastingDirectorsByLoginId(Map<String, Object> param);

	void doModifyMemberRecommendation(@Param("id") int id, @Param("recommendationStatus") int recommendationStatus);

}
