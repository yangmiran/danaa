package com.kh.danaa.popup.model.vo;

import java.io.Serializable;

public class PopupPage  implements Serializable{
	private static final long serialVersionUID = 2230L;
	
	private int startRow;
	private int endRow;
	
	public PopupPage() {}

	public PopupPage(int startRow, int endRow) {
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
		return "PopupPage [startRow=" + startRow + ", endRow=" + endRow + "]";
	}
	
}
