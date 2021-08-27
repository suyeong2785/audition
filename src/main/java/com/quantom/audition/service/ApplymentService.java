package com.quantom.audition.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.quantom.audition.config.AppConfig;
import com.quantom.audition.dao.ApplymentDao;
import com.quantom.audition.dao.RecruitmentDao;
import com.quantom.audition.dto.ActingRole;
import com.quantom.audition.dto.Applyment;
import com.quantom.audition.dto.File;
import com.quantom.audition.dto.Member;
import com.quantom.audition.dto.Recruitment;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.util.Util;

@Service
public class ApplymentService {
	@Autowired
	private ApplymentDao applymentDao;
	@Autowired
	private FileService fileService;
	@Autowired
	private ActingRoleService actingRoleService;
	@Autowired
	private AppConfig appConfig;
	@Autowired
	private RecruitmentService recruitmentService;
	@Autowired
	private RecruitmentDao recruitmentDao;

	public Applyment getForPrintApplyment(@RequestParam Map<String, Object> param) {
		Applyment applyment = applymentDao.getForPrintApplyment(param);
		int applymentId = applyment.getId();

		if (applymentId > 0) {
			Map<Integer, Map<Integer, File>> filesMap = fileService.getFileMapKeyRelIdAndFileNo("applyment",
					applymentId, "common", "attachment");

			Map<Integer, File> filesMap2 = filesMap.get(applyment.getId());

			if (filesMap2 != null) {
				applyment.getExtra().put("file__common__attachment", filesMap2);
			}
		}

		Member actor = (Member) param.get("actor");

		// 출력용 부가데이터를 추가한다.
		updateForPrintInfo(actor, applyment);

		return applyment;
	}

	public List<Applyment> getForPrintApplyments(@RequestParam Map<String, Object> param) {
		List<Applyment> applyments = applymentDao.getForPrintApplyments(param);

		List<Integer> applymentIds = applyments.stream().map(applyment -> applyment.getId())
				.collect(Collectors.toList());
		if (applymentIds.size() > 0) {
			Map<Integer, Map<Integer, File>> filesMap = fileService.getFilesMapKeyRelIdAndFileNo("applyment",
					applymentIds, "common", "attachment");

			for (Applyment applyment : applyments) {
				Map<Integer, File> filesMap2 = filesMap.get(applyment.getId());

				if (filesMap2 != null) {
					applyment.getExtra().put("file__common__attachment", filesMap2);
				}
			}
		}

		Member actor = (Member) param.get("actor");

		for (Applyment applyment : applyments) {
			// 출력용 부가데이터를 추가한다.
			updateForPrintInfo(actor, applyment);
		}

		return applyments;
	}
	

	public List<Applyment> getForPrintApplymentsByResult(Map<String, Object> param) {
		List<Applyment> applyments = applymentDao.getForPrintApplymentsByResult(param);

		List<Integer> applymentIds = applyments.stream().map(applyment -> applyment.getId())
				.collect(Collectors.toList());
		if (applymentIds.size() > 0) {
			Map<Integer, Map<Integer, File>> filesMap = fileService.getFilesMapKeyRelIdAndFileNo("applyment",
					applymentIds, "common", "attachment");

			for (Applyment applyment : applyments) {
				Map<Integer, File> filesMap2 = filesMap.get(applyment.getId());

				if (filesMap2 != null) {
					applyment.getExtra().put("file__common__attachment", filesMap2);
				}
			}
		}

		Member actor = (Member) param.get("actor");

		for (Applyment applyment : applyments) {
			// 출력용 부가데이터를 추가한다.
			updateForPrintInfo(actor, applyment);
		}

		return applyments;
	}

	private void updateForPrintInfo(Member actor, Applyment applyment) {
		applyment.getExtra().put("actorCanDelete", actorCanDelete(actor, applyment));
		applyment.getExtra().put("actorCanModify", actorCanModify(actor, applyment));
		applyment.getExtra().put("actorCanToggle", actorCanToggle(actor, applyment));
	}

	// 액터가 해당 댓글을 수정할 수 있는지 알려준다.
	public boolean actorCanModify(Member actor, Applyment applyment) {
		if (actor == null) {
			return false;
		}

		if (applyment == null) {
			return false;
		}

		int passedSeconds = Util.getPassedSecondsFrom(applyment.getRegDate());

		if (passedSeconds > appConfig.getModifyAvailablePeriodSeconds()) {
			return false;
		}

		return actor.getId() == applyment.getMemberId();
	}

