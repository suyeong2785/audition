package com.quantom.audition.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Applyment;

@Mapper
public interface ApplymentDao {
	List<Applyment> getForPrintApplyments(Map<String, Object> param);

	List<Applyment> getForPrintApplymentsByResult(Map<String, Object> param);

	Applyment getForPrintApplyment(Map<String, Object> param);

	Applyment getForPrintApplymentRelatedToResult(Map<String, Object> param);

	void writeApplyment(Map<String, Object> param);

	void deleteApplyment(@Param("id") int id);

	Applyment getForPrintApplymentById(@Param("id") int id);

	void modifyApplyment(Map<String, Object> param);

	List<Applyment> getApplymentsByRelId(@Param("relTypeCode") String relTypeCode, @Param("relId") int relId);

	Applyment getApplymentByRelIdAndMemberId(@Param("relTypeCode") String relTypeCode, @Param("relId") int relId, @Param("memberId") int memberId);

	void changeHideStatus(@Param("id") int id, @Param("hideStatus") boolean hideStatus);

	void changeApplymentResult(@Param("id") int id, @Param("result") int result);

	List<Applyment> getApplymenResultInfoByMemberId(int memberId);

	List<Applyment> getForPrintApplymentsByRelIdAndRelTypeCode(Map<String, Object> param);
}
