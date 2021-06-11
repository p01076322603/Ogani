package com.ogani.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ogani.domain.ProductDTO;
import com.ogani.domain.paging.ProductCriteria;
import com.ogani.domain.paging.ProductPageDTO;
import com.ogani.service.GoodsService;
import com.ogani.service.PagingService;
import com.ogani.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//TODO: Product 항목과 통합

@Controller
@RequiredArgsConstructor
@RequestMapping("/goods")
public class GoodsController {

	private final GoodsService goodsService;
	private final ProductService productService;
	private final PagingService pagingService;
	
	@GetMapping("/{prod_no}")
	public String getGoodsDetails(@PathVariable int prod_no, Model model) {

		ProductDTO product = goodsService.getGoods(prod_no);
		ProductCriteria criteria = ProductCriteria.builder()
				.category(product.getCate_no())
				.lCount(4).display(1).stock(0).build();
		
		ProductPageDTO pageParam = pagingService.getProductPageDTO(criteria);
		List<ProductDTO> productList = productService.getProductList(pageParam);
		
		model.addAttribute("pageProduct", product);
		model.addAttribute("productList", productList);
		
		return "ogani/goodsDetails";
	}

}