	// 액터가 해당 댓글을 수정할 수 있는지 알려준다.
	public boolean actorCanToggle(Member actor, Applyment applyment) {
		if (actor == null) {
			return false;
		}

		if (applyment == null) {
			return false;
		}

		return recruitmentService.actorCanToggle(actor, applyment);
	}

	// 액터가 해당 댓글을 삭제할 수 있는지 알려준다.
	public boolean actorCanDelete(Member actor, Applyment applyment) {
		return actorCanModify(actor, applyment);
	}

	public int writeApplyment(Map<String, Object> param) {
		applymentDao.writeApplyment(param);
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

	public void deleteApplyment(int id) {
		applymentDao.deleteApplyment(id);
		fileService.deleteFiles("applyment", id);
	}

	public Applyment getForPrintApplymentById(int id) {
		Applyment applyment = applymentDao.getForPrintApplymentById(id);

		Map<Integer, File> filesMap = fileService.getFilesMapKeyFileNo("applyment", id, "common", "attachment");
		Util.putExtraVal(applyment, "file__common__attachment", filesMap);

		return applyment;
	}

	public ResultData modfiyApplyment(Map<String, Object> param) {
		applymentDao.modifyApplyment(param);
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

		Applyment applyment = getForPrintApplymentById(id);

		param.put("file__common__attachment", applyment.getExtra().get("file__common__attachment"));

		return new ResultData("S-1", String.format("%d번 신청을 수정하였습니다.", Util.getAsInt(param.get("id"))), param);
	}

	public void deleteApplymentsByRelId(String relTypeCode, int relId) {
		List<Applyment> applyments = getApplymentsByRelId(relTypeCode, relId);

		for (Applyment applyment : applyments) {
			deleteApplyment(applyment.getId());
		}
	}

	private List<Applyment> getApplymentsByRelId(String relTypeCode, int relId) {
		return applymentDao.getApplymentsByRelId(relTypeCode, relId);
	}

	public ResultData checkActorCanWriteApplyment(Member actor, String relTypeCode, int relId) {
		ActingRole actingRole = actingRoleService.getActingRoleById(relId);

		if (actingRole.isCompleteStatus()) {
			return new ResultData("F-2", "마감되었습니다.");
		}

		Applyment applyment = applymentDao.getApplymentByRelIdAndMemberId(relTypeCode, relId, actor.getId());

		if (applyment != null) {
			return new ResultData("F-1", "이미 신청하셨습니다. 기존 신청내용을 수정해주세요.");
		}

		return new ResultData("S-1", "가능합니다.");
	}

	public ResultData changeHideStatus(int id, boolean hideStatus) {
		applymentDao.changeHideStatus(id, hideStatus);

		return new ResultData("S-1", "변경되었습니다.");
	}

	public void changeApplymentResult(int id, int result) {
		// id(applyment.id), 2(불합격)
		applymentDao.changeApplymentResult(id, result);
		fileService.deleteFiles("applyment", id);
	}

	public Applyment getForPrintApplymentRelatedToResult(Map<String, Object> param) {
		Applyment applyment = applymentDao.getForPrintApplymentRelatedToResult(param);
		int applymentId = applyment.getId();

		if (applymentId > 0) {
			Map<Integer, Map<Integer, File>> filesMap = fileService.getFileMapKeyRelIdAndFileNo("applyment",
					applymentId, "common", "attachment");

			Map<Integer, File> filesMap2 = filesMap.get(applyment.getId());

			if (filesMap2 != null) {
				applyment.getExtra().put("file__common__attachment", filesMap2);
			}
		}

		Member actor = (Member) param.get("actor");

		// 출력용 부가데이터를 추가한다.
		updateForPrintInfo(actor, applyment);

		return applyment;
	}

	public List<Applyment> getApplymenResultInfoByMemberId(int MemberId) {
		return applymentDao.getApplymenResultInfoByMemberId(MemberId);
	}

	public List<Applyment> getForPrintSharedApplymentsByRequesterId(int requesteeId, int requesterId) {
		System.out.println("requesterId : " + requesterId);
		List<Recruitment> recruitments = recruitmentDao.getRecruitmentsByRequesterId(requesterId);
		
		List<Applyment> sharedApplyments = null;
		
		for(Recruitment recruitment: recruitments) {
			sharedApplyments = applymentDao.getApplymentsByRelId("recruitment", recruitment.getId());
		}
		
		return sharedApplyments;
	}

	public List<Applyment> getForPrintApplymentsByRelIdAndRelTypeCode(Map<String, Object> param) {
		return applymentDao.getForPrintApplymentsByRelIdAndRelTypeCode(param);
	}


}
