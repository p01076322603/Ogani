package com.ogani.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ogani.domain.ProductCategoryDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/shop")
@RequiredArgsConstructor
public class ShopController {

	private final ProductService productService;
	
	@GetMapping
	public String categoryAll(Model model) {
		log.trace("categoryAll() GET");
		
		List<ProductCategoryDTO> categoryList = productService.getAllCategory();
		List<ProductDTO> productList = productService.getProductList();
		
		model.addAttribute("productList", productList);
		model.addAttribute("categoryList", categoryList);
		return "ogani/shop";
	}
	
	@GetMapping("/{cate_no}")
	public String category(@PathVariable int cate_no, Model model) {
		log.trace("cate_no = {}", cate_no);

		List<ProductCategoryDTO> categoryList = productService.getAllCategory();
		List<ProductDTO> productList = productService.getProductListByCategory(cate_no);
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("productList", productList);
		return "ogani/shop";
	}
}
