package com.kh.danaa.popup.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Popup implements Serializable{
	private static final long serialVersionUID = 2229L;
	
	
	private int popup_no;
	private String popup_title;
	private Date popup_date;
	private String popup_file;
	private String popup_refile;
	private int popup_state;
	
	public Popup() {}

	public Popup(int popup_no, String popup_title, Date popup_date, String popup_file, String popup_refile,
			int popup_state) {
		super();
		this.popup_no = popup_no;
		this.popup_title = popup_title;
		this.popup_date = popup_date;
		this.popup_file = popup_file;
		this.popup_refile = popup_refile;
		this.popup_state = popup_state;
	}

	public int getPopup_no() {
		return popup_no;
	}

	public void setPopup_no(int popup_no) {
		this.popup_no = popup_no;
	}

	public String getPopup_title() {
		return popup_title;
	}

	public void setPopup_title(String popup_title) {
		this.popup_title = popup_title;
	}

	public Date getPopup_date() {
		return popup_date;
	}

	public void setPopup_date(Date popup_date) {
		this.popup_date = popup_date;
	}

	public String getPopup_file() {
		return popup_file;
	}

	public void setPopup_file(String popup_file) {
		this.popup_file = popup_file;
	}

	public String getPopup_refile() {
		return popup_refile;
	}

	public void setPopup_refile(String popup_refile) {
		this.popup_refile = popup_refile;
	}

	public int getPopup_state() {
		return popup_state;
	}

	public void setPopup_state(int popup_state) {
		this.popup_state = popup_state;
	}

	@Override
	public String toString() {
		return "Popup [popup_no=" + popup_no + ", popup_title=" + popup_title + ", popup_date=" + popup_date
				+ ", popup_file=" + popup_file + ", popup_refile=" + popup_refile + ", popup_state=" + popup_state
				+ "]";
	}

}
