package com.ogani.controller;

// TODO: 상품 / 카테고리 페이징 비동기로 전환

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ogani.domain.ProductCategoryDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.domain.paging.ProductCriteria;
import com.ogani.domain.paging.ProductPageDTO;
import com.ogani.service.PagingService;
import com.ogani.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/shop")
@RequiredArgsConstructor
public class ShopController {

	private final ProductService productService;
	private final PagingService pagingService;
	
	@GetMapping
	public String categoryAll(Model model, @ModelAttribute ProductCriteria criteria) {

		criteria.setLCount(9);
		criteria.setPCount(5);
		criteria.setDisplay(1);
		criteria.setStock(0);
		
		ProductPageDTO pageParam = pagingService.getProductPageDTO(criteria);
		
		List<ProductDTO> productList = productService.getProductList(pageParam);
		List<ProductCategoryDTO> categoryList = productService.getAllCategory();
		
		model.addAttribute("pageParam", pageParam);
		model.addAttribute("productList", productList);
		model.addAttribute("categoryList", categoryList);
		return "ogani/shop";
	}

	@GetMapping("/{cate_no}")
	public String category(@PathVariable int cate_no, @ModelAttribute ProductCriteria criteria, Model model) {
		
		criteria.setCategory(cate_no);
		criteria.setLCount(9);
		criteria.setPCount(5);
		criteria.setDisplay(1);
		criteria.setStock(0);
		
		ProductPageDTO pageParam = pagingService.getProductPageDTO(criteria);

		List<ProductDTO> productList = productService.getProductList(pageParam);
		List<ProductCategoryDTO> categoryList = productService.getAllCategory();
		
		model.addAttribute("pageParam", pageParam);
		model.addAttribute("productList", productList);
		model.addAttribute("categoryList", categoryList);
		
		return "ogani/shop";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
