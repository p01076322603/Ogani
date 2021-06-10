package com.ogani.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ogani.domain.CustomerDTO;
import com.ogani.domain.EmailConfirmDTO;
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
	public List<CustomerDTO> getMemberByEmail(String cust_email) {
		log.trace("getCustomerByEmail( cust_email = {} )", cust_email);
		
		return mapper.selectByEmail(cust_email);
	}
	
	@Override
	public boolean registerMember(CustomerDTO customer) {
		log.trace("registerMember( {} )", customer);
		
		return mapper.insertMember(customer) == 1;
	}

	@Override
	public Date updateLastLogin(String cust_id) {
		log.trace("updateLastLogin( cust_id = {} )", cust_id);
		
		CustomerDTO customer = mapper.selectById(cust_id);
		mapper.updateLastLogin(customer);
		
		return customer.getCust_lastlogin();
	}

	@Override
	public CustomerDTO modifyMember(CustomerDTO customer) {
		log.trace("modifyMember( {} )", customer);
		
		int modifyResult = mapper.updateMember(customer);
		log.debug("modifyResult = {}", modifyResult);

		return modifyResult == 1 ? mapper.selectByNo(customer.getCust_no()) : null;
	}

	@Override
	public boolean leaveMember(int cust_no) {
		log.trace("leaveMember( cust_no = {} )", cust_no);
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("cust_no", cust_no);
		paramMap.put("cust_enabled", 0);
		
		return mapper.updateEnabled(paramMap) == 1;
	}

	@Override
	@Transactional
	public boolean checkEmailAuth(EmailConfirmDTO customerAuth) {
		log.trace("leaveMember( {} )", customerAuth);
		
		boolean authResult = mapper.selectMemberAuth(customerAuth) == 1;
		
		return authResult ? mapper.updateMemberAuth(customerAuth.getCust_id()) == 1
						  : false;
	}

	public CustomerDTO getMemberByIdAndEmail(Map<String, String> idAndEmail) {
		log.trace("getMemberByIdAndEmail( {} )", idAndEmail);
		
		return mapper.selectByIdAndEmail(idAndEmail);
	}

	@Override
	public boolean updatePassword(Map<String, String> idPasswordAuthkey) {
		log.trace("updatePassword( {} )", idPasswordAuthkey);
		
		return mapper.updatePassword(idPasswordAuthkey) == 1;
	}
	
}