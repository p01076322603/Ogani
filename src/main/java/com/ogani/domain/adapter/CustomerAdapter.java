package com.ogani.domain.adapter;

import java.io.Serializable;
import java.util.Collections;

import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.ogani.domain.CustomerDTO;

import lombok.Getter;

@Getter
public class CustomerAdapter extends User implements Serializable {
	private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;
	private CustomerDTO customer; 
	
	public CustomerAdapter(CustomerDTO customer) {
		super(customer.getCust_id(), customer.getCust_password(), Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER")));
		this.customer = customer;
	}

	
}
