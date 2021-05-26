package com.ogani.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.ogani.domain.CustomUser;
import com.ogani.domain.CustomerDTO;
import com.ogani.mapper.MemberMapper;

public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		CustomerDTO customer = mapper.selectById(username);
		
		if (customer == null)
			throw new UsernameNotFoundException("UsernameNotFoundException");
		
		return new CustomUser(customer);
	}
	
}