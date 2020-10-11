package com.kh.danaa.member.model.vo;



import java.sql.Date;
import javax.validation.constraints.Pattern;

/*import org.apache.naming.java.javaURLContextFactory;*/
import org.hibernate.annotations.Entity;
import org.hibernate.validator.constraints.NotEmpty;

//유효성 체크 추가함
@Entity
public class Member implements java.io.Serializable{
	private static final long serialVersionUID = 1111L;
	
	private int member_no;
	//@NotNull은 파라미터 자체가 없을 때를 의미
	@NotEmpty(message="")//key는 있지만 value는 없음
	@Pattern(regexp="^[a-zA-Z0-9]{4,12}$", message="") 
	private String id;
	
	@NotEmpty(message="")
	@Pattern(regexp="^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{6,}$", message="") 
	private String pwd;
	
	@NotEmpty(message="")
	@Pattern(regexp="^[가-힣]{2,6}$", message="") 
	private String name;
	
	//14세 미만의 경우 생략 가능
	//@NotEmpty(message="")
	//@Pattern(regexp="^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$", message="") 
	private String phone;
	
	//String으로 받아서 바로 비교 불가 
	@NotEmpty(message="생년 월일을 입력해주세요")
	private String birth;
		
	@NotEmpty(message="")
	private String gender;
	
	@NotEmpty(message="")
	@Pattern(regexp="^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$", message="") 
	private String email;
	
	//@NotEmpty(message="")
	private String ag_email;
	private java.sql.Date enroll_date;
	private java.sql.Date last_modified;
	private String child;
	private String status;
	
	public Member() {}

	public Member(int member_no, String id, String pwd, String name, String phone, String birth, String gender,
			String email, String ag_email, Date enroll_date, Date last_modified, String child, String status) {
		super();
		this.member_no = member_no;
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.phone = phone;
		this.birth = birth;
		this.gender = gender;
		this.email = email;
		this.ag_email = ag_email;
		this.enroll_date = enroll_date;
		this.last_modified = last_modified;
		this.child = child;
		this.status = status;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setAg_email(String ag_email) {
		this.ag_email = ag_email;
	}

	public void setEnroll_date(java.sql.Date enroll_date) {
		this.enroll_date = enroll_date;
	}

	public void setLast_modified(java.sql.Date last_modified) {
		this.last_modified = last_modified;
	}

	public void setChild(String child) {
		this.child = child;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getMember_no() {
		return member_no;
	}

	public String getId() {
		return id;
	}

	public String getPwd() {
		return pwd;
	}

	public String getName() {
		return name;
	}

	public String getPhone() {
		return phone;
	}

	public String getBirth() {
		return birth;
	}

	public String getGender() {
		return gender;
	}

	public String getEmail() {
		return email;
	}

	public String getAg_email() {
		return ag_email;
	}

	public java.sql.Date getEnroll_date() {
		return enroll_date;
	}

	public java.sql.Date getLast_modified() {
		return last_modified;
	}

	public String getChild() {
		return child;
	}

	public String getStatus() {
		return status;
	}

	@Override
	public String toString() {
		return "Member [member_no=" + member_no + ", id=" + id + ", pwd=" + pwd + ", name=" + name + ", phone=" + phone
				+ ", birth=" + birth + ", gender=" + gender + ", email=" + email + ", ag_email=" + ag_email
				+ ", enroll_date=" + enroll_date + ", last_modified=" + last_modified + ", child=" + child + ", status="
				+ status + "]";
	}

	
	
	
}
