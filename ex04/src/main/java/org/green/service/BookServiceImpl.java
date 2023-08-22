package org.green.service;

import java.util.List;

import org.green.domain.BookVO;
import org.green.mapper.BookMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class BookServiceImpl implements BookService{
	@Setter(onMethod_= {@Autowired})
	private BookMapper mapper;
	
	@Override
	public void register(BookVO vo) {
		mapper.insert(vo);
	}

	@Override
	public BookVO get(int bno) {
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BookVO vo) {
		return mapper.update(vo)==1;
	}

	@Override
	public boolean remove(int bno) {
		return mapper.delete(bno)==1;
	}

	@Override
	public List<BookVO> getList() {
		return mapper.getList();
	}
	
}
