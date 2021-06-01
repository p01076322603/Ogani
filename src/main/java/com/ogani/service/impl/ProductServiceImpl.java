package com.ogani.service.impl;

import org.springframework.stereotype.Service;

import com.ogani.mapper.ProductMapper;
import com.ogani.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

	private final ProductMapper mapper;

	
	
}