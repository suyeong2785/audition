package com.quantom.audition.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ShareDao {

	int doShareApplyments(Map<String, Object> param);

}
