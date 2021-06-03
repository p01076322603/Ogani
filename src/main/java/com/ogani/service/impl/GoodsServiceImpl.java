package com.ogani.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ogani.domain.ProductDTO;
import com.ogani.domain.ProductImageDTO;
import com.ogani.mapper.ProductMapper;
import com.ogani.service.GoodsService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class GoodsServiceImpl implements GoodsService {

	private final ProductMapper mapper;
	
	@Override
	@Transactional
	public ProductDTO getGoods(int prod_no) {
		log.trace("getGoods( prod_no = {} )", prod_no);
		
		ProductDTO product = mapper.selectProduct(prod_no);
		List<ProductImageDTO> prod_imagelist = mapper.selectProductImage(prod_no);
		
		product.setProd_imagelist(prod_imagelist);
		return product;
	}

}