package com.ogani.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ogani.domain.CartDTO;
import com.ogani.mapper.CartMapper;
import com.ogani.mapper.ProductMapper;
import com.ogani.service.CartService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService {

	private final CartMapper cartMapper;
	private final ProductMapper productMapper;
	
	@Override
	public String addCart(CartDTO cart) {
		log.trace("addCart( {} )", cart);
		
		int prod_no = cart.getProd_no();
		int result = cartMapper.insertCart(cart);
		String prod_name = result == 1 ? productMapper.selectProduct(prod_no).getProd_name()
									   : null;

		return prod_name;
	}

	@Override
	public List<CartDTO> getCustomerCartList(int cust_no) {
		log.trace("getCustomerCartList( cust_no = {} )", cust_no);
		
		return cartMapper.selectCartList(cust_no);
	}

	@Override
	public boolean removeCart(int cart_no) {
		log.trace("removeCart( cart_no = {} )", cart_no);
		
		return cartMapper.deleteCart(cart_no) == 1;
	}

	@Override
	public boolean modifyCart(Map<String, Integer> cartNoQuantity) {
		log.trace("removeCart( {} )", cartNoQuantity);
		
		return cartMapper.updateCart(cartNoQuantity) == 1;
	}

	@Override
	public CartDTO getCart(int cart_no) {
		log.trace("getCart( cart_no = {} )", cart_no);
		
		return cartMapper.selectCart(cart_no);
	}
	
}