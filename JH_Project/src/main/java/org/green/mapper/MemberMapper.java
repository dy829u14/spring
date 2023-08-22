package org.green.mapper;

import org.green.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String mid);
	
	public void insert(MemberVO vo);
	
	// 아이디 중복체크
	public int idCheck(String id);
}
