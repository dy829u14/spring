package org.green.service;

import org.green.domain.AuthVO;
import org.green.domain.MemberVO;

public interface MemberService {
	public void join(MemberVO mvo, AuthVO avo);
}
