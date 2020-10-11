package com.kh.danaa.medical.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.danaa.medical.model.dao.MedicalDao;
import com.kh.danaa.medical.model.vo.Medical;

@Service("medicalService")
public class MedicalServiceImpl implements MedicalService {
	
	@Autowired
	private MedicalDao medicalDao;
	
	//진료과목 리스트
	@Override
	public ArrayList<Medical> selectList(){
		return medicalDao.selectList();
	}
	
	//진료과목 제목으로 검색
	@Override
	public ArrayList<Medical> selectSearchName(String keyword) {
		return medicalDao.selectSearchName(keyword);
	}

	@Override
	public Medical selectMedical() {
		return medicalDao.selectMedical();
	}
	
//	@Override
//	public ArrayList<Medical> selectSearchList(String keyword){
//		return medicalDao.selectSearchList(keyword);
//	}
}
