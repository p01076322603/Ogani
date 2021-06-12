package com.ogani.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ogani.domain.CartDTO;
import com.ogani.domain.CartDetailDTO;
import com.ogani.domain.CustomerDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.domain.ProductImageDTO;
import com.ogani.service.CartService;
import com.ogani.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/cart")
@Secured("ROLE_USER")
@RequiredArgsConstructor
public class CartController {

	private final CartService cartService;
	private final ProductService productService;
	
	@GetMapping
	public String cart(Model model, @AuthenticationPrincipal CustomerDTO customer) {
		int cust_no = customer.getCust_no();
		
		List<CartDTO> cartList = cartService.getCustomerCartList(cust_no);
		List<CartDetailDTO> cartDetailList = new ArrayList<>();
		
		cartList.forEach(cart -> {
			ProductDTO product = productService.getProduct(cart.getProd_no());
			
			List<ProductImageDTO> prod_imagelist = product.getProd_imagelist();
			ProductImageDTO image = prod_imagelist.get(0);
			
			String imagePath = image.getProd_image_url() + "/" + image.getProd_image_uuid() + "_" + image.getProd_image_name();
			
			CartDetailDTO cartDetail = CartDetailDTO.builder()
					.imagePath(imagePath)
					.cart_no(cart.getCart_no())
					.prod_name(product.getProd_name())
					.prod_price(product.getProd_price())
					.cart_quantity(cart.getCart_quantity())
					.build();
			
			cartDetailList.add(cartDetail);
		});

		model.addAttribute("cartDetailList", cartDetailList);
		return "ogani/shoppingCart";
	}
	
	@GetMapping("/add")
	public String addCartGET() {
		return "redirect:/cart";
	}
	
	@ResponseBody
	@PostMapping("/add")
	public Map<String, Object> addCart(@RequestBody Map<String, Integer> cartMap) {

		int cust_no = cartMap.get("cust_no");
		int prod_no = cartMap.get("prod_no");
		int cart_quantity = cartMap.get("cart_quantity");
		
		List<CartDTO> cartList = cartService.getCustomerCartList(cust_no);
		Optional<CartDTO> cartAlreadyExists = 
				cartList.stream().filter(cart -> cart.getProd_no() == prod_no).findFirst();

		Map<String, Object> resultMap = new HashMap<>();
		String prod_name = productService.getProduct(prod_no).getProd_name();
		
		if (cartAlreadyExists.isPresent()) {
			CartDTO cart = cartAlreadyExists.get();
			
			Map<String, Integer> paramMap = new HashMap<>();
			paramMap.put("cart_no", cart.getCart_no());
			paramMap.put("cart_quantity", cart_quantity);
			
			boolean modifyResult = cartService.modifyCart(paramMap);
			log.debug("cart modifyResult = {}", modifyResult);
			
			resultMap.put("addCartResult", "modified");

		} else {
			CartDTO cart = CartDTO.builder()
					.cust_no(cust_no)
					.prod_no(prod_no)
					.cart_quantity(cart_quantity)
					.build();

			cartService.addCart(cart);
			
			resultMap.put("addCartResult", true);
		}

		resultMap.put("prod_name", prod_name);
		resultMap.put("cart_quantity", cart_quantity);
		
		return resultMap;
	}
	
	@ResponseBody
	@PostMapping("/remove")
	public void removeCart(@RequestBody Map<String, Integer> paramMap) {

		boolean result = cartService.removeCart(paramMap.get("cart_no"));
		log.debug("removeCart result = {}", result);

	}
	
	@ResponseBody
	@PostMapping("/modify")
	public void modifyCart(@RequestBody String cartParam) {
	
		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, Integer>> cartList = Collections.emptyList();
		try {
			cartList = mapper.readValue(cartParam, new TypeReference<List<Map<String, Integer>>>(){});
		} catch (Exception e) { e.printStackTrace(); }
		
		cartList.forEach(cartMap -> cartService.modifyCart(cartMap));
	}
	
}