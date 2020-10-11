package com.kh.danaa.reservation.model.vo;

public class ReservationPage implements java.io.Serializable {
	private static final long serialVersionUID = 5552L;
	
	private int startRow;
	private int endRow;
	private int res_check;
	
	public ReservationPage() {}
	
	public ReservationPage(int startRow, int endRow) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
	}
	
	public ReservationPage(int startRow, int endRow, int res_check) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
		this.res_check = res_check;
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

	public int getRes_check() {
		return res_check;
	}

	public void setRes_check(int res_check) {
		this.res_check = res_check;
	}

	@Override
	public String toString() {
		return "ReservationPage [startRow=" + startRow + ", endRow=" + endRow + ", res_check=" + res_check + "]";
	}	
	
}
