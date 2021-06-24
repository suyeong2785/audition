package com.quantom.audition.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quantom.audition.dao.MemberDao;
import com.quantom.audition.dto.Member;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}
}
