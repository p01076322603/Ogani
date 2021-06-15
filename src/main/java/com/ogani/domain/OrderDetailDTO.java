package com.ogani.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailDTO {

	private int order_detail_no;
	private int prod_no;
	private String order_uid;
	private int order_detail_quantity;
	private int order_detail_shipstatus;
	
	private String prod_name;
}
