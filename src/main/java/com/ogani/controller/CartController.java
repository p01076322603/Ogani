package com.ogani.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
@RequiredArgsConstructor
public class CartController {

	private final CartService cartService;
	private final ProductService productService;
	
	@GetMapping
	@Secured("ROLE_USER")
	public String cart(Model model) {
		log.trace("cart() GET");
		
		CustomerDTO customer = (CustomerDTO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
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
	
	@ResponseBody
	@PostMapping("/add")
	public Map<String, Object> addCart(@RequestBody Map<String, String> cartMap) {
		log.debug("addCart( cartMap = {} ) POST", cartMap);

		CartDTO cart = CartDTO.builder()
				.cust_no(Integer.parseInt(cartMap.get("cust_no")))
				.prod_no(Integer.parseInt(cartMap.get("prod_no")))
				.cart_quantity(Integer.parseInt(cartMap.get("cart_quantity")))	
				.build();
		
		String prod_name = cartService.addCart(cart);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		if (prod_name == null) {
			resultMap.put("addCartResult", false);

		} else {
			resultMap.put("prod_name", prod_name);
			resultMap.put("cart_quantity", cartMap.get("cart_quantity"));
			resultMap.put("addCartResult", true);
		}
		
		return resultMap;
	}
	
	@ResponseBody
	@PostMapping("/remove")
	public ResponseEntity<String> removeCart(@RequestBody Map<String, String> paramMap) {
		log.debug("removeCart( cart_no = {} )", paramMap);

		boolean result = cartService.removeCart(Integer.parseInt(paramMap.get("cart_no")));
		log.debug("removeCart result = {}", result);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");
		
		return result ? new ResponseEntity<>("삭제 되었습니다.", headers, HttpStatus.OK) 
					  : new ResponseEntity<>("삭제에 실패하였습니다.", headers, HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}