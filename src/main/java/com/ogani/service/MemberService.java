package com.ogani.service;

import java.util.Date;

import com.ogani.domain.CustomerDTO;

public interface MemberService {

	public CustomerDTO getMemberById(String cust_id);
	
	public CustomerDTO getMemberByNo(int cust_no);
	
	public Date updateLastLogin(String user_id);
	
	public CustomerDTO modifyMember(CustomerDTO customer);
	
	public boolean registerMember(CustomerDTO customer);
}
