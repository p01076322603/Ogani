package com.ogani.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ogani.domain.ProductCategoryDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.domain.ProductImageDTO;
import com.ogani.mapper.ProductMapper;
import com.ogani.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

	private final ProductMapper mapper;

	@Override
	public boolean registerCategory(ProductCategoryDTO category) {
		log.trace("registerCategory( {} )", category);
		
		return mapper.insertCategory(category) == 1;
	}
	
	@Override
	@Transactional
	public boolean registerProduct(ProductDTO product) {
		log.trace("registerProduct()");
		
		int result = mapper.insertProduct(product);
		
		product.getProd_imagelist().forEach(image -> {
			image.setProd_no(product.getProd_no());
			mapper.insertImage(image);
		});
		
		return result == 1;
	}

	@Override
	public List<ProductCategoryDTO> getAllCategory() {
		log.trace("registerCategory()");
		
		return mapper.selectAllCategory();
	}

}