package com.ogani.mapper;

import java.util.List;
import java.util.Map;

import com.ogani.domain.CustomerDTO;
import com.ogani.domain.EmailConfirmDTO;

public interface MemberMapper {

	public CustomerDTO selectById(String cust_id);
	
	public List<CustomerDTO> selectByEmail(String cust_email);

	public CustomerDTO selectByNo(int cust_no);
	
	public CustomerDTO selectByIdAndEmail(Map<String, String> idAndEmail);
	
	public int updatePassword(Map<String, String> idPasswordAuthkey);
	
	public int updateLastLogin(CustomerDTO customer);
	
	public int updateMember(CustomerDTO customer);
	
	public int updateEnabled(Map<String, Object> noAndEnabled);
	
	public int insertMember(CustomerDTO customer);
	
	public int selectMemberAuth(EmailConfirmDTO customerAuth);
	
	public int updateMemberAuth(String cust_id);
}
