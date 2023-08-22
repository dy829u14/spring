package org.green.mapper;

import java.util.List;

import org.green.domain.MemberVO;

public interface MemberMapper {
	public void insert(MemberVO vo);
	
	public List<MemberVO> getList();
}
