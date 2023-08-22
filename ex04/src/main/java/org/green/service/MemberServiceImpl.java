package org.green.service;

import java.util.List;

import org.green.domain.MemberVO;
import org.green.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService{
	@Setter(onMethod_= {@Autowired})
	private MemberMapper mapper;

	@Override
	public void join(MemberVO vo) {
		mapper.insert(vo);		
	}

	@Override
	public List<MemberVO> getList() {		
		return mapper.getList();
	}
	
}
