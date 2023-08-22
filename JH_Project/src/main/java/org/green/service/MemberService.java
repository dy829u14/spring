package org.green.service;

import org.green.domain.AuthVO;
import org.green.domain.MemberVO;

public interface MemberService {
	public void register(MemberVO mvo, AuthVO avo);
	
	// 아이디 중복체크
	public int idCheck(String id);
}
