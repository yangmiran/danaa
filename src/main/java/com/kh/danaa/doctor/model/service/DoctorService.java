package com.kh.danaa.doctor.model.service;

import java.util.ArrayList;
import com.kh.danaa.doctor.model.vo.Doctor;

public interface DoctorService {

	ArrayList<Doctor> selectDoctor();

	Doctor selectOne(int doc_name);

	int updateDoctor(Doctor doctor);

}
