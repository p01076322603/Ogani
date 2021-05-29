package com.ogani.controller;

import java.util.Collections;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ogani.domain.CustomerDTO;
import com.ogani.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class CommonController {

	private final MemberService memberService;
	private final PasswordEncoder passwordEncoder;
	
	// INDEX PAGE
	@GetMapping("/")
	public String index() {
		log.trace("index() GET");
		
		return "index";
	}
	
	// LOGIN
	@GetMapping("/login")
	public String loginForm(HttpServletRequest request) {
		log.trace("loginForm() GET");
		
		return "login";
	}
	
	// LOGOUT
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		log.trace("logout(request, response) GET");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		
		return "redirect:/";
	}
	
	// REGISTER
	@GetMapping("/register")
	public String registerForm() {
		log.trace("registerForm() GET");
		
		return "register";
	}
	
	@PostMapping("/register")
	public String register(@ModelAttribute CustomerDTO customer, RedirectAttributes redirectAttr) {
		log.trace("register(customer, redirectAttr) POST");
		log.debug("register( {} )", customer);

		String id    = customer.getCust_id().toLowerCase(); 
		String email = customer.getCust_email().toLowerCase();
		String encodedPassword = passwordEncoder.encode(customer.getCust_password());
		
		customer.setCust_id(id);
		customer.setCust_email(email);
		customer.setCust_password(encodedPassword);
		
		boolean registerResult = memberService.registerMember(customer);
		if (registerResult) {
			log.debug("register result = {}", registerResult);
			redirectAttr.addFlashAttribute("registerResult", registerResult);
		}
		return "redirect:/login";
	}
	
	@ResponseBody
	@PostMapping("/register/idcheck")
	public Map<String, Object> validateDuplicateMember(@RequestBody String id) {
		log.trace("validateDuplicateMember(id) POST");
		log.debug("validateDuplicateMember( id = {} )", id);
		
		String username = id.substring(id.lastIndexOf("=") + 1);
		int result = memberService.getMemberById(username) == null ? 0 : 1;
		log.debug("result = {}", result);
		
		return Collections.singletonMap("checkResult", result);
	}
	
	// OTHER PAGES
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
