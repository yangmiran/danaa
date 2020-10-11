package com.kh.danaa.medical.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.danaa.medical.model.vo.Medical;


@Repository("medicalDao")
public class MedicalDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public MedicalDao() {}
	
	//진료과목 리스트
	public ArrayList<Medical> selectList() {
		List<Medical> list = session.selectList("medicalMapper.selectList");
		return (ArrayList<Medical>)list;
	}
	
	//진료과목 제목으로 검색
	public ArrayList<Medical> selectSearchName(String keyword) {
		List<Medical> list = session.selectList("medicalMapper.selectSearchName", keyword);
		return (ArrayList<Medical>)list;
	}


	public Medical selectMedical() {
		return session.selectOne("medicalMapper.selectMedical");
	}


}
