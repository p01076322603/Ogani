package com.ogani.mapper;

import java.util.List;

import com.ogani.domain.CartDTO;

public interface CartMapper {

	public int insertCart(CartDTO cart);
	
	public int deleteCart(int cart_no);
	
	public List<CartDTO> selectCartList(int cust_no); 
}
