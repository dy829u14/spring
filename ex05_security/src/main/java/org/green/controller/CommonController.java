package org.green.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		model.addAttribute("msg", "접근거부");
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("============== : "+error);
		log.info("로그아웃==== : "+logout);
		
		if(error != null) {
			model.addAttribute("error", "로그인오류");
		}
		if(logout != null) {
			model.addAttribute("logout", "로그아웃");
		}
	}
	
	@GetMapping("/customLogout")
	public void logoutGet() {
		log.info("로그 아웃");
	}
}
