package com.kh.danaa.qna.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Qna implements Serializable{
	private static final long serialVersionUID = 2222L;
	
	private int qna_no;
	private String qna_name;
	private int qna_pwd;
	private String qna_phone;
	private String qna_title;
	private Date qna_date;
	private String qna_content;
	private String qna_file;
	private String qna_refile;
	private int qna_level;
	private int qna_ref;
	private String qna_kinds;
	
	public Qna() {}

	public Qna(int qna_no, String qna_name, int qna_pwd, String qna_phone, String qna_title, Date qna_date,
			String qna_content, String qna_file, String qna_refile, int qna_level, int qna_ref, String qna_kinds) {
		super();
		this.qna_no = qna_no;
		this.qna_name = qna_name;
		this.qna_pwd = qna_pwd;
		this.qna_phone = qna_phone;
		this.qna_title = qna_title;
		this.qna_date = qna_date;
		this.qna_content = qna_content;
		this.qna_file = qna_file;
		this.qna_refile = qna_refile;
		this.qna_level = qna_level;
		this.qna_ref = qna_ref;
		this.qna_kinds = qna_kinds;
	}

	public int getQna_no() {
		return qna_no;
	}

	public void setQna_no(int qna_no) {
		this.qna_no = qna_no;
	}

	public String getQna_name() {
		return qna_name;
	}

	public void setQna_name(String qna_name) {
		this.qna_name = qna_name;
	}

	public int getQna_pwd() {
		return qna_pwd;
	}

	public void setQna_pwd(int qna_pwd) {
		this.qna_pwd = qna_pwd;
	}

	public String getQna_phone() {
		return qna_phone;
	}

	public void setQna_phone(String qna_phone) {
		this.qna_phone = qna_phone;
	}

	public String getQna_title() {
		return qna_title;
	}

	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}

	public Date getQna_date() {
		return qna_date;
	}

	public void setQna_date(Date qna_date) {
		this.qna_date = qna_date;
	}

	public String getQna_content() {
		return qna_content;
	}

	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}

	public String getQna_file() {
		return qna_file;
	}

	public void setQna_file(String qna_file) {
		this.qna_file = qna_file;
	}

	public String getQna_refile() {
		return qna_refile;
	}

	public void setQna_refile(String qna_refile) {
		this.qna_refile = qna_refile;
	}

	public int getQna_level() {
		return qna_level;
	}

	public void setQna_level(int qna_level) {
		this.qna_level = qna_level;
	}

	public int getQna_ref() {
		return qna_ref;
	}

	public void setQna_ref(int qna_ref) {
		this.qna_ref = qna_ref;
	}

	public String getQna_kinds() {
		return qna_kinds;
	}

	public void setQna_kinds(String qna_kinds) {
		this.qna_kinds = qna_kinds;
	}

	@Override
	public String toString() {
		return "Qna [qna_no=" + qna_no + ", qna_name=" + qna_name + ", qna_pwd=" + qna_pwd + ", qna_phone=" + qna_phone
				+ ", qna_title=" + qna_title + ", qna_date=" + qna_date + ", qna_content=" + qna_content + ", qna_file="
				+ qna_file + ", qna_refile=" + qna_refile + ", qna_level=" + qna_level + ", qna_ref=" + qna_ref
				+ ", qna_kinds=" + qna_kinds + "]";
	}

	
}
