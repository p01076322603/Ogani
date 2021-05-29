package com.ogani.mapper;

import com.ogani.domain.CustomerDTO;

public interface MemberMapper {

	public CustomerDTO selectById(String cust_id);
	
	public CustomerDTO selectByNo(int cust_no);
	
	public int updateLastLogin(CustomerDTO customer);
	
	public int insertMember(CustomerDTO customer);
	
	public int updateMember(CustomerDTO customer);
}
