package com.quantom.audition.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Notification {
	private int id; 
	private String regDate; 
	private String updateDate;
	private int relId;
	private String relName;
	private String relTypeCode;
	private int extraId;
	private String extraName;
	private String extraTypeCode;
	private int senderId;
	private int getterId;
	private String checkDate;
	private boolean checkStatus;
	private String alarmDate;
	private boolean alarmStatus;
	private int result;
	private String message;
}

