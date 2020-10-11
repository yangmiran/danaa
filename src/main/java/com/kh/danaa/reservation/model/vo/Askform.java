package com.kh.danaa.reservation.model.vo;

public class Askform implements java.io.Serializable {
	private static final long serialVersionUID = 5553L;
	
	private int res_no;
	private String res_name;
	private String ask1;
	private String ask2;
	private String ask3;
	private String ask4;
	
	public Askform() {}

	public Askform(int res_no, String res_name, String ask1, String ask2, String ask3, String ask4) {
		super();
		this.res_no = res_no;
		this.res_name = res_name;
		this.ask1 = ask1;
		this.ask2 = ask2;
		this.ask3 = ask3;
		this.ask4 = ask4;
	}

	public int getRes_no() {
		return res_no;
	}

	public void setRes_no(int res_no) {
		this.res_no = res_no;
	}

	public String getRes_name() {
		return res_name;
	}

	public void setRes_name(String res_name) {
		this.res_name = res_name;
	}

	public String getAsk1() {
		return ask1;
	}

	public void setAsk1(String ask1) {
		this.ask1 = ask1;
	}

	public String getAsk2() {
		return ask2;
	}

	public void setAsk2(String ask2) {
		this.ask2 = ask2;
	}

	public String getAsk3() {
		return ask3;
	}

	public void setAsk3(String ask3) {
		this.ask3 = ask3;
	}

	public String getAsk4() {
		return ask4;
	}

	public void setAsk4(String ask4) {
		this.ask4 = ask4;
	}

	@Override
	public String toString() {
		return "Askform [res_no=" + res_no + ", res_name=" + res_name + ", ask1=" + ask1 + ", ask2=" + ask2 + ", ask3="
				+ ask3 + ", ask4=" + ask4 + "]";
	}
	
	
}
