package org.green.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/sample/*")
@Controller
public class SampleController {
	@GetMapping("/all")
	public void doAll() {
		log.info("everybody");
	}
	@GetMapping("member")
	public void doMember() {
		log.info("member");
	}
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("admin");
	}
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@GetMapping("/annoMember")
	public void doMember2() {
		log.info("member나 admin 권한이 있어야함");
	}
	@Secured("ROLE_ADMIN")
	@GetMapping("/annoAdmin")
	public void doAdmin2() {
		log.info("admin 권한이 있어야함");
	}
}
