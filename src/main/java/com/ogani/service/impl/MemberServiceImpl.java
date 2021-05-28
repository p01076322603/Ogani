package com.ogani.service.impl;

import java.util.Date;

import org.springframework.stereotype.Service;

import com.ogani.domain.CustomerDTO;
import com.ogani.mapper.MemberMapper;
import com.ogani.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberMapper mapper;
	
	@Override
	public CustomerDTO getCustomerById(String cust_id) {
		log.trace("getCustomerById( cust_id = {} )", cust_id);
		
		return mapper.selectById(cust_id);
	}

	@Override
	public CustomerDTO getCustomerByNo(int cust_no) {
		log.trace("getCustomerByNo( cust_no = {} )", cust_no);		
		
		return mapper.selectByNo(cust_no);
	}
	
	@Override
	public Date updateLastLogin(String cust_id) {
		log.trace("updateLastLogin( cust_id = {} )", cust_id);
		
		CustomerDTO customer = mapper.selectById(cust_id);
		mapper.updateLastLogin(customer);
		
		return customer.getCust_lastlogin();
	}

	@Override
	public boolean register(CustomerDTO customer) {
		log.trace("register( {} )", customer);
		
		return mapper.insert(customer) == 1;
	}
	
}