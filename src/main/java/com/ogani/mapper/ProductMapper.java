package com.ogani.mapper;

import java.util.List;

import com.ogani.domain.Criteria;
import com.ogani.domain.PageDTO;
import com.ogani.domain.ProductCategoryDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.domain.ProductImageDTO;

public interface ProductMapper {

	public int insertCategory(ProductCategoryDTO category);
	
	public int insertProduct(ProductDTO product);

	public int insertImage(ProductImageDTO image);
	
	public int updateProduct(ProductDTO product);

	public int deleteProduct(int prod_no);

	public int deleteImage(int prod_no);
	
	public ProductDTO selectProduct(int prod_no);
	
	// TODO: WIP
	public int selectProductListCount(Criteria criteria);
	
	// TODO: 교체 필요
	public List<ProductDTO> selectProductList();

	// TODO: WIP
	public List<ProductDTO> selectProductList2(PageDTO pageParam);
	
	// TODO: 교체 필요
	public List<ProductDTO> selectNewProducts();
	
	public List<ProductDTO> selectProductListByCategory(int cate_no);
	
	public List<ProductImageDTO> selectProductImage(int prod_no);
	
	public List<ProductCategoryDTO> selectAllCategory();
	
}