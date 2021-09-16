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

	void writeArtwork(Map<String, Object> param);

	Artwork getForPrintArtworkById(@Param("id") int id);

	void modifyArtwork(Map<String, Object> param);

	void deleteArtwork(@Param("id") int id);

	List<Artwork> getForPrintArtworksByLoginId(int memberId);

	Artwork getArtworkById(@Param("id") int id);

	Artwork getForPrintArtworkForCastingCallModifyById(@Param("id") int id);

}
