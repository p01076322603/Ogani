package com.ogani.service.impl;

import org.springframework.stereotype.Service;

import com.ogani.domain.AdminDTO;
import com.ogani.mapper.AdminMapper;
import com.ogani.service.AdminService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {

	private final AdminMapper mapper;
	
	@Override
	public AdminDTO getAdminById(String admin_id) {
		log.trace("getAdminById( admin_id = {} )", admin_id);
		
		return mapper.selectById(admin_id);
	}
	
}