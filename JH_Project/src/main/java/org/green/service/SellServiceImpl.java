package org.green.service;

import java.util.List;

import org.green.domain.AttachFileDTO;
import org.green.domain.Criteria;
import org.green.domain.SellAttachVO;
import org.green.domain.SellVO;
import org.green.mapper.SellAttachMapper;
import org.green.mapper.SellMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class SellServiceImpl implements SellService{
	@Setter(onMethod_= {@Autowired})
	private SellMapper mapper;
	@Setter(onMethod_= {@Autowired})
	private SellAttachMapper attachMapper;

	@Override
	public void register(SellVO vo) {
		log.info("등록하기 : " + vo);
		mapper.insertSelectKey(vo);
		
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) { return; }
		vo.getAttachList().forEach(attach->{
			attach.setSno(vo.getSno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public SellVO get(Long sno) {
		return mapper.read(sno);
	}

	@Override
	public boolean modify(SellVO vo) {
		log.info("수정하기 : " + vo);
		//sno 번호에 해당하는 첨부파일 게시글 삭제
		attachMapper.deleteAll(vo.getSno());
		//board테이블 수정
		boolean modifyResult = mapper.update(vo) == 1;
		if(vo.getAttachList() != null && vo.getAttachList().size() > 0) {
			vo.getAttachList().forEach(attach->{
				attach.setSno(vo.getSno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult; 
	}

	@Override
	public boolean remove(Long sno) {
		log.info("삭제하기 : " + sno);
		//첨부파일 삭제하기(db)
		attachMapper.deleteAll(sno);
		return mapper.delete(sno) == 1;
	}

	@Override
	public List<SellVO> getList(Criteria cri) {		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<SellAttachVO> getAttachList(Long sno) {
		log.info("첨부리스트 게시글 번호 : " + sno);
		return attachMapper.findBySno(sno);
	}


	
}
