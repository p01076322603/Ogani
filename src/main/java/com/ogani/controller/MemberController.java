package com.ogani.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@Secured("ROLE_USER")
@RequestMapping("/member")
public class MemberController {

	
	@GetMapping
	public String memberInfo() {
		log.trace("memberInfo() GET");

		return "memberInfo";
	}

	@GetMapping("/modify")
	public String memberModifyForm() {
		log.trace("memberModifyForm() GET");
		
		return "memberModify";
	}
}
