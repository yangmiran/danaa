package com.kh.danaa.reservation.model.vo;

import java.sql.Date;

public class Reservation implements java.io.Serializable {
	private static final long serialVersionUID = 5554L;
	
	private int res_no;
	private String res_name;
	private String res_birth;
	private String res_gender;
	private String res_phone;
	private String res_email;
	private int res_doctor;
	private Date res_date;
	private String res_time;
	private String res_content;
	private int res_status;
	private String res_passwd;
	private String member_id;	
	
	public Reservation() {}
	
	public Reservation(int res_doctor, Date res_date, String res_time) {
		super();
		this.res_doctor = res_doctor;
		this.res_date = res_date;
		this.res_time = res_time;
	}

	public Reservation(int res_no, String res_name, String res_birth, String res_gender, String res_phone,
			String res_email, int res_doctor, Date res_date, String res_time, String res_content, int res_status,
			String res_passwd, String member_id) {
		super();
		this.res_no = res_no;
		this.res_name = res_name;
		this.res_birth = res_birth;
		this.res_gender = res_gender;
		this.res_phone = res_phone;
		this.res_email = res_email;
		this.res_doctor = res_doctor;
		this.res_date = res_date;
		this.res_time = res_time;
		this.res_content = res_content;
		this.res_status = res_status;
		this.res_passwd = res_passwd;
		this.member_id = member_id;
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

	public String getRes_birth() {
		return res_birth;
	}

	public void setRes_birth(String res_birth) {
		this.res_birth = res_birth;
	}

	public String getRes_gender() {
		return res_gender;
	}

	public void setRes_gender(String res_gender) {
		this.res_gender = res_gender;
	}

	public String getRes_phone() {
		return res_phone;
	}

	public void setRes_phone(String res_phone) {
		this.res_phone = res_phone;
	}

	public String getRes_email() {
		return res_email;
	}

	public void setRes_email(String res_email) {
		this.res_email = res_email;
	}

	public int getRes_doctor() {
		return res_doctor;
	}

	public void setRes_doctor(int res_doctor) {
		this.res_doctor = res_doctor;
	}

	public Date getRes_date() {
		return res_date;
	}

	public void setRes_date(Date res_date) {
		this.res_date = res_date;
	}

	public String getRes_time() {
		return res_time;
	}

	public void setRes_time(String res_time) {
		this.res_time = res_time;
	}

	public String getRes_content() {
		return res_content;
	}

	public void setRes_content(String res_content) {
		this.res_content = res_content;
	}

	public int getRes_status() {
		return res_status;
	}

	public void setRes_status(int res_status) {
		this.res_status = res_status;
	}

	public String getRes_passwd() {
		return res_passwd;
	}

	public void setRes_passwd(String res_passwd) {
		this.res_passwd = res_passwd;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	@Override
	public String toString() {
		return "Reservation [res_no=" + res_no + ", res_name=" + res_name + ", res_birth=" + res_birth + ", res_gender="
				+ res_gender + ", res_phone=" + res_phone + ", res_email=" + res_email + ", res_doctor=" + res_doctor
				+ ", res_date=" + res_date + ", res_time=" + res_time + ", res_content=" + res_content + ", res_status="
				+ res_status + ", res_passwd=" + res_passwd + ", member_id=" + member_id + "]";
	}
	
	
}
