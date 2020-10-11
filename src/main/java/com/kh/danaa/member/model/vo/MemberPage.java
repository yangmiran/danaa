package com.kh.danaa.member.model.vo;
//페이징 처리 위한 객체 생성
public class MemberPage implements java.io.Serializable {
	
	private static final long serialVersionUID = 1333L;
	
	private int page;
	private int startRow;
	private int endRow ;
	private int currentPage;
	private int maxPage;
	private int startPage;
	private int endPage;
	private int listCount;
	
	public MemberPage() {}

	
	public MemberPage(int startRow, int endRow) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
	}


	public MemberPage(int page, int startRow, int endRow, int currentPage, int maxPage, int startPage, int endPage,
			int listCount) {
		super();
		this.page = page;
		this.startRow = startRow;
		this.endRow = endRow;
		this.currentPage = currentPage;
		this.maxPage = maxPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.listCount = listCount;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public void setListCount(int listCount) {
		this.listCount = listCount;
	}

	public int getPage() {
		return page;
	}

	public int getStartRow() {
		return startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public int getListCount() {
		return listCount;
	}

	@Override
	public String toString() {
		return "Paging [page=" + page + ", startRow=" + startRow + ", endRow=" + endRow + ", currentPage=" + currentPage
				+ ", maxPage=" + maxPage + ", startPage=" + startPage + ", endPage=" + endPage + ", listCount="
				+ listCount + "]";
	}

	

	
	
}
