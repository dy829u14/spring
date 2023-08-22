package org.green.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.green.domain.Criteria;
import org.green.domain.PageDTO;
import org.green.domain.SellAttachVO;
import org.green.domain.SellVO;
import org.green.service.SellService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/sell/*")
@AllArgsConstructor
public class SellController {
	private SellService service;
	
	//게시글 리스트
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		model.addAttribute("list", service.getList(cri));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		log.info("==========================");
	}
	//게시글 등록 페이지
	@GetMapping("/register")
	public void register() {
		
	}
	//게시글 등록 처리 페이지
	@PostMapping("/register")
	public String register(SellVO board, RedirectAttributes rttr) {
		//RedirectAttributes
		//등록작업이 끝난 후 다시 목록화면으로 이동하기 위함
		//추가적으로 새롭게 등록한 게시물의 번호를 같이 전달하기 위해 사용
		log.info("==========================================");
		log.info("register : " + board);
		log.info("==========================================");
		service.register(board);
		rttr.addAttribute("result", board.getSno());
		
		return "redirect:/sell/list";
	}
	
	//게시글 1개 조회
		@GetMapping({"/get", "/modify"})
		public void get(@RequestParam("sno") Long sno, @ModelAttribute("cri") Criteria cri, Model model) {
			log.info("get");
			model.addAttribute("board", service.get(sno));
		}
		//수정
		@PostMapping("/modify")
		public String modify(SellVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
			log.info("modify : " + board);
			if(service.modify(board)) {
				rttr.addAttribute("result", "수정");
			}
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());
			return "redirect:/sell/list";
		}
		//삭제요청 처리
		@PostMapping("/remove")
		public String remove(Long sno, RedirectAttributes rttr) {
			log.info("remove : " + sno);
			List<SellAttachVO> attachList = service.getAttachList(sno);
			if(service.remove(sno)) {
				//첨부파일 삭제(로컬에 저장된 실제파일) 메소드 호출
				deleteFiles(attachList);
				rttr.addAttribute("result", "삭제");
			}
			return "redirect:/sell/list";
		}
		//특정 게시물 번호의 첨부파일과 관련돈 데이터를 json으로 반환하는 메소드
		@GetMapping(value="/getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		public ResponseEntity<List<SellAttachVO>> getAttachList(Long sno){
			return new ResponseEntity<>(service.getAttachList(sno), HttpStatus.OK);
		}
		
		//파일 삭제 메소드
		private void deleteFiles(List<SellAttachVO> attachList) {
			if(attachList == null || attachList.size()==0) {
				return;
			}
			attachList.forEach(attach->{
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
				try {
					//deleteIfExists = 파일이 있을경우 삭제
					Files.deleteIfExists(file);
					//이미지일 경우 썸네일 이미지도 삭제
					if(Files.probeContentType(file).startsWith("image")) {
						Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
						Files.delete(thumbNail);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			});
		}
}
