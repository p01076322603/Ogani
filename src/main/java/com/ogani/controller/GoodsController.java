package com.ogani.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ogani.domain.ProductDTO;
import com.ogani.service.GoodsService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/goods")
public class GoodsController {

	private final GoodsService goodsService;
	
	@GetMapping("/{prod_no}")
	public String getGoodsDetails(@PathVariable int prod_no, Model model) {
		log.debug("getGoodsDetails( prod_no = {} )", prod_no);

		ProductDTO product = goodsService.getGoods(prod_no);
		model.addAttribute("product", product);
		
		return "ogani/goodsDetails";
	}

}