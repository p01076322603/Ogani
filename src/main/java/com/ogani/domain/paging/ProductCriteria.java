package com.ogani.domain.paging;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProductCriteria {
	
	public ProductCriteria(int listCount, int productCount) {
		this.lCount = listCount; 
		this.pCount = productCount;
	}
	
	private int page;
	private int lCount;
	private int pCount;
	private Integer display;
	private Integer stock;
	private Integer category;
	private String keyword;

	
}
