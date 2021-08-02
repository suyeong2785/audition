package com.quantom.audition.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Actor;

@Mapper
public interface ActorDao {
	
	void join(Map<String, Object> param);

	List<Actor> getActorListByName(@Param("name") String name);

	Actor getForPrintActorById(int id);

}
