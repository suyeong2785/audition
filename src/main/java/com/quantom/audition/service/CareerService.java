package com.quantom.audition.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quantom.audition.dao.CareerDao;
import com.quantom.audition.dto.Career;

@Service
public class CareerService {
	@Autowired
	private CareerDao careerDao;

	public void setCareer(Map<String, Object> param) {
		careerDao.setCareer(param);
	}

	public void modifyCareerByMemberIdAndJobId(Map<String, Object> param) {
		careerDao.modifyCareerByMemberIdAndJobId(param);

	}

	public Career getCareerByMember(int memberId, int jobId) {
		return careerDao.getCareerByMember(memberId, jobId);

	}

	public Map<String, String> getDatesAndArtworkOfCareerByMember(int memberId, int jobId) {
		Career career = careerDao.getCareerByMember(memberId, jobId);

		String[] dates = career.getDate().split(",");

		String[] artworks = career.getArtwork().split(",");

		Map<String, String> datesAndArtworkResultMap = new HashMap<>();

		for (int i = 0; i < dates.length; i++) {
			datesAndArtworkResultMap.put(dates[i], artworks[i]);
		}

		return datesAndArtworkResultMap;
	}

}
