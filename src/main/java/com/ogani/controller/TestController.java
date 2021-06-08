package com.ogani.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.ogani.domain.Criteria;
import com.ogani.domain.PageDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class TestController {

	private final ProductService productService;
	
	@GetMapping("/test")
	public void test(@ModelAttribute Criteria criteria) {
		log.debug("test( {} ) GET", criteria);
		
		PageDTO pageDTO = new PageDTO(criteria, productService.getProductListCount(criteria));
		log.debug("{}", pageDTO);
		
		List<ProductDTO> productList = productService.getProductList2(pageDTO);
		productList.forEach(product -> {
			log.debug("{}", product);
		});
	}
}
