package com.kh.danaa.notice.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.danaa.notice.model.dao.NoticeDao;
import com.kh.danaa.notice.model.vo.Notice;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	private NoticeDao noticeDao;

	@Override
	public int selectListCount() {
		return noticeDao.selectListCount();
	}

	@Override
	public ArrayList<Notice> selectListNotice(int currentPage, int limit) {
		return noticeDao.selectListNotice(currentPage, limit);
	}

	@Override
	public int insertNotice(Notice notice) {
		return noticeDao.insertNotice(notice);
	}

	@Override
	public int updateReadCount(int notice_no) {
		return noticeDao.updateReadCount(notice_no);
	}

	@Override
	public Notice selectNotice(int notice_no) {
		return noticeDao.selectNotice(notice_no);
	}

	@Override
	public int deleteNotice(Notice notice) {
		return noticeDao.deleteNotice(notice);
	}

	@Override
	public int updateNotice(Notice notice) {
		return noticeDao.updateNotice(notice);
	}

	/*
	 * @Override public Notice selectNext(int notice_no) { return
	 * noticeDao.selectNext(notice_no); }
	 * 
	 * @Override public Notice selectPrev(int notice_no) { return
	 * noticeDao.selectPrev(notice_no); }
	 * 
	 * @Override public Notice selectPrevPrev(int notice_no) { return
	 * noticeDao.selectPrevPrev(notice_no); }
	 * 
	 * @Override public Notice selectNextNext(int notice_no) { return
	 * noticeDao.selectNextNext(notice_no); }
	 */

	@Override
	public ArrayList<Notice> selectSearch(String keyword) {
		return noticeDao.selectSearch(keyword);
	}

	@Override
	public ArrayList<Notice> selectDetail(int notice_no) {
		return noticeDao.selectDetail(notice_no);
	}

	@Override
	public ArrayList<Notice> selectNewTop5() {
		return noticeDao.selectNewTop5();
	}
}
