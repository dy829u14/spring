package org.green.service;

import java.util.List;

import org.green.domain.Criteria;
import org.green.domain.GalleryBoardVO;

public interface GalleryBoardService {
	//등록
	public void register(GalleryBoardVO gboard);
	//게시글 상세조회
	public GalleryBoardVO get(int gno);
	//수정
	public boolean modify(GalleryBoardVO gboard);
	//삭제
	public boolean remove(int gno);
	//게시글 전체 조회
	public List<GalleryBoardVO> getList();
	//게시글 총 갯수
}
