package com.ogani.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

	@GetMapping
	public String index() {
		log.trace("index() GET");
		
		return "admin/index";
	}

	@GetMapping("/blank")
	public String blank() {
		log.trace("blank() GET");
		
		return "admin/blank";
	}
	
}