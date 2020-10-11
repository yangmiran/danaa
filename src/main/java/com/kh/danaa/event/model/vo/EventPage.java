package com.kh.danaa.event.model.vo;

import java.io.Serializable;

public class EventPage implements Serializable{
private static final long serialVersionUID = 2228L;
	
	private int startRow;
	private int endRow;
	
	public EventPage() {}

	public EventPage(int startRow, int endRow) {
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
		return "EventPage [startRow=" + startRow + ", endRow=" + endRow + "]";
	}
	
}
