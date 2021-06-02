package com.ogani.domain;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class ProductDTO {

	private int prod_no;
	private int cate_no;
	private String prod_name;
	private int prod_price;
	private String prod_content;
	private Date prod_regdate;
	private int prod_stock;
	private int prod_salecount;
	private int prod_display;
	
	private List<ProductImageDTO> prod_imagelist;
}
