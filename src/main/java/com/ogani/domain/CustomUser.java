package com.ogani.domain;

import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User {
	private static final long serialVersionUID = 2802484444563453869L;
	private CustomerDTO customer;
	
	public CustomUser(String username, String password, 
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public CustomUser(CustomerDTO cust) {
		super(cust.getCust_id(), cust.getCust_password(), 
				Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER")));
	}
	
}
