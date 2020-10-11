package com.kh.danaa.doctor.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.danaa.doctor.model.dao.DoctorDao;
import com.kh.danaa.doctor.model.vo.Doctor;

@Service("doctorService")
public class DoctorServiceImpl implements DoctorService {

	@Autowired
	private DoctorDao doctorDao;

	@Override
	public ArrayList<Doctor> selectDoctor() {
		return doctorDao.selectDoctor();
	}

	@Override
	public Doctor selectOne(int doc_no) {
		return doctorDao.selectOne(doc_no);
	}

	@Override
	public int updateDoctor(Doctor doctor) {
		return doctorDao.updateDoctor(doctor);
	}
}
