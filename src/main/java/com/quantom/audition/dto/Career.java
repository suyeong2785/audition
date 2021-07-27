package com.quantom.audition.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Career {

	private int id;
	private String regDate;
	private String updateDate;
	private String delDate;
	private int delStatus;
	private int jobId;
	private String date;
	private int memberId;
	private String artwork;
	
	private Map<String,Object> extra;
}
