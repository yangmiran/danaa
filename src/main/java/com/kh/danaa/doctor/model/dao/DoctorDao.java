package com.kh.danaa.doctor.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.danaa.doctor.model.vo.Doctor;

@Repository("doctorDao")
public class DoctorDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public DoctorDao() {}

	public ArrayList<Doctor> selectDoctor() {
		List<Doctor> list = session.selectList("doctorMapper.selectDoctor");
		return (ArrayList<Doctor>)list;
	}

	public Doctor selectOne(int doc_no) {
		return session.selectOne("doctorMapper.selectOne", doc_no);
	}

	public int updateDoctor(Doctor doctor) {
		return session.update("doctorMapper.updateDoctor", doctor);
	}
	
	
}
