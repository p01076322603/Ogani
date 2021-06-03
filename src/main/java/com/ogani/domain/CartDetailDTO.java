package com.ogani.domain;

import lombok.Builder;
import lombok.Data;

@Data @Builder
public class CartDetailDTO {

	private int cart_no;
	private String prod_name;
	private int prod_price;
	private int cart_quantity;
	private String imagePath;
}
