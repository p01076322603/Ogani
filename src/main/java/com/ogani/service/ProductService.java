package com.ogani.service;

import java.util.List;

import com.ogani.domain.Criteria;
import com.ogani.domain.PageDTO;
import com.ogani.domain.ProductCategoryDTO;
import com.ogani.domain.ProductDTO;

public interface ProductService {

	public boolean registerCategory(ProductCategoryDTO category);
	
	public boolean registerProduct(ProductDTO product);

	public boolean modifyProduct(ProductDTO product);
	
	public boolean removeProduct(int prod_no);
	
	// TODO: 교체 필요
	public List<ProductDTO> getIndexLists();

	// TODO: 교체 필요
	public List<ProductDTO> getProductList();

	// TODO: WIP
	public List<ProductDTO> getProductList2(PageDTO pageParam);

	// TODO: WIP
	public int getProductListCount(Criteria criteria);
	
	public List<ProductDTO> getProductListByCategory(int cate_no);
	
	public List<ProductCategoryDTO> getAllCategory();

	public ProductDTO getProduct(int prod_no);
	
}