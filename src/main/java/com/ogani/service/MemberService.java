package com.ogani.service;

import java.util.Date;

import com.ogani.domain.CustomerDTO;

public interface MemberService {

	public CustomerDTO getCustomerById(String cust_id);
	
	public CustomerDTO getCustomerByNo(int cust_no);
	
	public Date updateLastLogin(String user_id);
	
	public boolean register(CustomerDTO customer);
}
