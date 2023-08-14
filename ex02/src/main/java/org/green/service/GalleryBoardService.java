package org.green.service;

import java.util.List;

import org.green.domain.GalleryBoardDTO;

public interface GalleryBoardService {
	//등록 insert
	public void register(GalleryBoardDTO dto);
	//게시글 1개 조회 select
	public GalleryBoardDTO get(int gno);
	//수정하기
	public boolean modify(GalleryBoardDTO dto);
	//삭제하기
	public boolean remove(int bno);
	//게시글 목록 조회
	public List<GalleryBoardDTO> getList();
}
