package com.kh.danaa.doctor.model.vo;

public class Doctor implements java.io.Serializable {
	private static final long serialVersionUID = 5555L;
	
	private int doc_no;
	private String doc_name;
	private String doc_day;
	private String doc_pic;
	
	public Doctor() {}

	public Doctor(int doc_no, String doc_name, String doc_day, String doc_pic) {
		super();
		this.doc_no = doc_no;
		this.doc_name = doc_name;
		this.doc_day = doc_day;
		this.doc_pic = doc_pic;
	}

	public int getDoc_no() {
		return doc_no;
	}

	public void setDoc_no(int doc_no) {
		this.doc_no = doc_no;
	}

	public String getDoc_name() {
		return doc_name;
	}

	public void setDoc_name(String doc_name) {
		this.doc_name = doc_name;
	}

	public String getDoc_day() {
		return doc_day;
	}

	public void setDoc_day(String doc_day) {
		this.doc_day = doc_day;
	}

	public String getDoc_pic() {
		return doc_pic;
	}

	public void setDoc_pic(String doc_pic) {
		this.doc_pic = doc_pic;
	}

	@Override
	public String toString() {
		return "Doctor [doc_no=" + doc_no + ", doc_name=" + doc_name + ", doc_day=" + doc_day + ", doc_pic=" + doc_pic
				+ "]";
	}
	
}
