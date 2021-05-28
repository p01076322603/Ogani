package com.ogani.service;

import java.util.Date;

import com.ogani.domain.CustomerDTO;

public interface MemberService {

	public CustomerDTO selectById(String cust_id);
	
	public Date updateLastLogin(String user_id);
	
	public boolean register(CustomerDTO customer);
}
