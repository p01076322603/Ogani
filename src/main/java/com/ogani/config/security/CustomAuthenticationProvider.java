package com.ogani.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

import com.ogani.domain.CustomerDTO;
import com.ogani.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Autowired 
	private MemberService memberService;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		String username = (String) authentication.getPrincipal();
		String password = (String) authentication.getCredentials();
		log.debug("username = {}, password = {}", username, password);
		
		CustomerDTO customer = memberService.getMemberById(username);
		if (customer != null && customer.getCust_authstatus() == 0) {
			throw new DisabledException("이메일 인증이 되지 않은 계정입니다.");
		}
		
		return null;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}
	
}