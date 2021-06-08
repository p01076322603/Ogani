package com.ogani.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ogani.domain.Criteria;
import com.ogani.domain.PageDTO;
import com.ogani.domain.ProductCategoryDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.domain.ProductImageDTO;
import com.ogani.mapper.ProductMapper;
import com.ogani.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service(value = "ProductService")
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
		log.trace("registerProduct( {} )", product);
		
		int result = mapper.insertProduct(product);
		
		product.getProd_imagelist().forEach(image -> {
			image.setProd_no(product.getProd_no());
			mapper.insertImage(image);
		});
		
		return result == 1;
	}


	@Override
	@Transactional
	public boolean modifyProduct(ProductDTO product) {
		log.trace("modifyProduct( {} )", product);
		
		int result = mapper.updateProduct(product);
		
		mapper.deleteImage(product.getProd_no());
		
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

	@Override
	public List<ProductDTO> getProductList() {
		log.trace("getProductList()");
		
		return mapper.selectProductList();
	}
	

	@Override
	public List<ProductDTO> getProductList2(PageDTO pageParam) {
		log.trace("getProductList()");
		
		List<ProductDTO> productList = mapper.selectProductList2(pageParam);
		productList.forEach(product -> {
			
			int prod_no = product.getProd_no();
			product.setProd_imagelist(mapper.selectProductImage(prod_no));
		});
		
		return productList;
	}

	@Override
	@Transactional
	public ProductDTO getProduct(int prod_no) {
		log.trace("getProduct( prod_no = {} )", prod_no);
		
		ProductDTO product = mapper.selectProduct(prod_no);

		List<ProductImageDTO> imageList = mapper.selectProductImage(prod_no);
		product.setProd_imagelist(imageList);
		
		return product;
	}

	@Override
	@Transactional
	public boolean removeProduct(int prod_no) {
		log.trace("removeProduct( prod_no = {} )", prod_no);
		
		int result = mapper.deleteImage(prod_no);
			result = mapper.deleteProduct(prod_no);
		
		return result == 1;
	}

	@Override
	@Transactional
	public List<ProductDTO> getIndexLists() {
		log.trace("getIndexLists()");
		
		List<ProductDTO> newProductList = mapper.selectNewProducts();
		newProductList.forEach(product -> {
			int prod_no = product.getProd_no();
			
			List<ProductImageDTO> productImageList = mapper.selectProductImage(prod_no);
			product.setProd_imagelist(productImageList);
		});
		
		return newProductList;
	}

	@Override
	public List<ProductDTO> getProductListByCategory(int cate_no) {
		log.trace("getProductListByCategory( cate_no = {} )", cate_no);
		
		return mapper.selectProductListByCategory(cate_no);
	}

	@Override
	public int getProductListCount(Criteria criteria) {
		log.trace("getProductListCount()");
		
		return mapper.selectProductListCount(criteria);
	}

	
}