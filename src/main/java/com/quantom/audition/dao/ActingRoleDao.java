package com.quantom.audition.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.ActingRole;

@Mapper
public interface ActingRoleDao {

	List<ActingRole> getRoles();

	List<ActingRole> getActingRolesForPrintList(Map<String, Object> param);
	
	List<ActingRole> getActingRolesForPrintListByArtworkId(Map<String, Object> param);

	int getActingRolesCountByArtworkId(Map<String, Object> param);
	
	void write(Map<String, Object> param);
	
	ActingRole getActingRoleById(@Param("id") int id);

	ActingRole getForPrintActingRoleById(@Param("id") int id);
	
	ActingRole getActingRoleForPrintDetailById(@Param("id") int id);

	void modify(Map<String, Object> param);
	
	void delete(@Param("id") int id);

	ActingRole getActingRoleByArtworkIdAndNameAndAgeAndGenderAjax(Map<String, Object> param);

	List<ActingRole> checkActingRoleAvailableByArtworkIdAndNamesAndAgesAndGendersAjax(@Param("names") List<String> names,@Param("artworkId") String artworkId);

	List<ActingRole> getActingRolesForPrintAuditionsByArtworkId(@Param("artworkId") int artworkId);

	void changeRelId(@Param("id") int id, @Param("artworkId") int artworkId);

	List<ActingRole> getActingRolesForPrintCastingCallModifyByArtworkId(@Param("artworkId") int artworkId);

	void deleteActingRolesByArtworkId(@Param("artworkId") int artworkId);

	List<Integer> getActingRoleIdsByArtworkId(@Param("artworkId") int artworkId);

}
