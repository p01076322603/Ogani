package com.ogani.service;

import java.util.Date;

import com.ogani.domain.CustomerDTO;
import com.ogani.domain.EmailConfirmDTO;

public interface MemberService {

	public CustomerDTO getMemberById(String cust_id);
	
	public CustomerDTO getMemberByNo(int cust_no);
	
	public boolean registerMember(CustomerDTO customer);
	
	public Date updateLastLogin(String user_id);
	
	public CustomerDTO modifyMember(CustomerDTO customer);
	
	public boolean leaveMember(int cust_no);
	
	public boolean checkEmailAuth(EmailConfirmDTO customerAuth);
}
