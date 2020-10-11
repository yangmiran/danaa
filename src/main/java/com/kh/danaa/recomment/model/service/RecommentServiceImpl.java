package com.kh.danaa.recomment.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.danaa.recomment.model.dao.RecommentDao;
import com.kh.danaa.recomment.model.vo.Recomment;

@Service("recommentService")
public class RecommentServiceImpl implements RecommentService {
	@Autowired
	private RecommentDao recommentDao;

	@Override
	public ArrayList<Recomment> selectList(int recomment_ref) {
		return recommentDao.selectList(recomment_ref);
	}

	@Override
	public int insertRecomment1(Recomment recomment) {
		return recommentDao.insertRecomment1(recomment);
	}
	
	@Override
	public int insertRecomment2(Recomment recomment) {
		return recommentDao.insertRecomment2(recomment);
	}

	@Override
	public int updateRecomment(Recomment recomment) {
		return recommentDao.updateRecomment(recomment);
	}
	
	@Override
	public int deleteRecomment(int recomment_no) {
		return recommentDao.deleteRecomment(recomment_no);
	}
	
	@Override
	public int count(int recomment_no) {
		return 0;
	}

	


	

}
