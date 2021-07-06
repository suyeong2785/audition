package com.quantom.audition.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Job;
import com.quantom.audition.dto.Recruitment;

@Mapper
public interface RecruitmentDao {
	List<Recruitment> getForPrintRecruitments();

	Recruitment getForPrintRecruitmentById(@Param("id") int id);
	
	Recruitment getRecruitmentById(@Param("id") int id);

	void write(Map<String, Object> param);

	void modify(Map<String, Object> param);

	Job getJobByCode(@Param("code") String code);

	void delete(@Param("id") int id);

	void setComplete(@Param("id") int id);
}
