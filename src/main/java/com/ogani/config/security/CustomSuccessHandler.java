package com.ogani.config.security;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.ogani.domain.CustomerDTO;
import com.ogani.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomSuccessHandler implements AuthenticationSuccessHandler {

	@Autowired
	private MemberService memberService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) 
			throws IOException, ServletException {
		
		log.debug("로그인에 성공하였습니다.");
		CustomerDTO customer = (CustomerDTO) authentication.getPrincipal();
		Date loginDate = memberService.updateLastLogin(customer.getCust_id());
		
		log.debug("loginDate = {}, principal = {}", loginDate, customer);
		
		response.sendRedirect("/");
	}
	
}