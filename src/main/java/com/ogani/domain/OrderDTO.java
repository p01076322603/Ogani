package com.ogani.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderDTO {

	private String order_uid;
	private int cust_no;
	private String order_imp_uid;
	private String order_name;
	private Date order_regdate;
	private int order_price;
	private int order_card_approval;
	private String order_buyer;
	private String order_email;
	private int order_postcode;
	private String order_address;
	private String order_phone;
	private String order_request;
	
	private List<OrderDetailDTO> orderDetailList;
	
}
