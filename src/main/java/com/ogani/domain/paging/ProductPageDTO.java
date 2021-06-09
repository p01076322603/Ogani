package com.ogani.domain.paging;

import lombok.Getter;
import lombok.ToString;

@Getter @ToString
public class ProductPageDTO {

	// 현재 페이지
	private int currentPage;

	// 보여질 상품의 개수
	private int listCount;
	
	// 페이징 숫자 범위 칸수
	private int paginationCount;
	
	// 전체 상품 개수
	private int productCount;
	
	// 상품의 진열 여부
	private Integer display;
	
	// 상품의 재고
	private Integer stock;
	
	// 상품의 카테고리
	private Integer category;
	
	// 검색 키워드
	private String keyword;

	/**
	 * 값이 할당되지 않을 경우
	 * currentPage: 1, listCount: 10, paginationCount: 10
	 * display: null, stock: null, keyword: null, category: null
	 */
	public ProductPageDTO(ProductCriteria criteria, int productCount) {
		this.currentPage	 = criteria.getPage() 	!= 0 ? criteria.getPage()   : 1;
		this.listCount 		 = criteria.getLCount() != 0 ? criteria.getLCount() : 10;
		this.paginationCount = criteria.getPCount() != 0 ? criteria.getPCount() : 10;
		this.productCount    = productCount;
		
		this.display = criteria.getDisplay();
		this.stock   = criteria.getStock();
		this.keyword = criteria.getKeyword();
		this.category = criteria.getCategory();
		
		createParam(); 
	}

	private int pageCount;
	private int listStart;
	private int listEnd;
	private int blockNum;
	private int lastBlockNum;
	
	private void createParam() {

		// 전체 페이지
		this.pageCount = (productCount % listCount != 0) ? (productCount / listCount) + 1
													     : productCount / listCount;

		// 페이지 직접 입력 범위 제한
		this.currentPage = (currentPage > pageCount) ? currentPage = pageCount 
						 : (currentPage < 1)         ? currentPage = 1 
						 							 : currentPage;
		
		// 현재 페이지의 시작 게시글 ROWNUM
		this.listStart = (currentPage - 1) * listCount + 1;
		
		// 현재 페이지의 끝 게시글 ROWNUM
		this.listEnd = currentPage * listCount;
		
		// 페이징 숫자 블럭 구간을 나타내는 수치
		this.blockNum = (currentPage % paginationCount == 0) ? (currentPage / paginationCount) - 1
															 : currentPage / paginationCount;
		
		// 마지막 블럭 구간의 수치
		this.lastBlockNum = (pageCount % paginationCount) == 0 ? (pageCount / paginationCount) - 1 
															   : pageCount / paginationCount;
	}
	
}