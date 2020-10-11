package com.kh.danaa.recomment.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.danaa.recomment.model.vo.Recomment;

@Repository("recommentDao")
public class RecommentDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public RecommentDao() {}

	public ArrayList<Recomment> selectList(int review_ref) {
		List<Recomment> list = session.selectList("recommentMapper.selectList",review_ref);
		return (ArrayList<Recomment>) list;
	}

	public int insertRecomment1(Recomment recomment) {
		return session.insert("recommentMapper.insertRecomment1",recomment);
	}
	
	public int insertRecomment2(Recomment recomment) {
		return session.insert("recommentMapper.insertRecomment2",recomment);
	}

	public int updateRecomment(Recomment recomment) {
		return session.update("recommentMapper.updateRecomment",recomment);
	}

	public int deleteRecomment(int recomment_no) {
		return session.delete("recommentMapper.deleteRecomment", recomment_no);
	}

	public int count(int recomment_no) {
		return 0;
	}
	

}
