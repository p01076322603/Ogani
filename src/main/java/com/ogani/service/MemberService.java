package com.ogani.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.ogani.domain.CustomerDTO;
import com.ogani.domain.EmailConfirmDTO;

public interface MemberService {

	public CustomerDTO getMemberById(String cust_id);
	
	public CustomerDTO getMemberByNo(int cust_no);
	
	public List<CustomerDTO> getMemberByEmail(String cust_email);

	public CustomerDTO getMemberByIdAndEmail(Map<String, String> idAndEmail);
	
	public boolean registerMember(CustomerDTO customer);
	
	public boolean updatePassword(Map<String, String> idPasswordAuthkey);
	
	public Date updateLastLogin(String user_id);
	
	public CustomerDTO modifyMember(CustomerDTO customer);
	
	public boolean leaveMember(int cust_no);
	
	public boolean checkEmailAuth(EmailConfirmDTO customerAuth);
}
