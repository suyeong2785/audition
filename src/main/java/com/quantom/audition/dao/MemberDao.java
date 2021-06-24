package com.quantom.audition.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Member;

@Mapper
public interface MemberDao {
	Member getMemberById(@Param("id") int id);
}
