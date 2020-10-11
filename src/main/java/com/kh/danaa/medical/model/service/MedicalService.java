package com.kh.danaa.medical.model.service;

import java.util.ArrayList;

import com.kh.danaa.medical.model.vo.Medical;

public interface MedicalService {
	//진료과목 리스트
	ArrayList<Medical> selectList();
	//진료과목 제목으로 검색
	ArrayList<Medical> selectSearchName(String keyword);
	//ArrayList<Medical> selectSearchList(String keyword);
	Medical selectMedical();

}
