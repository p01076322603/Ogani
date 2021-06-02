package com.ogani.mapper;

import java.util.List;

import com.ogani.domain.ProductCategoryDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.domain.ProductImageDTO;

public interface ProductMapper {

	public int insertCategory(ProductCategoryDTO category);
	
	public int insertProduct(ProductDTO product);

	public int insertImage(ProductImageDTO image);
	
	public List<ProductCategoryDTO> selectAllCategory();
}