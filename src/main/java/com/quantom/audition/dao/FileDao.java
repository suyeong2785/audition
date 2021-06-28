package com.quantom.audition.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.File;



@Mapper
public interface FileDao {

	void save(Map<String, Object> param);

	void changeRelId(@Param("id") int id, @Param("relId") int relId);

	List<File> getFiles(@Param("relTypeCode") String relTypeCode, @Param("relIds") List<Integer> relIds,
			@Param("typeCode") String typeCode, @Param("type2Code") String type2Code, @Param("fileNo") int fileNo);

	File getFileById(@Param("id") int id);

	void deleteFiles(@Param("relTypeCode") String relTypeCode, @Param("relId") int relId);
}