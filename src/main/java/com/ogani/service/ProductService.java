package com.ogani.service;

import java.util.List;

import com.ogani.domain.ProductCategoryDTO;
import com.ogani.domain.ProductDTO;

public interface ProductService {

	public boolean registerCategory(ProductCategoryDTO category);
	
	public boolean registerProduct(ProductDTO product);

	public boolean modifyProduct(ProductDTO product);
	
	public boolean removeProduct(int prod_no);
	
	public ProductDTO getProduct(int prod_no);
	
	public List<ProductDTO> getProductList();
	
	public List<ProductCategoryDTO> getAllCategory();
}