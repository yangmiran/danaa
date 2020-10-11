package com.kh.danaa.qna.model.vo;

import java.io.Serializable;

public class QnaPage implements Serializable{
	private static final long serialVersionUID = 2223L;
	
	private int startRow;
	private int endRow;
	
	public QnaPage() {}

	public QnaPage(int startRow, int endRow) {
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
		return "BoardPage [startRow=" + startRow + ", endRow=" + endRow + "]";
	}
	
}

