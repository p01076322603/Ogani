package com.ogani.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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

@Slf4j
@Controller
@RequestMapping("/shop")
@RequiredArgsConstructor
public class ShopController {

	private final ProductService productService;
	private final PagingService pagingService;
	
	@GetMapping
	public String categoryAll(Model model) {
		log.trace("categoryAll() GET");
		
		ProductCriteria criteria = ProductCriteria.builder()
				.lCount(9).display(1).stock(0).build();
		
		ProductPageDTO pageParam = pagingService.getProductPageDTO(criteria);
		List<ProductDTO> productList = productService.getProductList(pageParam);
		
		List<ProductCategoryDTO> categoryList = productService.getAllCategory();
		
		model.addAttribute("productList", productList);
		model.addAttribute("categoryList", categoryList);
		return "ogani/shop";
	}

}
