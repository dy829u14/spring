package org.green.service;

import java.util.List;

import org.green.domain.BookVO;


public interface BookService {
	//등록 insert
	public void register(BookVO vo);
	//게시글 1개 조회 select
	public BookVO get(int bno);
	//수정하기
	public boolean modify(BookVO vo);
	//삭제하기
	public boolean remove(int bno);
	//게시글 목록 조회
	public List<BookVO> getList();
}
