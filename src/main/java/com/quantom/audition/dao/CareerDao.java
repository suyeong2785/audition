package com.quantom.audition.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Career;

@Mapper
public interface CareerDao {

	void setCareer(Map<String, Object> param);

	Career getCareerByMember(@Param("id") int id);

	void modifyCareerByMemberIdAndJobId(Map<String, Object> param);

}
