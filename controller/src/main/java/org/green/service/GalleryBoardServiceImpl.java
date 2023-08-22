package org.green.service;

import java.util.List;

import org.green.domain.Criteria;
import org.green.domain.GalleryBoardVO;
import org.green.mapper.GalleryBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
public class GalleryBoardServiceImpl implements GalleryBoardService {
	@Setter(onMethod_= {@Autowired})
	private GalleryBoardMapper mapper;
	
	@Override
	public void register(GalleryBoardVO gboard) {
		mapper.insert(gboard);
	}

	@Override
	public GalleryBoardVO get(int gno) {
		return mapper.read(gno);
	}

	@Override
	public boolean modify(GalleryBoardVO gboard) {
		
		return mapper.update(gboard) == 1;
	}

	@Override
	public boolean remove(int gno) {
		// TODO Auto-generated method stub
		return mapper.delete(gno) == 1;
	}

	@Override
	public List<GalleryBoardVO> getList() {
		// TODO Auto-generated method stub
		List<GalleryBoardVO> galleryList = mapper.getList();
		return galleryList;
	}

	
}
