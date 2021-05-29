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
	public CustomerDTO getMemberById(String cust_id) {
		log.trace("getCustomerById( cust_id = {} )", cust_id);
		
		return mapper.selectById(cust_id);
	}

	@Override
	public CustomerDTO getMemberByNo(int cust_no) {
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
	public boolean registerMember(CustomerDTO customer) {
		log.trace("registerMember( {} )", customer);
		
		return mapper.insertMember(customer) == 1;
	}

	@Override
	public CustomerDTO modifyMember(CustomerDTO customer) {
		log.trace("modifyMember( {} )", customer);
		
		int modifyResult = mapper.updateMember(customer);
		log.debug("modifyResult = {}", modifyResult);

		return modifyResult == 1 ? mapper.selectByNo(customer.getCust_no()) : null;
	}
	
}