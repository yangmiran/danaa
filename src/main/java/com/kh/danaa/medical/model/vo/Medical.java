package com.kh.danaa.medical.model.vo;


public class Medical implements java.io.Serializable {
	
	private static final long serialVersionUID = 3111L;
	
	private int md_num;
	private String md_name;
	private String md_tag;
	private String md_cont;
	private String md_filename;
	
	public Medical() {}

	public Medical(int md_num, String md_name, String md_tag, String md_cont, String md_filename) {
		super();
		this.md_num = md_num;
		this.md_name = md_name;
		this.md_tag = md_tag;
		this.md_cont = md_cont;
		this.md_filename = md_filename;
	}

	public int getMd_num() {
		return md_num;
	}

	public void setMd_num(int md_num) {
		this.md_num = md_num;
	}

	public String getMd_name() {
		return md_name;
	}

	public void setMd_name(String md_name) {
		this.md_name = md_name;
	}

	public String getMd_tag() {
		return md_tag;
	}

	public void setMd_tag(String md_tag) {
		this.md_tag = md_tag;
	}

	public String getMd_cont() {
		return md_cont;
	}

	public void setMd_cont(String md_cont) {
		this.md_cont = md_cont;
	}

	public String getMd_filename() {
		return md_filename;
	}

	public void setMd_filename(String md_filename) {
		this.md_filename = md_filename;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Medical [md_num=" + md_num + ", md_name=" + md_name + ", md_tag=" + md_tag + ", md_cont=" + md_cont
				+ ", md_filename=" + md_filename + "]";
	}


}
