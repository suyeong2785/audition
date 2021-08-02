package com.quantom.audition.service;

import java.util.HashMap;
import java.util.LinkedHashMap;
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

	public Career getCareerByMember(int id) {
		return careerDao.getCareerByMember(id);

	}

	public Map<String, String> getDatesAndArtworkOfCareerByMember(int id) {
		Career career = careerDao.getCareerByMember(id);

		String[] dates = career.getDate().split("_");

		String[] artworks = career.getArtwork().split("_");

		Map<String, String> datesAndArtworkResultMap = new LinkedHashMap<>();

		for (int i = 0; i < dates.length; i++) {
			datesAndArtworkResultMap.put(dates[i], artworks[i]);
			System.out.println("datesAndArtworkResultMap : " + datesAndArtworkResultMap.get("" + dates[i]));
		}

		return datesAndArtworkResultMap;
	}

}
