package com.quantom.audition.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private boolean delStatus;
	private String delDate;
	private boolean authStatus;
	private int authority;
	private int jobId;
	private int careerId;
	private int age;
	private String loginId;
	private String youTubeUrl;
	private String gender;
	private String ISNI_number;

	@JsonIgnore
	private String loginPw;
	private String name;
	private String nickname;
	private String email;
	private String cellphoneNo;

	public boolean isAdmin() {
		if ( authority == 0 ) {
			return true;
		}

		return false;
	}
	
	public boolean isCastingDirector() {
		if (authority == 1 ) {
			return true;
		}

		return false;
	}
}
