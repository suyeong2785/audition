package com.quantom.audition.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Share {
	private int id;
	private String regDate;
	private String updateDate;
	private int answer;
	private String relTypeCode;
	private String actorId;
	private String targetId;
	
	private Map<String, Object> extra;
}
