package com.quantom.audition.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ActorDao {

	void join(Map<String, Object> param);

}
