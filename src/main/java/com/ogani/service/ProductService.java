package com.ogani.service;

import java.util.List;

import com.ogani.domain.ProductCategoryDTO;
import com.ogani.domain.ProductDTO;

public interface ProductService {

	public boolean registerCategory(ProductCategoryDTO category);
	
	public boolean registerProduct(ProductDTO product);

	public boolean modifyProduct(ProductDTO product);
	
	public boolean removeProduct(int prod_no);
	
	// TODO: 메인 화면으로 가져올 리스트들을 새로운 DTO를 만들어 한번에 가져오기
	public List<ProductDTO> getIndexLists();
	
	public List<ProductDTO> getProductList();
	
	public List<ProductDTO> getProductListByCategory(int cate_no);
	
	public List<ProductCategoryDTO> getAllCategory();

	public ProductDTO getProduct(int prod_no);
	
}