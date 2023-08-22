package org.green.service;

import java.util.List;

import org.green.domain.MemberVO;

public interface MemberService {
	public void join(MemberVO vo);
	
	public List<MemberVO> getList();
}
