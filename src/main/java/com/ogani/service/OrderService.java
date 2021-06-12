package com.ogani.service;

import com.ogani.domain.OrderDTO;

public interface OrderService {

	public boolean registerOrder(OrderDTO order);
	
	public OrderDTO getOrderByUid(String order_uid);
	
	public OrderDTO getOrderByCustNo(int cust_no);
}
