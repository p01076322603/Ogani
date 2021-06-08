package com.ogani.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder
@NoArgsConstructor
@AllArgsConstructor
public class Criteria {
	
	private int page;
	private int lCount;
	private int pCount;
	private String keyword;

}
