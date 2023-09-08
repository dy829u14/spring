package org.green.controller;

import org.green.domain.AuthVO;
import org.green.domain.Criteria;
import org.green.domain.MemberVO;
import org.green.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
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
	public String postRegister(MemberVO mvo, AuthVO avo, RedirectAttributes rttr) {
		log.info("==============================");
		log.info("mvo : "+mvo);
		log.info("==============================");
		rttr.addAttribute("result", "등록");
		service.register(mvo, avo);
		return "redirect:/main";
	}
	
	@GetMapping({"/get", "/modify"})
	public void modify(String mId, Model model) {
	    // 현재 사용자의 인증 정보 가져오기
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

	    // 현재 로그인한 사용자의 username 가져오기
	    mId = authentication.getName(); // 혹은 authentication.getPrincipal().toString();

	    // service.get(username)를 호출하여 사용자 정보를 가져오고 모델에 추가
	    MemberVO member = service.get(mId);
	    model.addAttribute("mem", member);
	}
	
	@GetMapping("/login")
	public void login() {
		
	}
	
	//아이디 중복체크
	@PostMapping("/idCheck")
	@ResponseBody
	public String idCheck(@RequestParam("mId") String id) {
		int cnt = service.idCheck(id);
		log.info("==============================");
		log.info("cnt : " + cnt);
		log.info("==============================");
		String aa = ""+cnt;
		return aa;
	}
}
