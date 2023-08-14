package org.green.service;

import org.green.domain.MemberVO;
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
	private PasswordEncoder pwencoder;

	@Override
	public void register(MemberVO mvo) {
		mvo.setMPw(pwencoder.encode(mvo.getMPw()));
		mapper.insert(mvo);
	}
	
}
