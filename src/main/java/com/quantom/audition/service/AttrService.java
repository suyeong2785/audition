package com.quantom.audition.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quantom.audition.dao.AttrDao;
import com.quantom.audition.dto.Attr;

@Service
public class AttrService {
	@Autowired
	private AttrDao attrDao;

	public Attr get(String name) {
		String[] nameBits = name.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];

		return get(relTypeCode, relId, typeCode, type2Code);
	}

	public Attr get(String relTypeCode, int relId, String typeCode, String type2Code) {
		return attrDao.get(relTypeCode, relId, typeCode, type2Code);
	}

	public int setValue(String name, String value, String expireDate) {
		String[] nameBits = name.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];

		return setValue(relTypeCode, relId, typeCode, type2Code, value, expireDate);
	}

	public String getValue(String name) {
		String[] nameBits = name.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];

		return getValue(relTypeCode, relId, typeCode, type2Code);
	}

	public String getValue(String relTypeCode, int relId, String typeCode, String type2Code) {
		String value = attrDao.getValue(relTypeCode, relId, typeCode, type2Code);
		
		if ( value == null ) {
			return "";
		}
		
		return value;
	}

	public int remove(String name) {
		String[] nameBits = name.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];

		return remove(relTypeCode, relId, typeCode, type2Code);
	}

	public int remove(String relTypeCode, int relId, String typeCode, String type2Code) {
		return attrDao.remove(relTypeCode, relId, typeCode, type2Code);
	}

	
	/**
	 * 값을 설정하는 메소드
	 * 
	 * @param relTypeCode
	 * @param relId
	 * @param typeCode
	 * @param type2Code
	 * @param value
	 * @param expireDate
	 * @return
	 */
	public int setValue(String relTypeCode, int relId, String typeCode, String type2Code, String value, String expireDate) {
		
		attrDao.setValue(relTypeCode, relId, typeCode, type2Code, value, expireDate);
		Attr attr = get(relTypeCode, relId, typeCode, type2Code);

		if (attr != null) {
			return attr.getId();
		}

		return -1;
	}

	/**
	 * 유효한 코드인지 검사하는 로직
	 * 
	 * @param email
	 * @param code
	 * @return
	 */
	public boolean isValidCode(String email, String code) {
		
		// 인증 정보를 조회합니다.
		Attr findAttr = attrDao.getAttrByTypeCodeAndValue(email, code);
		
		if ( findAttr != null ) {
			// 정보가 조회되었을 때에는 true를 리턴합니다.
			return true;
		} else {
			// 나머지 경우는 false를 리턴합니다.
			return false;
		}
	
	}

}