package com.ogani.domain;

import lombok.Getter;
import lombok.ToString;

@Getter @ToString
public class PageDTO {

	// 현재 페이지
	private int currentPage;

	// 보여질 게시글의 개수
	private int listCount;
	
	// 페이징 숫자 범위
	private int paginationCount;

	// 검색 키워드
	private String keyword;
	
	// 전체 게시글 개수
	private int boardCount;
	
	// 인자 없이 조회시 1페이지, 페이지당 게시글 9개, 페이징 길이 5
	public PageDTO(Criteria criteria, int boardCount) {
		this.currentPage	 = criteria.getPage() 	!= 0 ? criteria.getPage() : 1;
		this.listCount 		 = criteria.getLCount() != 0 ? criteria.getLCount() : 9;
		this.paginationCount = criteria.getPCount() != 0 ? criteria.getPCount() : 5;
		
		this.keyword = criteria.getKeyword();
		this.boardCount = boardCount;
		
		createParam(); 
	}

	private int pageCount;
	private int listStart;
	private int listEnd;
	private int blockNum;
	
	private void createParam() {

		// 전체 페이지
		this.pageCount = (boardCount % listCount != 0) ? boardCount / listCount + 1
													   : boardCount / listCount;

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
		
	}
	
}