package org.green.mapper;

import java.util.List;

import org.green.domain.SellAttachVO;

public interface SellAttachMapper {
	//등록
	public void insert(SellAttachVO vo);
	//삭제
	public void delete(String uuid);
	//조회
	public List<SellAttachVO> findBySno(Long sno);
	//게시글 번호에 해당하는 레코드 삭제(게시글삭제 시 첨부파일들도 삭제)
	public void deleteAll(Long sno);
}
