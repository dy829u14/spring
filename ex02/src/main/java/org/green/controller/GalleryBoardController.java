package org.green.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.green.domain.GalleryBoardDTO;
import org.green.service.GalleryBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
		model.addAttribute("list",service.getList());	
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String postRegister(GalleryBoardDTO dto, RedirectAttributes rttr) {
		log.info("-----------------------------------------");
		log.info("register : "+ dto);
		log.info("-----------------------------------------");
		service.register(dto);
		rttr.addAttribute("result", dto.getGno());
		return "redirect:/galleryboard/list";
	}
	//상세보기
	@GetMapping({"/view","/modify"})
	public void get(int gno, Model model) {
		model.addAttribute("board", service.get(gno));		
	}
	
	//삭제
	@PostMapping("/remove")
	public String remove(int gno, String uploadpath, String filename) {
		deleteFile(uploadpath, filename);
		service.remove(gno);		
		return "redirect:/galleryboard/list";
	}
	
	//수정
	@PostMapping("/modify")
	public String modify(GalleryBoardDTO dto) {
		log.info("==========================");
		log.info(dto);
		log.info("==========================");	
		service.modify(dto);
		return "redirect:/galleryboard/list";
	}
	
	//파일 삭제 메소드
	private void deleteFile(String uploadpath, String filename) {
		Path file = Paths.get("c:\\upload\\"+uploadpath+"\\"+filename);
		try {
			Files.delete(file);
			Path thumbNail = Paths.get("c:\\upload\\"+uploadpath+"\\s_"+filename);
			Files.delete(thumbNail);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
