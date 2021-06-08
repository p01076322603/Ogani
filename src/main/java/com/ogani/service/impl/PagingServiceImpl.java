package com.ogani.service.impl;

import org.springframework.stereotype.Service;

import com.ogani.domain.paging.ProductCriteria;
import com.ogani.domain.paging.ProductPageDTO;
import com.ogani.service.PagingService;
import com.ogani.service.ProductService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PagingServiceImpl implements PagingService {

	private final ProductService productService;
	
	public ProductPageDTO getProductPageDTO(ProductCriteria criteria) {
		
		int productListCount = productService.getProductListCount(criteria);
		ProductPageDTO pageDTO = new ProductPageDTO(criteria, productListCount);
		
		return pageDTO;
	}
}
