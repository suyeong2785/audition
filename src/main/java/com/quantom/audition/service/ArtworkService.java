package com.quantom.audition.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quantom.audition.dao.ArtworkDao;
import com.quantom.audition.dto.Artwork;
import com.quantom.audition.util.Util;

@Service
public class ArtworkService {
	@Autowired
	private ArtworkDao artworkDao;

	@Autowired
	private ActingRoleService actingRoleService;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private ShareService shareService;
	
	@Autowired
	private NotificationService notificationService;

	public int writeArtwork(Map<String, Object> param) {
		artworkDao.writeArtwork(param);
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
		
		String actingRoleIdsStr = (String) param.get("actingRoleIdsStr");
		
		if (actingRoleIdsStr != null && actingRoleIdsStr.length() > 0) {
			List<Integer> actingRoleIds = Arrays.asList(actingRoleIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim()))
					.collect(Collectors.toList());

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int actingRoleId : actingRoleIds) {
				actingRoleService.changeRelId(actingRoleId, id);
			}
		}

		return id;
	}
	
	public List<Artwork> getForPrintArtworks() {
		return artworkDao.getForPrintArtworks();
	}
	
	public List<Artwork> getArtworks() {
		return artworkDao.getArtworks();
	}
	
	public List<Artwork> getArtworksForArtworkListPageByMemberId(int memberId) {
		return artworkDao.getArtworksForArtworkListPageByMemberId(memberId);
	}

	public Artwork getForPrintArtworkById(int id) {
		return artworkDao.getForPrintArtworkById(id);
	}

	public void modifyArtwork(Map<String, Object> param) {
		artworkDao.modifyArtwork(param);
		
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
		
		String actingRoleIdsStr = (String) param.get("actingRoleIdsStr");
		
		if (actingRoleIdsStr != null && actingRoleIdsStr.length() > 0) {
			List<Integer> actingRoleIds = Arrays.asList(actingRoleIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim()))
					.collect(Collectors.toList());

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int actingRoleId : actingRoleIds) {
				actingRoleService.changeRelId(actingRoleId, id);
			}
		}

	}

	public void deleteArtwork(Map<String,Object> param) {
		int id = Util.getAsInt(param.get("id"));
		int requesterId = Util.getAsInt(param.get("senderId"));
		
		artworkDao.deleteArtwork(id);
		fileService.deleteFilesByRelId("artwork", id);
		actingRoleService.deleteActingRolesByArtworkId(id,requesterId);
		
		Util.changeMapKey(param, "id","relId");
		notificationService.insertNotificationMessage(param);
	}

	public List<Artwork> getForPrintArtworksByLoginId(int memberId) {
		return artworkDao.getForPrintArtworksByLoginId(memberId);
	}

	public Artwork getArtworkById(int id) {
		return artworkDao.getArtworkById(id);
	}

	public Artwork getForPrintArtworkForCastingCallModifyById(int id) {
		return artworkDao.getForPrintArtworkForCastingCallModifyById(id);
	}

}
