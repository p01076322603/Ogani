package com.ogani.config.security;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.ogani.domain.adapter.CustomerAdapter;
import com.ogani.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAuthenticationProvider implements AuthenticationProvider {
	
	@Autowired
	private UserDetailsService userDetailsService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private MemberService memberService;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		String username = (String) authentication.getPrincipal();
		String password = (String) authentication.getCredentials();
		CustomerAdapter userDetails = (CustomerAdapter) userDetailsService.loadUserByUsername(username);
		log.debug("userDetails = {}", userDetails);
		
		if(!passwordEncoder.matches(password, userDetails.getPassword())){
            throw new BadCredentialsException("BadCredentialsException");
        }

		Date loginDate = memberService.updateLastLogin(userDetails.getCustomer().getCust_id());
		log.debug("lastLoginDate = {}", loginDate);
		
		userDetails.getCustomer().setCust_lastlogin(loginDate);
		userDetails.getCustomer().setCust_password("[PROTECTED]");
		return new UsernamePasswordAuthenticationToken(userDetails.getCustomer(), password, userDetails.getAuthorities());
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}
	
}