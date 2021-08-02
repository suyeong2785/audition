package com.quantom.audition.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Actor {
	private int id;
	private String regDate;
	private String updateDate;
	private String name;
	private String nickname;
	private String gender;
	private int age;
	private int height;
	private int weight;
	private int careerId;
	private String email;
	private String phone;
	private String youTubeUrl;
	
	private Map<String, Object> extra;
}
