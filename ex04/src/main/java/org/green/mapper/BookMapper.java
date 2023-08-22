package org.green.mapper;

import java.util.List;

import org.green.domain.BookVO;

public interface BookMapper {
	public void insert(BookVO vo);
	
	public List<BookVO> getList();
	
	public BookVO read(int bno);

	public int delete(int bno);
	
	public int update(BookVO vo);
}
