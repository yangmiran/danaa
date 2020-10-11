package com.kh.danaa.recomment.model.service;

import java.util.ArrayList;
import com.kh.danaa.recomment.model.vo.Recomment;

public interface RecommentService {

	ArrayList<Recomment> selectList(int recomment_ref);
	
	int count(int recomment_no);
	
	int insertRecomment1(Recomment recomment);
	
	int insertRecomment2(Recomment recomment);

	int updateRecomment(Recomment recomment);
	
	int deleteRecomment(int recomment_no);

}
