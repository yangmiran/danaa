package com.kh.danaa.qna.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.danaa.qna.model.vo.Qna;
import com.kh.danaa.qna.model.vo.QnaPage;

@Repository("qnaDao")
public class QnaDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public QnaDao() {}
	
	// 총 갯수
	public int selectListCount() {
		return session.selectOne("qnaMapper.selectListCount");
	}
	
	// 목록조회
	public ArrayList<Qna> selectListQna(int currentPage, int limit){
		int startRow = (currentPage-1) *limit +1;
		int endRow = startRow + limit -1;
		QnaPage qpage = new QnaPage(startRow, endRow);
		
		List<Qna> list = session.selectList("qnaMapper.selectListQna", qpage);
		return (ArrayList<Qna>) list;
	}
	// 문의글 등록
	public int insertOriginQna(Qna qna) {
		return session.insert("qnaMapper.insertOriginQna", qna);
	}
	// 문의글 한개 선택
	public Qna selectOneQna(int qna_no) {
		return session.selectOne("qnaMapper.selectOneQna", qna_no);
	}
	// 원글 삭제
	public int deleteQna(Qna qna) {
		return session.delete("qnaMapper.deleteQna", qna);
	}
	// 원글 수정
	public int updateOrigin(Qna qna) {
		return session.update("qnaMapper.updateOrigin", qna);
	}
	// 댓글 등록
	public int insertReplyQna(Qna reply) {
		return session.insert("qnaMapper.insertReplyQna", reply);
	}
	// 댓글 수정
	public int updateReply(Qna qna) {
		return session.update("qnaMapper.updateReply", qna);
	}
	//검색
	public ArrayList<Qna> selectSearch(String keyword) {
		List<Qna> list = session.selectList("qnaMapper.selectSearch",keyword);
		return (ArrayList<Qna>) list;
	}

	public int selectRefCount(int qna_no) {
		return session.selectOne("qnaMapper.selectRefCount", qna_no);
	}

	// 미처리 문의글 번호
	public ArrayList<String> selectNoList() {
		List<String> qnano = session.selectList("qnaMapper.selectNoList");
		return (ArrayList<String>) qnano;
	}

}
