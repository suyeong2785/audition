package com.quantom.audition.service;

import static org.assertj.core.api.Assertions.assertThat;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.quantom.audition.dto.ResultData;

@SpringBootTest
public class MemberServiceTest {
	
	@Autowired MemberService memberService;
	
	@Test
	public void verifyCodeTest() {
		
		// given 이메일이 주어졌을 때
		String testEmail = "archaco124@gmail.com";
		
		// when 이메일 인증을 실행하였을 때
		ResultData verifyCode = memberService.verifyCode(testEmail);
		
		// then 증명
		assertThat(verifyCode.isSuccess()).isEqualTo(true);
		
	}
	
	
	@Test
	public void checkVerifyCode() {
		
		// given 인증코드와 이메일이 주어졌을 때
		String verifyCode = "dj20hc";
		String email = "archaco124@gmail.com";
		
		// when 인증 코드 일치여부 검사를 한다면
		ResultData checkCode = memberService.checkCode(email, verifyCode);
		
		// then 검증
		Assertions.assertThat(checkCode.isSuccess()).isEqualTo(true);
		
	}
	
	
	
}


