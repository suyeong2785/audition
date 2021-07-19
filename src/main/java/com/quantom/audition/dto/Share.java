package com.quantom.audition.dto;

import java.util.Map;

import com.fasterxml.jackson.annotation.JsonProperty;

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
	private String delDate;
	private int delStatus;
	private int answer;
	private String relTypeCode;
	private int requesterId;
	private int requesteeId;
	
	private Map<String, Object> extra;
	
	@JsonProperty("forPrintRequestedShare")
	public String getForPrintRequestedShare() {
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("<span style='font-weight:bold;'>" + extra.get("requesterName") + "</span>");
		sb.append( "<span>님으로 부터 지원자 공유요청이 왔습니다.</span>");
		
		return sb.toString();
	}
}
