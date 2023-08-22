package org.green.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
public class BoardMapperTests {
	@Setter(onMethod_= {@Autowired})
	private BoardMapper mapper;
	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	//insert테스트
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 제목");
		board.setContent("새로 작성하는 내용");
		board.setWriter("green");
		mapper.insert(board);
		log.info(board);
	}
	//select테스트
	@Test
	public void testRead() {
		BoardVO board = mapper.read(5L);
		log.info(board);
	}
	//delete테스트
	@Test
	public void testDelete() {
		log.info("Delete count : " + mapper.delete(6L));
	}
	//update테스트
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setBno(5L);
		board.setTitle("수정된 제목");
		board.setContent("수정된 내용");
		board.setWriter("aaaa");
		int count = mapper.update(board);
		log.info("count : " + count);
	}
	
	//페이징 레코드 테스트
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setAmount(10);
		cri.setPageNum(4);
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board->log.info(board));
	}
	
	//검색 테스트
	@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("수");
		cri.setType("TC");
		List<BoardVO> list = mapper.getListWithPaging(cri);
		log.info(list);
	}
}
