package org.green.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.green.domain.BoardAttachVO;
import org.green.domain.Criteria;
import org.green.domain.GalleryBoardVO;
import org.green.domain.PageDTO;
import org.green.service.GalleryBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Controller
@Log4j
@RequestMapping("galleryboard/*")
@AllArgsConstructor
public class GalleryBoardController {
	@Setter(onMethod_= {@Autowired})
	private GalleryBoardService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		model.addAttribute("list", service.getList());
	}
	
	//등록 페이지
	@GetMapping("/register")
	public void register() {
		
	}
	
	//등록처리
	@PostMapping("/register")
	public String register(GalleryBoardVO gboard, RedirectAttributes rttr) {
		log.info("==========================================");
		log.info("register : " + gboard);
		log.info("==========================================");
		service.register(gboard);
		rttr.addAttribute("result", gboard.getGno());
		
		return "redirect:/galleryboard/list";
	}
	//글 상세조회
	@GetMapping({"/view","/modify"})
	public void get(int gno, Model model) {
		model.addAttribute("board", service.get(gno));
	}
	//수정
	@PostMapping("/modify")
	public String modify(GalleryBoardVO gboard) {
		service.modify(gboard);
		
		return "redirect:/galleryboard/list";
	}
	//삭제
	@PostMapping("/remove")
	public String remove(int gno, String uploadPath, String fileName) {
		//로컬에 저장된 파일 삭제
		deleteFile(uploadPath, fileName);
		//db에 저장된 게시글 삭제
		service.remove(gno);
		return "redirect:/galleryboard/list";
	}
	//파일 삭제 메소드
	private void deleteFile(String uploadPath, String fileName) {
		Path file = Paths.get("c:\\upload\\"+uploadPath+"\\"+fileName);
		try {
			Files.delete(file);
			Path thumbNail = Paths.get("c:\\upload\\"+uploadPath+"\\s_"+fileName);
			Files.delete(thumbNail);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
