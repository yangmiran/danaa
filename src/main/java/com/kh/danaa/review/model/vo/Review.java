package com.kh.danaa.review.model.vo;

import java.sql.Date;

public class Review implements java.io.Serializable {
	private static final long serialVersionUID = 4111L;

	private int review_no; // 후기번호
	private String review_title; // 후기제목
	private String review_writer; // 후기작성자
	private String review_content; // 후기내용
	private String review_original_filename; // 첨부파일 원래이름
	private String review_rename_filename; // 첨부파일 변경이름
	private java.sql.Date review_date; // 작성날짜
	private int review_ref; // 참조원글번호
	private int review_readcount; // 조회수
	
	public Review() {
	}

	public Review(int review_no, String review_title, String review_writer, String review_content,
			String review_original_filename, String review_rename_filename, Date review_date, int review_ref,
			int review_readcount) {
		super();
		this.review_no = review_no;
		this.review_title = review_title;
		this.review_writer = review_writer;
		this.review_content = review_content;
		this.review_original_filename = review_original_filename;
		this.review_rename_filename = review_rename_filename;
		this.review_date = review_date;
		this.review_ref = review_ref;
		this.review_readcount = review_readcount;
	}

	public int getReview_no() {
		return review_no;
	}

	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}

	public String getReview_title() {
		return review_title;
	}

	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}

	public String getReview_writer() {
		return review_writer;
	}

	public void setReview_writer(String review_writer) {
		this.review_writer = review_writer;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public String getReview_original_filename() {
		return review_original_filename;
	}

	public void setReview_original_filename(String review_original_filename) {
		this.review_original_filename = review_original_filename;
	}

	public String getReview_rename_filename() {
		return review_rename_filename;
	}

	public void setReview_rename_filename(String review_rename_filename) {
		this.review_rename_filename = review_rename_filename;
	}

	public java.sql.Date getReview_date() {
		return review_date;
	}

	public void setReview_date(java.sql.Date review_date) {
		this.review_date = review_date;
	}

	public int getReview_ref() {
		return review_ref;
	}

	public void setReview_ref(int review_ref) {
		this.review_ref = review_ref;
	}

	public int getReview_readcount() {
		return review_readcount;
	}

	public void setReview_readcount(int review_readcount) {
		this.review_readcount = review_readcount;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Review [review_no=" + review_no + ", review_title=" + review_title + ", review_writer=" + review_writer
				+ ", review_content=" + review_content + ", review_original_filename=" + review_original_filename
				+ ", review_rename_filename=" + review_rename_filename + ", review_date=" + review_date
				+ ", review_ref=" + review_ref + ", review_readcount=" + review_readcount + "]";
	}
	
	

}