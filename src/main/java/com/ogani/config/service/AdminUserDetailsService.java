package com.ogani.config.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.ogani.domain.AdminDTO;
import com.ogani.domain.adapter.AdminAdapter;
import com.ogani.mapper.AdminMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AdminUserDetailsService implements UserDetailsService {

	@Autowired
	private AdminMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		AdminDTO admin = mapper.selectById(username);
		log.trace("mapper.selectById(username) = {}", admin);
		
		if (admin == null) {
			throw new UsernameNotFoundException("UsernameNotFoundException");
		}

		return new AdminAdapter(admin);
	}
	
}