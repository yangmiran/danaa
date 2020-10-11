package com.kh.danaa.admin.model.vo;

public class Admin implements java.io.Serializable {

	private static final long serialVersionUID = 3222L;
	
	private String admin_name;
	private String admin_person;
	private String admin_no;
	private String admin_tel;
	private String admin_fax;
	private String admin_add;
	private String admin_time;
	
	public Admin() {}

	public Admin(String admin_name, String admin_person, String admin_no, String admin_tel, String admin_fax,
			String admin_add, String admin_time) {
		super();
		this.admin_name = admin_name;
		this.admin_person = admin_person;
		this.admin_no = admin_no;
		this.admin_tel = admin_tel;
		this.admin_fax = admin_fax;
		this.admin_add = admin_add;
		this.admin_time = admin_time;
	}

	public String getAdmin_name() {
		return admin_name;
	}

	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}

	public String getAdmin_person() {
		return admin_person;
	}

	public void setAdmin_person(String admin_person) {
		this.admin_person = admin_person;
	}

	public String getAdmin_no() {
		return admin_no;
	}

	public void setAdmin_no(String admin_no) {
		this.admin_no = admin_no;
	}

	public String getAdmin_tel() {
		return admin_tel;
	}

	public void setAdmin_tel(String admin_tel) {
		this.admin_tel = admin_tel;
	}

	public String getAdmin_fax() {
		return admin_fax;
	}

	public void setAdmin_fax(String admin_fax) {
		this.admin_fax = admin_fax;
	}

	public String getAdmin_add() {
		return admin_add;
	}

	public void setAdmin_add(String admin_add) {
		this.admin_add = admin_add;
	}

	public String getAdmin_time() {
		return admin_time;
	}

	public void setAdmin_time(String admin_time) {
		this.admin_time = admin_time;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Admin [admin_name=" + admin_name + ", admin_person=" + admin_person + ", admin_no=" + admin_no
				+ ", admin_tel=" + admin_tel + ", admin_fax=" + admin_fax + ", admin_add=" + admin_add + ", admin_time="
				+ admin_time + "]";
	};
	
	
}
