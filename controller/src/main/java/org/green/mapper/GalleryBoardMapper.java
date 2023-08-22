package org.green.mapper;

import java.util.List;
import java.util.Map;
import org.green.domain.Criteria;
import org.green.domain.GalleryBoardVO;

public interface GalleryBoardMapper {
	//게시판 글 리스트
	public List<GalleryBoardVO> getList();
	
	//글쓰기
	public void insert(GalleryBoardVO vo);
	
	//상세보기
	public GalleryBoardVO read(int gno);
	
	//수정하기
	public int update(GalleryBoardVO vo);
	
	//삭제하기
	public int delete(int gno);
	
//	//페이징 사용해서 조회
//	public List<GalleryBoardVO> getListWithPaging(Criteria cri);
//	
//	//전체 데이터 개수
//	public int getTotalCount(Criteria cri);
//	
//	//검색 연습
//	//Map<키:String, 값:Map타입>
//	public List<GalleryBoardVO> searchTest(Map<String, Map<String, String>> map);
}
