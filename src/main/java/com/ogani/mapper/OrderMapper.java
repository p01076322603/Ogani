package com.ogani.mapper;

import java.util.List;

import com.ogani.domain.OrderDTO;
import com.ogani.domain.OrderDetailDTO;

public interface OrderMapper {

	public int insertOrder(OrderDTO order);
	
	public int insertOrderDetail(OrderDetailDTO orderDetail);
	
	public OrderDTO selectOrderByUid(String order_uid);
	
	public List<OrderDTO> selectOrderByCustNo(int cust_no);
	
	public List<OrderDetailDTO> selectOrderDetailByUid(String order_uid);
}
