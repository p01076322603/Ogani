package com.ogani.service;

import com.ogani.domain.OrderDTO;

public interface OrderService {

	public boolean registerOrder(OrderDTO order);
	
	public OrderDTO getOrder(String order_uid);
}
