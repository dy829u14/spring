package org.green.controller;

import org.green.domain.AuthVO;
import org.green.domain.MemberVO;
import org.green.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
@Log4j
public class MemberController {	
	@Setter(onMethod_= {@Autowired})
	private MemberService service;
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String postRegister(MemberVO mvo, RedirectAttributes rttr) {
		log.info("==============================");
		log.info("mvo : "+mvo);
		log.info("==============================");
		rttr.addAttribute("result", "등록");
		service.register(mvo);
		return "redirect:/member/list";
	}
}
