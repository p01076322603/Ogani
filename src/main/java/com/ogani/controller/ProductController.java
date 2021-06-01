package com.ogani.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@Secured("ROLE_ADMIN")
@RequestMapping("/admin/product")
public class ProductController {

	@GetMapping
	public String product() {
		log.trace("product() GET");
		
		return "admin/product";
	}

	@GetMapping("/register")
	public String productRegister() {
		log.trace("productRegister() GET");
		
		return "admin/productRegister";
	}
	
}
