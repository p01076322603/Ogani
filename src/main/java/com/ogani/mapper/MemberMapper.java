package com.ogani.mapper;

import java.util.Map;

import com.ogani.domain.CustomerDTO;

public interface MemberMapper {

	public CustomerDTO selectById(String cust_id);
	
	public CustomerDTO selectByNo(int cust_no);
	
	public int updateLastLogin(CustomerDTO customer);
	
	public int updateMember(CustomerDTO customer);
	
	public int updateEnabled(Map<String, Object> noAndEnabled);
	
	public int insertMember(CustomerDTO customer);
}
