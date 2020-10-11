package com.kh.danaa.recomment.model.vo;

import java.sql.Date;

public class Recomment implements java.io.Serializable {
	private static final long serialVersionUID = 4222L;
	
	private int review_no; // 후기번호
	private int recomment_no; // 댓글번호
	private String recomment_writer; // 댓글작성자
	private String recomment_content; // 댓글내용
	private int recomment_level; // 글레벨
	private int recomment_ref; // 참조원글번호
	private int recomment_reply_ref; // 참조댓글번호
	private int recomment_reply_seq; // 댓글 순번
	private java.sql.Date recomment_date; // 댓글작성날짜
	
	public Recomment() {}

	public Recomment(int review_no, int recomment_no, String recomment_writer, String recomment_content,
			int recomment_level, int recomment_ref, int recomment_reply_ref, int recomment_reply_seq,
			Date recomment_date) {
		super();
		this.review_no = review_no;
		this.recomment_no = recomment_no;
		this.recomment_writer = recomment_writer;
		this.recomment_content = recomment_content;
		this.recomment_level = recomment_level;
		this.recomment_ref = recomment_ref;
		this.recomment_reply_ref = recomment_reply_ref;
		this.recomment_reply_seq = recomment_reply_seq;
		this.recomment_date = recomment_date;
	}

	public int getReview_no() {
		return review_no;
	}

	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}

	public int getRecomment_no() {
		return recomment_no;
	}

	public void setRecomment_no(int recomment_no) {
		this.recomment_no = recomment_no;
	}

	public String getRecomment_writer() {
		return recomment_writer;
	}

	public void setRecomment_writer(String recomment_writer) {
		this.recomment_writer = recomment_writer;
	}

	public String getRecomment_content() {
		return recomment_content;
	}

	public void setRecomment_content(String recomment_content) {
		this.recomment_content = recomment_content;
	}

	public int getRecomment_level() {
		return recomment_level;
	}

	public void setRecomment_level(int recomment_level) {
		this.recomment_level = recomment_level;
	}

	public int getRecomment_ref() {
		return recomment_ref;
	}

	public void setRecomment_ref(int recomment_ref) {
		this.recomment_ref = recomment_ref;
	}

	public int getRecomment_reply_ref() {
		return recomment_reply_ref;
	}

	public void setRecomment_reply_ref(int recomment_reply_ref) {
		this.recomment_reply_ref = recomment_reply_ref;
	}

	public int getRecomment_reply_seq() {
		return recomment_reply_seq;
	}

	public void setRecomment_reply_seq(int recomment_reply_seq) {
		this.recomment_reply_seq = recomment_reply_seq;
	}

	public java.sql.Date getRecomment_date() {
		return recomment_date;
	}

	public void setRecomment_date(java.sql.Date recomment_date) {
		this.recomment_date = recomment_date;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Recomment [review_no=" + review_no + ", recomment_no=" + recomment_no + ", recomment_writer="
				+ recomment_writer + ", recomment_content=" + recomment_content + ", recomment_level=" + recomment_level
				+ ", recomment_ref=" + recomment_ref + ", recomment_reply_ref=" + recomment_reply_ref
				+ ", recomment_reply_seq=" + recomment_reply_seq + ", recomment_date=" + recomment_date + "]";
	}

	
}
