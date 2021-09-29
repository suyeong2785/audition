package com.quantom.audition.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Share;

@Mapper
public interface ShareDao {

	void doShareArtworksAndActingRolesAjax(Map<String, Object> param);

	List<Share> getForPrintRequestedSharesByRequesteeId(@Param("requesteeId") int requesteeId);

	List<Share> getForPrintAcceptedSharesByRequesteeId(@Param("requesteeId") int requesteeId);
	
	void doModifyShareAnswer(Map<String, Object> param);

	List<Share> getShareByRequesterId(@Param("requesterId") int requesterId);

	List<Share> getAccesibleRequesteesByActingRoleId(Map<String, Object> param);

	void modifySharesByRequesterId(@Param("requesterId") int requesterId);

	List<Share> getSharesByRelIdsAndRequesterId(@Param("relIds") List<Integer> relIds,@Param("requesterId") int requesterId);

	List<Integer> getSharesIdsByRequesterId(int requesterId);

	void deleteSharesByrequesterIdAndrelIds(@Param("requesterId") int requesterId,@Param("relIds") List<Integer> relIds);
	
}
