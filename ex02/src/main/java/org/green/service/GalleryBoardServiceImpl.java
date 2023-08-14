package org.green.service;

import java.util.List;

import org.green.domain.GalleryBoardDTO;
import org.green.mapper.GalleryBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class GalleryBoardServiceImpl implements GalleryBoardService{
	@Setter(onMethod_={@Autowired})
	private GalleryBoardMapper mapper;
	
	@Override
	public void register(GalleryBoardDTO dto) {
		mapper.insert(dto);		
	}

	@Override
	public GalleryBoardDTO get(int gno) {	
		return mapper.read(gno);
	}

	@Override
	public boolean modify(GalleryBoardDTO dto) {		
		return mapper.update(dto) == 1;
	}

	public boolean remove(int gno) {		
		return mapper.delete(gno)==1;
	}

	@Override
	public List<GalleryBoardDTO> getList() {
		return mapper.getList();
	}
	
	
}
