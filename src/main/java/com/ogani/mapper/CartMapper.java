package com.ogani.mapper;

import java.util.List;
import java.util.Map;

import com.ogani.domain.CartDTO;

public interface CartMapper {

	public int insertCart(CartDTO cart);
	
	public int deleteCart(int cart_no);
	
	public int updateCart(Map<String, Integer> cartNoQuantity);
	
	public CartDTO selectCart(int cart_no);
	
	public List<CartDTO> selectCartList(int cust_no); 
}
