package com.quantom.audition.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Recommendation {

	private int id;
	private String regDate;
	private String updateDate;
	private String relTypeCode;
	private int relId;
	private int recommenderId;
	private int recommendeeId;
	private int recommendationStatus;
	
	private Map<String, Object> extra;
}
