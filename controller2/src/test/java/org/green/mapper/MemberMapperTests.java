package org.green.mapper;

import org.green.domain.MemberVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class MemberMapperTests {
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper;
	@Test
	public void testRead() {
		MemberVO mvo = mapper.read("admin43");
		log.info(mvo);
		mvo.getAuthList().forEach(authVO->log.info(authVO));
	}
}
