package com.ogani.service;

import com.ogani.domain.paging.ProductCriteria;
import com.ogani.domain.paging.ProductPageDTO;

public interface PagingService {

	public ProductPageDTO getProductPageDTO(ProductCriteria criteria);
}
