package org.green.mapper;

import java.util.List;

import org.green.domain.GalleryBoardDTO;

public interface GalleryBoardMapper {
	//create --> insert
	public void insert(GalleryBoardDTO dto);
	
	//read --> select처리
	public GalleryBoardDTO read(int gno);
	
	//delete --> delete처리
	public int delete(int gno);
	
	//update --> update처리
	public int update(GalleryBoardDTO dto);
	
	
	public List<GalleryBoardDTO> getList();
}
