package com.ogani.domain;

import lombok.Builder;
import lombok.Data;

@Data @Builder
public class CartDTO {

	private int cart_no;
	private int cust_no;
	private int prod_no;
	private int cart_quantity;
}
