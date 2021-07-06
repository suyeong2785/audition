package com.quantom.audition.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.ActingRole;
import com.quantom.audition.dto.Artwork;

@Mapper
public interface ActingRoleDao {

	List<ActingRole> getRoles();

	List<Artwork> getArtworks();

	void write(Map<String, Object> param);

	ActingRole getForPrintActingRoleById(@Param("id") int id);

	void modify(Map<String, Object> param);
	
	void delete(@Param("id") int id);

	void writeArtwork(Map<String, Object> param);

	Artwork getForPrintArtworkById(@Param("id") int id);

	void modifyArtwork(Map<String, Object> param);

	void deleteArtwork(@Param("id") int id);
}
