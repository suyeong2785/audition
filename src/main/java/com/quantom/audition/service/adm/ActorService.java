package com.quantom.audition.service.adm;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quantom.audition.dao.ActorDao;
import com.quantom.audition.dto.Actor;
import com.quantom.audition.service.CareerService;
import com.quantom.audition.service.FileService;
import com.quantom.audition.util.Util;

@Service
public class ActorService {
	@Autowired
	private ActorDao actorDao;

	@Autowired
	private FileService fileService;

	public void join(Map<String, Object> param) {
		
		actorDao.join(param);

		int relId = Util.getAsInt(param.get("id"));

		String fileIdsStr = (String) param.get("fileIdsStr");

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim()))
					.collect(Collectors.toList());

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int fileId : fileIds) {
				fileService.changeRelId(fileId, relId);
			}
		}

	}

	public List<Actor> getActorListByName(String name) {
		return actorDao.getActorListByName(name);
	}

	public Actor getForPrintActorById(int id) {
		return actorDao.getForPrintActorById(id);
	}

}
