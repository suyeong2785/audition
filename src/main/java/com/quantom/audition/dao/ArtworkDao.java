package com.quantom.audition.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.ActingRole;
import com.quantom.audition.dto.Artwork;
import com.quantom.audition.dto.Recruitment;

@Mapper
public interface ArtworkDao {

	List<Artwork> getArtworks();
	
	List<Artwork> getForPrintArtworks();
	
	List<Artwork> getForPrintArtworksByLoginId(@Param("memberId") int memberId);
	
	List<Artwork> getArtworksForArtworkListPageByMemberId(@Param("memberId") int memberId);
	
	Artwork getArtworkById(@Param("id") int id);

	Artwork getForPrintArtworkForCastingCallModifyById(@Param("id") int id);
	
	Artwork getForPrintArtworkById(@Param("id") int id);

	void writeArtwork(Map<String, Object> param);

	void modifyArtwork(Map<String, Object> param);

	void deleteArtwork(@Param("id") int id);

}
