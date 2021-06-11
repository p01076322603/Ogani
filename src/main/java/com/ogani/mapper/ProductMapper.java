package com.ogani.mapper;

import java.util.List;

import com.ogani.domain.ProductCategoryDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.domain.ProductImageDTO;
import com.ogani.domain.paging.ProductCriteria;
import com.ogani.domain.paging.ProductPageDTO;

public interface ProductMapper {

	public int insertCategory(ProductCategoryDTO category);
	
	public int insertProduct(ProductDTO product);

	public int insertImage(ProductImageDTO image);
	
	public List<ProductImageDTO> getOldImages();
	
	public int updateProduct(ProductDTO product);

	public int deleteProduct(int prod_no);

	public int deleteImage(int prod_no);
	
	public ProductDTO selectProduct(int prod_no);
	
	public int selectProductListCount(ProductCriteria criteria);
	
	public List<ProductDTO> selectProductList(ProductPageDTO pageParam);
	
	public List<ProductDTO> selectProductListByCategory(int cate_no);
	
	public List<ProductImageDTO> selectProductImage(int prod_no);
	
	public List<ProductCategoryDTO> selectAllCategory();
	
}