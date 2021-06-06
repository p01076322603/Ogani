package com.ogani.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ogani.domain.OrderDTO;
import com.ogani.domain.OrderDetailDTO;
import com.ogani.mapper.OrderMapper;
import com.ogani.service.OrderService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
	
	private final OrderMapper mapper;
	
	
	@Override
	@Transactional
	public boolean registerOrder(OrderDTO order) {
		log.trace("registerOrder( {} )", order);
	
		int result = mapper.insertOrder(order);
		
		List<OrderDetailDTO> orderDetailList = order.getOrderDetailList();
		orderDetailList.forEach(orderDetail -> {
			mapper.insertOrderDetail(orderDetail);
		});
		
		return result == 1;
	}


	@Override
	@Transactional
	public OrderDTO getOrder(String order_uid) {
		log.trace("getOrder( order_uid = {} )", order_uid);
		
		OrderDTO order = mapper.selectOrderByUid(order_uid);
		order.setOrderDetailList(mapper.selectOrderDetailByUid(order_uid));
		
		return order;
	}
	
}