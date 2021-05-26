package com.ogani.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommonController {
	
	@GetMapping("/")
	public String index() {
		log.trace("index() GET");
		return "index";
	}
	
	@GetMapping("/login")
	public String login() {
		log.trace("login() GET");
		return "login";
	}

	@GetMapping("/register")
	public String register() {
		log.trace("register() GET");
		return "register";
	}

	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		log.trace("logout() GET");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) 
			new SecurityContextLogoutHandler().logout(request, response, auth);
		
		return "redirect:/";
	}
	
	@GetMapping("/blog")
	public String blog() {
		log.trace("blog() GET");
		return "blog";
	}
	
	@GetMapping("/contact")
	public String contact() {
		log.trace("contact() GET");
		return "contact";
	}
}
