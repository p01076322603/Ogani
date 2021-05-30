package com.ogani.config.security;

import java.io.IOException;
import java.util.Collections;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		String errorMessage = "";
		
		if(exception instanceof BadCredentialsException || 
		   exception instanceof InternalAuthenticationServiceException) {
			errorMessage = "아이디나 비밀번호가 맞지 않습니다.";
		
		} else if (exception instanceof DisabledException) {
			errorMessage = "비활성화된 계정입니다.";
		
		} else {
			errorMessage = "로그인에 실패하였습니다.";
		}
		
		log.debug("errorMessage = {}", errorMessage);

		String loginResult = new ObjectMapper()
				.writeValueAsString(Collections.singletonMap("loginResult", 0));
		
		response.getWriter().print(loginResult);
	}		
	
}