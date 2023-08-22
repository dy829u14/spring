package org.green.service;

import org.green.domain.BoardVO;
import org.green.domain.Criteria;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	@Setter(onMethod_= {@Autowired})
	private BoardService service;
	
	//등록
	@Test
	public void testRegistrt() {
		BoardVO board = new BoardVO();
		board.setTitle("서비스에서 작성하는 제목");
		board.setContent("서비스에서 작성하는 내용");
		board.setWriter("blue");
		service.register(board);
		log.info("생성");
	}
	//목록리스트
	@Test
	public void testGetList() {
		service.getList(new Criteria(2,10)).forEach(board->log.info(board));
	}
	//조회
	@Test
	public void testGet() {
		log.info(service.get(7L));
	}
	//삭제
	@Test
	public void testDelete() {
		log.info(service.remove(2L));
	}
	//수정
	@Test
	public void testUpdate() {
		BoardVO board = service.get(1L);
		if(board==null) {return;}
		board.setTitle("제목수정");
		board.setContent(board.getContent());
		board.setWriter(board.getWriter());
		log.info(service.modify(board));
	}
}
