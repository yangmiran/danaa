package com.kh.danaa.review.model.vo;

public class ReviewPage implements java.io.Serializable{
	private static final long serialVersionUID = 4000L;
	
	private int startRow;
	private int endRow;
	
	public ReviewPage() {}

	public ReviewPage(int startRow, int endRow) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "ReviewPage [startRow=" + startRow + ", endRow=" + endRow + "]";
	}

	
	
	

}
