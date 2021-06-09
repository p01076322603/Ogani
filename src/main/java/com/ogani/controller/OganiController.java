package com.ogani.controller;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ogani.domain.CustomerDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.domain.paging.ProductCriteria;
import com.ogani.domain.paging.ProductPageDTO;
import com.ogani.service.AdminService;
import com.ogani.service.MemberService;
import com.ogani.service.PagingService;
import com.ogani.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class OganiController {

	private final ProductService productService;
	private final PagingService pagingService;
	
	// INDEX PAGE
	@GetMapping("/")
	public String index(Model model) {
		log.trace("index() GET");

		ProductCriteria criteria = ProductCriteria.builder()
				.lCount(8).display(1).stock(0).build();
		
		ProductPageDTO pageParam = pagingService.getProductPageDTO(criteria);
		
		List<ProductDTO> newProductList = productService.getProductList(pageParam);
		log.trace("{}", newProductList);
		
		model.addAttribute("newProductList", newProductList);
		return "ogani/index";
	}
	
	// LOGIN
	@GetMapping("/login")
	public String loginForm(@RequestParam(required = false) Integer prod_no, HttpServletRequest request) {
		log.debug("loginForm( prod_no = {} ) GET", prod_no);

		if (prod_no != null) request.getSession().setAttribute("return-to", prod_no);
		
		return "ogani/login";
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
	
	// OTHER PAGES
	@GetMapping("/blog")
	public String blog() {
		log.trace("blog() GET");
		
		return "ogani/blog";
	}
	
	@GetMapping("/contact")
	public String contact() {
		log.trace("contact() GET");
		
		return "ogani/contact";
	}
}
