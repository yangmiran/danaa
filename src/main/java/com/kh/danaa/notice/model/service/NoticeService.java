package com.kh.danaa.notice.model.service;

import java.util.ArrayList;

import com.kh.danaa.notice.model.vo.Notice;

public interface NoticeService {

	int selectListCount();

	ArrayList<Notice> selectListNotice(int currentPage, int limit);

	int insertNotice(Notice notice);
	
	int updateReadCount(int notice_no);
	
	Notice selectNotice(int notice_no);

	int deleteNotice(Notice notice);

	int updateNotice(Notice notice);

	//Notice selectNext(int notice_no);

	//Notice selectPrev(int notice_no);

	//Notice selectPrevPrev(int notice_no);

	//Notice selectNextNext(int notice_no);

	ArrayList<Notice> selectSearch(String keyword);

	ArrayList<Notice> selectDetail(int notice_no);

	ArrayList<Notice> selectNewTop5();
	


}
