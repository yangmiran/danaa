package com.kh.danaa.qna.model.service;

import java.util.ArrayList;

import com.kh.danaa.qna.model.vo.Qna;

public interface QnaService {
	
	int selectListCount();
	
	ArrayList<Qna> selectListQna(int currentPage, int limit);

	int insertOriginQna(Qna qna);

	Qna selectOneQna(int qna_no);

	int deleteQna(Qna qna);

	int updateOrigin(Qna qna);

	int insertReplyQna(Qna reply);

	int updateReply(Qna qna);

	ArrayList<Qna> selectSearch(String keyword);

	int selectRefCount(int qna_no);
	
	// 미처리 문의 번호
	ArrayList<String> selectNoList();
	
	
}
