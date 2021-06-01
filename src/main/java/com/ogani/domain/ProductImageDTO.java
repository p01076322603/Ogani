package com.ogani.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductImageDTO {

	private String prod_image_uuid;
	private int prod_no;
	private String prod_image_url;
	private String prod_image_name;
}

