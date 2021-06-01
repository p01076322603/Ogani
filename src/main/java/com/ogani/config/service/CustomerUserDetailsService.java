package com.ogani.config.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.ogani.domain.CustomerDTO;
import com.ogani.domain.adapter.CustomerAdapter;
import com.ogani.mapper.MemberMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomerUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		CustomerDTO customer = mapper.selectById(username);
		log.trace("mapper.selectById(username) = {}", customer);
		
		if (customer == null) {
			throw new UsernameNotFoundException("UsernameNotFoundException");
		}

		return new CustomerAdapter(customer);
	}
	
}