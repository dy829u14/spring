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
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	@Setter(onMethod_= {@Autowired})
	private PasswordEncoder pwencoder;
	@Setter(onMethod_= {@Autowired})
	private MemberMapper mapper;
	@Setter(onMethod_= {@Autowired})
	private AuthMapper amapper;
	@Override
	public void join(MemberVO mvo, AuthVO avo) {
		mvo.setUserpw(pwencoder.encode(mvo.getUserpw()));
		mapper.insert(mvo);
		amapper.insert(avo);
	}
	
}
