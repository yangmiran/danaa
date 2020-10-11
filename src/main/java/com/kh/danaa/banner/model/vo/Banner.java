package com.kh.danaa.banner.model.vo;

import java.sql.Date;

public class Banner implements java.io.Serializable {
	private static final long serialVersionUID = 3333L;
	
	private int bn_no;
	private String bn_title;
	private java.sql.Date bn_date;
	private String bn_file;
	private String bn_refile;
	private String bn_state;
	
	public Banner() {}

	public Banner(int bn_no, String bn_title, Date bn_date, String bn_file, String bn_refile, String bn_state) {
		super();
		this.bn_no = bn_no;
		this.bn_title = bn_title;
		this.bn_date = bn_date;
		this.bn_file = bn_file;
		this.bn_refile = bn_refile;
		this.bn_state = bn_state;
	}

	public int getBn_no() {
		return bn_no;
	}

	public void setBn_no(int bn_no) {
		this.bn_no = bn_no;
	}

	public String getBn_title() {
		return bn_title;
	}

	public void setBn_title(String bn_title) {
		this.bn_title = bn_title;
	}

	public java.sql.Date getBn_date() {
		return bn_date;
	}

	public void setBn_date(java.sql.Date bn_date) {
		this.bn_date = bn_date;
	}

	public String getBn_file() {
		return bn_file;
	}

	public void setBn_file(String bn_file) {
		this.bn_file = bn_file;
	}

	public String getBn_refile() {
		return bn_refile;
	}

	public void setBn_refile(String bn_refile) {
		this.bn_refile = bn_refile;
	}

	public String getBn_state() {
		return bn_state;
	}

	public void setBn_state(String bn_state) {
		this.bn_state = bn_state;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Banner [bn_no=" + bn_no + ", bn_title=" + bn_title + ", bn_date=" + bn_date + ", bn_file=" + bn_file
				+ ", bn_refile=" + bn_refile + ", bn_state=" + bn_state + "]";
	}

}
