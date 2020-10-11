package com.kh.danaa.banner.model.vo;

public class BannerPage implements java.io.Serializable {
	private static final long serialVersionUID = 3444L;
	
	private int startRow;
	private int endRow;
	
	public BannerPage() {}

	public BannerPage(int startRow, int endRow) {
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
		return "BannerPage [startRow=" + startRow + ", endRow=" + endRow + "]";
	}
	
	
}
