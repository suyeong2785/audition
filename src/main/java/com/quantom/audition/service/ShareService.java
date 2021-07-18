package com.quantom.audition.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.quantom.audition.dao.ShareDao;
import com.quantom.audition.dto.ResultData;

@Service
public class ShareService {
	@Autowired
	private ShareDao shareDao;
	
	public ResultData doShareApplyments(@RequestParam Map<String, Object> param) {
		shareDao.doShareApplyments(param);
		String targetName = (String)param.get("name");
		
		return new ResultData("S-1",String.format("%s와 지원자공유 관계를 생성했습니다.", targetName));
	}
}
