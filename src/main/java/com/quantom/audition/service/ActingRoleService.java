package com.quantom.audition.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quantom.audition.dao.ActingRoleDao;
import com.quantom.audition.dto.ActingRole;
import com.quantom.audition.dto.Member;
import com.quantom.audition.dto.Share;
import com.quantom.audition.util.Util;

@Service
public class ActingRoleService {
	@Autowired
	private ActingRoleDao actingRoleDao;

	@Autowired
	private FileService fileService;
	
	@Autowired
	private ShareService shareService;
	
	@Autowired
	private ApplymentService applymentService;

	public List<ActingRole> getRoles() {
		return actingRoleDao.getRoles();
	}

	public List<ActingRole> getForPrintRoles() {
		return actingRoleDao.getRoles();
	}

	public List<ActingRole> getActingRolesForPrintList(Map<String, Object> param) {
		return actingRoleDao.getActingRolesForPrintList(param);
	}

	public List<ActingRole> getActingRolesForPrintListByArtworkId(Map<String, Object> param) {
		return actingRoleDao.getActingRolesForPrintListByArtworkId(param);
	}

	public int write(Map<String, Object> param) {
		actingRoleDao.write(param);
		int id = Util.getAsInt(param.get("id"));

		String fileIdsStr = (String) param.get("fileIdsStr");

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim()))
					.collect(Collectors.toList());

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int fileId : fileIds) {
				fileService.changeRelId(fileId, id);
			}
		}

		return id;
	}

	public ActingRole getActingRoleById(int id) {
		return actingRoleDao.getActingRoleById(id);
	}

	public ActingRole getForPrintActingRoleById(Member loginedMember, int id) {
		return actingRoleDao.getForPrintActingRoleById(id);
	}

	public ActingRole getActingRoleForPrintDetailById(int id) {
		return actingRoleDao.getActingRoleForPrintDetailById(id);
	}

	public int modify(Map<String, Object> param) {
		actingRoleDao.modify(param);
		
		int id = Util.getAsInt(param.get("id"));

		String fileIdsStr = (String) param.get("fileIdsStr");

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim()))
					.collect(Collectors.toList());

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int fileId : fileIds) {
				fileService.changeRelId(fileId, id);
			}
		}

		return id;
	}

	public void delete(int id) {
		actingRoleDao.delete(id);
		applymentService.deleteApplymentByRelIdAndRelTypeCode("actingRole",id);
		
		fileService.deleteFilesByRelId("actingRole", id);
	}

	public int getActingRolesCountByArtworkId(Map<String, Object> param) {
		return actingRoleDao.getActingRolesCountByArtworkId(param);
	}

	public ActingRole getActingRoleByArtworkIdAndNameAndAgeAndGenderAjax(Map<String, Object> param) {
		return actingRoleDao.getActingRoleByArtworkIdAndNameAndAgeAndGenderAjax(param);
	}

	public List<ActingRole> checkActingRoleAvailableByArtworkIdAndNamesAndAgesAndGendersAjax(List<String> names,String artworkId) {
		return actingRoleDao.checkActingRoleAvailableByArtworkIdAndNamesAndAgesAndGendersAjax(names,artworkId);
	}

	public List<ActingRole> getActingRolesForPrintAuditionsByArtworkId(int artworkId) {
		return actingRoleDao.getActingRolesForPrintAuditionsByArtworkId(artworkId);
	}
	
	public List<ActingRole> getActingRolesForPrintCastingCallModifyByArtworkId(int artworkId) {
		return actingRoleDao.getActingRolesForPrintCastingCallModifyByArtworkId(artworkId);
	}

	public void changeRelId(int id, int artworkId) {
		actingRoleDao.changeRelId(id, artworkId);
	}

	public void deleteActingRolesByArtworkId(Map<String,Object> param) {
		int artworkId = Util.getAsInt(param.get("id"));
		int requesterId = Util.getAsInt(param.get("senderId"));
		String relTypeCode = Util.getAsStr(param.get("relTypeCode"));
		String extraTypeCode = Util.getAsStr(param.get("extraTypeCode"));
		String artworkName = Util.getAsStr(param.get("extraName"));
		String message = Util.getAsStr(param.get("message"));
		
		if(actingRoleDao.getActingRoleIdsByArtworkId(artworkId).isEmpty() == false) {
			List<Integer> actingRolesIds = actingRoleDao.getActingRoleIdsByArtworkId(artworkId);
			
			fileService.deleteFilesByRelIds("actingRole", actingRolesIds);
			shareService.deleteSharesByrequesterIdAndrelIds(requesterId,actingRolesIds);
			applymentService.deleteApplymentsByRelIdsAndRelTypeCode(requesterId, relTypeCode, actingRolesIds, artworkId, artworkName, extraTypeCode, message);
		}
		
		actingRoleDao.deleteActingRolesByArtworkId(artworkId);
	}



}
