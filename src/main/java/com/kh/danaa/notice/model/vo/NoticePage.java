package com.kh.danaa.notice.model.vo;

import java.io.Serializable;

public class NoticePage implements Serializable{
	private static final long serialVersionUID = 2226L;
	
	private int startRow;
	private int endRow;
	
	public NoticePage() {}

	public NoticePage(int startRow, int endRow) {
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

	@Override
	public String toString() {
		return "NoticePage [startRow=" + startRow + ", endRow=" + endRow + "]";
	}
	
}
