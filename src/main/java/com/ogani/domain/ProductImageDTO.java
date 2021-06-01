package com.ogani.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class ProductImageDTO {

	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;
}

