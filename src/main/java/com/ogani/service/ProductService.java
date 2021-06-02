package com.ogani.service;

import java.util.List;

import com.ogani.domain.ProductCategoryDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.domain.ProductImageDTO;

public interface ProductService {

	public boolean registerCategory(ProductCategoryDTO category);
	
	public boolean registerProduct(ProductDTO product);
	
	public List<ProductCategoryDTO> getAllCategory();
}