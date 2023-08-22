package org.green.service;

import java.util.List;

import org.green.domain.Criteria;
import org.green.domain.SellAttachVO;
import org.green.domain.SellVO;

public interface SellService {
	//등록 insert
	public void register(SellVO vo);
	//게시글 1개 조회 select
	public SellVO get(Long sno);
	//수정하기
	public boolean modify(SellVO vo);
	//삭제하기
	public boolean remove(Long sno);
	//게시글 목록 조회
	public List<SellVO> getList(Criteria cri);
	//게시글 총 갯수 반환
	public int getTotal(Criteria cri);
	
	public List<SellAttachVO> getAttachList(Long sno);
}
