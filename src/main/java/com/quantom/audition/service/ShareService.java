package com.quantom.audition.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.quantom.audition.dao.ShareDao;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.dto.Share;

@Service
public class ShareService {
	@Autowired
	private ShareDao shareDao;
	
	public ResultData doShareArtworksAndActingRolesAjax(@RequestParam Map<String, Object> param) {
		shareDao.doShareArtworksAndActingRolesAjax(param);
		String targetName = (String)param.get("name");
		List<Integer> relIds = (List<Integer>)param.get("relIds");
		
		return new ResultData("S-1",String.format("%s와 지원자공유 관계를 생성했습니다.", targetName),"relIds",relIds);
	}
	
	public List<Share> getForPrintRequestedSharesByRequesteeId(int requesteeId) {
		return shareDao.getForPrintRequestedSharesByRequesteeId(requesteeId);
	}
	
	public List<Share> getForPrintAcceptedSharesByRequesteeId(int requesteeId) {
		return shareDao.getForPrintAcceptedSharesByRequesteeId(requesteeId);
	}

	public void doModifyShareAnswer(Map<String, Object> param) {
		shareDao.doModifyShareAnswer(param);
	}

	public List<Share> getShareByRequesterId(int requesterId) {
		return shareDao.getShareByRequesterId(requesterId);
	}

	public List<Share> getAccesibleRequesteesByActingRoleId(Map<String, Object> param) {
		return shareDao.getAccesibleRequesteesByActingRoleId(param);
	}

	public void modifySharesByRequesterId(int requesterId) {
		shareDao.modifySharesByRequesterId(requesterId);
	}

	public List<Share> getSharesByRelIdsAndRequesterId(List<Integer> relIds, int requesterId) {
		return shareDao.getSharesByRelIdsAndRequesterId(relIds,requesterId);
	}

	public List<Integer> getSharesIdsByRequesterId(int requesterId) {
		return shareDao.getSharesIdsByRequesterId(requesterId);
	}

	public void deleteSharesByrequesterIdAndrelIds(int requesterId, List<Integer> relIds) {
		shareDao.deleteSharesByrequesterIdAndrelIds(requesterId, relIds);
	}
}
