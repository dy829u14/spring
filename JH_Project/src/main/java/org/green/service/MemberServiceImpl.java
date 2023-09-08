package org.green.service;

import org.green.domain.AuthVO;
import org.green.domain.MemberVO;
import org.green.mapper.AuthMapper;
import org.green.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService{
	@Setter(onMethod_= {@Autowired})
	private MemberMapper mapper;
	@Setter(onMethod_= {@Autowired})
	private AuthMapper amapper;
	@Setter(onMethod_= {@Autowired})
	private PasswordEncoder pwencoder;

	@Override
	public void register(MemberVO mvo, AuthVO avo) {
		mvo.setMPw(pwencoder.encode(mvo.getMPw()));
		mapper.insert(mvo);
		amapper.insert(avo);
	}
	
	//아이디 중복체크 mapper 접근
	@Override
	public int idCheck(String id) {
		int cnt = mapper.idCheck(id);
		System.out.println("cnt: " + cnt);
		return cnt;
	}

	@Override
	public MemberVO get(String mid) {
		return mapper.read(mid);
	}
	
	
}
