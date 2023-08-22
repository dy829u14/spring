package org.green.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.green.domain.BookVO;
import org.green.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Controller
@RequestMapping("book/*")
@AllArgsConstructor
public class BookController {
	@Setter(onMethod_= {@Autowired})
	private BookService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		model.addAttribute("list",service.getList());	
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String postRegister(BookVO vo, RedirectAttributes rttr) {
		service.register(vo);
		rttr.addAttribute("result", vo.getBno());
		return "redirect:/book/list";
	}
	//상세보기
	@GetMapping({"/view","/modify"})
	public void get(int bno, Model model) {
		model.addAttribute("board", service.get(bno));		
	}
	
	//삭제
	@PostMapping("/remove")
	public String remove(int bno, String uploadpath, String filename) {
		deleteFile(uploadpath, filename);
		service.remove(bno);		
		return "redirect:/book/list";
	}
	
	//수정
	@PostMapping("/modify")
	public String modify(BookVO vo) {
		service.modify(vo);
		return "redirect:/book/list";
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
