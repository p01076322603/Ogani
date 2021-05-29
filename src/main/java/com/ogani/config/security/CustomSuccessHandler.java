package com.ogani.config.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ogani.domain.CustomerDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) 
			throws IOException, ServletException {
		
		log.debug("로그인에 성공하였습니다.");
		
		CustomerDTO customer = (CustomerDTO) authentication.getPrincipal();
		log.debug("principal = {}", customer);
		
		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response); 
		
		String targetUrl = savedRequest == null ? request.getRequestURL().toString().replace(request.getRequestURI(), "") 
												: savedRequest.getRedirectUrl();
		log.debug("targetUrl = {}", targetUrl);
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("targetUrl", targetUrl);
		paramMap.put("loginResult", 1);
		
		String loginResponse = new ObjectMapper().writeValueAsString(paramMap);
		response.getWriter().print(loginResponse);
	}
	
}