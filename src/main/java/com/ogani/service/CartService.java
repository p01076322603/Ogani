package com.ogani.service;

import java.util.List;

import com.ogani.domain.CartDTO;

public interface CartService {

	public String addCart(CartDTO cart);
	
	public boolean removeCart(int cart_no);
	
	public List<CartDTO> getCustomerCartList(int cust_no);
}
