package com.ogani.service;

import java.util.List;

import com.ogani.domain.ProductCategoryDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.domain.paging.ProductCriteria;
import com.ogani.domain.paging.ProductPageDTO;

public interface ProductService {

	public boolean registerCategory(ProductCategoryDTO category);
	
	public boolean registerProduct(ProductDTO product);

	public boolean modifyProduct(ProductDTO product);
	
	public boolean removeProduct(int prod_no);

	public List<ProductDTO> getProductList(ProductPageDTO pageParam);

	public int getProductListCount(ProductCriteria criteria);
	
	public List<ProductDTO> getProductListByCategory(int cate_no);
	
	public List<ProductCategoryDTO> getAllCategory();

	public ProductDTO getProduct(int prod_no);
	
}