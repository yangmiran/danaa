package com.kh.danaa.qna.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.danaa.qna.model.dao.QnaDao;
import com.kh.danaa.qna.model.vo.Qna;

@Service("qnaService")
public class QnaServiceImpl implements QnaService{
	
	@Autowired
	private QnaDao qnaDao;

	@Override
	public int selectListCount() {
		return qnaDao.selectListCount();
	}

	@Override
	public ArrayList<Qna> selectListQna(int currentPage, int limit) {
		return qnaDao.selectListQna(currentPage, limit);
	}

	@Override
	public int insertOriginQna(Qna qna) {
		return qnaDao.insertOriginQna(qna);
	}

	@Override
	public Qna selectOneQna(int qna_no) {
		return qnaDao.selectOneQna(qna_no);
	}

	@Override
	public int deleteQna(Qna qna) {
		return qnaDao.deleteQna(qna);
	}

	@Override
	public int updateOrigin(Qna qna) {
		return qnaDao.updateOrigin(qna);
	}

	@Override
	public int insertReplyQna(Qna reply) {
		return qnaDao.insertReplyQna(reply);
	}

	@Override
	public int updateReply(Qna qna) {
		return qnaDao.updateReply(qna);
	}

	@Override
	public ArrayList<Qna> selectSearch(String keyword) {
		return qnaDao.selectSearch(keyword);
	}

	@Override
	public int selectRefCount(int qna_no) {
		return qnaDao.selectRefCount(qna_no);
	}

	// 미처리 문의글 번호
	@Override
	public ArrayList<String> selectNoList() {
		return qnaDao.selectNoList();
	}

	
}
