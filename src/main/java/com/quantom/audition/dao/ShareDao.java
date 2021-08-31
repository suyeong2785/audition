package com.quantom.audition.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Share;

@Mapper
public interface ShareDao {

	int doShareArtworksAndActingRolesAjax(Map<String, Object> param);

	List<Share> getForPrintRequestedSharesByRequesteeId(@Param("requesteeId") int requesteeId);

	List<Share> getForPrintAcceptedSharesByRequesteeId(@Param("requesteeId") int requesteeId);
	
	void doModifyShareAnswer(Map<String, Object> param);

	Share getShareByRequesterIdAndRequesteeId(Map<String, Object> param);
	
}
