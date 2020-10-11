package com.kh.danaa.notice.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Notice implements Serializable{
	private static final long serialVersionUID = 2225;
	
	private int notice_no;
	private String notice_title;
	private String notice_writer;
	private Date notice_date;
	private String notice_content;
	private int notice_readcount;
	private String notice_file;
	private String notice_refile;
	
	public Notice() {}

	public Notice(int notice_no, String notice_title, String notice_writer, Date notice_date, String notice_content,
			int notice_readcount, String notice_file, String notice_refile) {
		super();
		this.notice_no = notice_no;
		this.notice_title = notice_title;
		this.notice_writer = notice_writer;
		this.notice_date = notice_date;
		this.notice_content = notice_content;
		this.notice_readcount = notice_readcount;
		this.notice_file = notice_file;
		this.notice_refile = notice_refile;
	}

	public int getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public String getNotice_writer() {
		return notice_writer;
	}

	public void setNotice_writer(String notice_writer) {
		this.notice_writer = notice_writer;
	}

	public Date getNotice_date() {
		return notice_date;
	}

	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public int getNotice_readcount() {
		return notice_readcount;
	}

	public void setNotice_readcount(int notice_readcount) {
		this.notice_readcount = notice_readcount;
	}

	public String getNotice_file() {
		return notice_file;
	}

	public void setNotice_file(String notice_file) {
		this.notice_file = notice_file;
	}

	public String getNotice_refile() {
		return notice_refile;
	}

	public void setNotice_refile(String notice_refile) {
		this.notice_refile = notice_refile;
	}

	@Override
	public String toString() {
		return "Notice [notice_no=" + notice_no + ", notice_title=" + notice_title + ", notice_writer=" + notice_writer
				+ ", notice_date=" + notice_date + ", notice_content=" + notice_content + ", notice_readcount="
				+ notice_readcount + ", notice_file=" + notice_file + ", notice_refile=" + notice_refile + "]";
	}

	
}
