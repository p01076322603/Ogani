package com.ogani.mapper;

import com.ogani.domain.CustomerDTO;

public interface MemberMapper {

	public CustomerDTO selectById(String cust_id);
}
