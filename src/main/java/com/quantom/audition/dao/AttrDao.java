package com.quantom.audition.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Attr;

@Mapper
public interface AttrDao {
	Attr get(@Param("relTypeCode") String relTypeCode, @Param("relId") int relId, @Param("typeCode") String typeCode, @Param("type2Code") String type2Code);

	int remove(@Param("relTypeCode") String relTypeCode, @Param("relId") int relId, @Param("typeCode") String typeCode, @Param("type2Code") String type2Code);

	int setValue(@Param("relTypeCode") String relTypeCode, @Param("relId") int relId, @Param("typeCode") String typeCode, @Param("type2Code") String type2Code, @Param("value") String value, @Param("expireDate") String expireDate);

	String getValue(@Param("relTypeCode") String relTypeCode, @Param("relId") int relId, @Param("typeCode") String typeCode, @Param("type2Code") String type2Code);

	Attr getAttrByTypeCodeAndValue(@Param("typeCode") String typeCode, @Param("value") String value);
	
	Attr getAttrByTypeCode(@Param("typeCode") String typeCode);
	
	void updateAttrByValueAndExpireDate(@Param("typeCode")String typeCode, @Param("value")String value, @Param("expireDate") String expireDate);
	
}
