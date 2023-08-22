package org.green.mapper;

import java.util.List;
import java.util.Map;

import org.green.domain.Criteria;
import org.green.domain.SellVO;

public interface SellMapper {
	//create --> insert처리
	public void insert(SellVO vo);
	
	//read --> select처리
	public SellVO read(Long sno);
	
	//delete --> delete처리
	public int delete(Long sno);
	
	//update --> update처리
	public int update(SellVO board);
	
	//insert메소드2 등록된 번호 받기
	public void insertSelectKey(SellVO vo);
	
	//검색 연습
	//Map<키:String, 값:Map타입>
	public List<SellVO> searchTest(Map<String, Map<String, String>> map);
	
	//페이징 사용해서 조회
	public List<SellVO> getListWithPaging(Criteria cri);
	
	//전체 데이터 개수
	public int getTotalCount(Criteria cri);
}
