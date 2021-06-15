package com.ogani.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ogani.domain.OrderDTO;
import com.ogani.domain.OrderDetailDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.mapper.OrderMapper;
import com.ogani.mapper.ProductMapper;
import com.ogani.service.OrderService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
	
	private final OrderMapper orderMapper;
	private final ProductMapper productMapper;
	
	@Override
	@Transactional
	public boolean registerOrder(OrderDTO order) {
		log.trace("registerOrder( {} )", order);
	
		int result = orderMapper.insertOrder(order);
		
		List<OrderDetailDTO> orderDetailList = order.getOrderDetailList();
		orderDetailList.forEach(orderDetail -> {
			orderMapper.insertOrderDetail(orderDetail);
		});
		
		return result == 1;
	}


	@Override
	@Transactional
	public OrderDTO getOrderByUid(String order_uid) {
		log.trace("getOrder( order_uid = {} )", order_uid);
		
		OrderDTO order = orderMapper.selectOrderByUid(order_uid);
		if (order != null) {
			order.setOrderDetailList(orderMapper.selectOrderDetailByUid(order_uid));
		}
		
		return order;
	}


	@Override
	@Transactional
	public List<OrderDTO> getOrderByCustNo(int cust_no) {
		log.trace("getOrderByCustNo( cust_no = {} )", cust_no);
		
		List<OrderDTO> orderList = orderMapper.selectOrderByCustNo(cust_no);

		orderList.forEach(order -> {
			List<OrderDetailDTO> orderDetailList = orderMapper.selectOrderDetailByUid(order.getOrder_uid());
			
			orderDetailList.forEach(orderDetail -> {
				ProductDTO product = productMapper.selectProduct(orderDetail.getProd_no());
				orderDetail.setProd_name(product.getProd_name());
			});
			
			order.setOrderDetailList(orderDetailList);
		});
		
		return orderList;
	}

}