package com.ogani.service;

import java.util.List;

import com.ogani.domain.OrderDTO;

public interface OrderService {

	public boolean registerOrder(OrderDTO order);
	
	public OrderDTO getOrderByUid(String order_uid);
	
	public List<OrderDTO> getOrderByCustNo(int cust_no);
}
