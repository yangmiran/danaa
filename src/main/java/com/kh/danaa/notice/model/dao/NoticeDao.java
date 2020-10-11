package com.kh.danaa.notice.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.danaa.notice.model.vo.Notice;
import com.kh.danaa.notice.model.vo.NoticePage;


@Repository("noticeDao")
public class NoticeDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public NoticeDao() {}
	
	//총 갯수
	public int selectListCount() {
		return session.selectOne("noticeMapper.selectListCount");
	}
	
	//목록조회
	public ArrayList<Notice> selectListNotice(int currentPage, int limit) {
		int startRow = (currentPage-1) *limit +1;
		int endRow = startRow + limit -1;
		NoticePage npage = new NoticePage(startRow, endRow);
		
		List<Notice> list = session.selectList("noticeMapper.selectListNotice", npage);
		return (ArrayList<Notice>) list;
	}
	
	//공지글 등록
	public int insertNotice(Notice notice) {
		return session.insert("noticeMapper.insertNotice", notice);
	}
	//조회수 +1
	public int updateReadCount(int notice_no) {
		return session.update("noticeMapper.updateReadCount", notice_no);
	}
	//공지글 1개 선택
	public Notice selectNotice(int notice_no) {
		return session.selectOne("noticeMapper.selectNotice", notice_no);
	}
	//삭제
	public int deleteNotice(Notice notice) {
		return session.delete("noticeMapper.deleteNotice", notice);
	}
	//수정
	public int updateNotice(Notice notice) {
		return session.update("noticeMapper.updateNotice", notice);
	}

	/*
	 * public Notice selectNext(int notice_no) { return
	 * session.selectOne("noticeMapper.selectNext", notice_no); }
	 * 
	 * public Notice selectPrev(int notice_no) { return
	 * session.selectOne("noticeMapper.selectPrev", notice_no); }
	 * 
	 * public Notice selectPrevPrev(int notice_no) { return
	 * session.selectOne("noticeMapper.selectPrevPrev", notice_no); }
	 * 
	 * public Notice selectNextNext(int notice_no) { return
	 * session.selectOne("noticeMapper.selectNextNext", notice_no); }
	 */
	//검색
	public ArrayList<Notice> selectSearch(String keyword) {
		List<Notice> list = session.selectList("noticeMapper.selectSearch", keyword);
		return (ArrayList<Notice>) list;
	}
	//상세보기(이전,현재,다음글)
	public ArrayList<Notice> selectDetail(int notice_no) {
		List<Notice> list = session.selectList("noticeMapper.selectDetail", notice_no);
		return (ArrayList<Notice>) list;
	}
	
	public ArrayList<Notice> selectNewTop5() {
		List<Notice> list = session.selectList("noticeMapper.selectNewTop5");
		return (ArrayList<Notice>) list;
	}
	
}
