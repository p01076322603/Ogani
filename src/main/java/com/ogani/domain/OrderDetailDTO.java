package com.ogani.domain;

import lombok.Builder;
import lombok.Data;

@Data @Builder
public class OrderDetailDTO {

	private int order_detail_no;
	private int prod_no;
	private String order_uid;
	private int order_detail_quantity;
}
