package com.kh.danaa.popup.model.service;

import java.util.ArrayList;

import com.kh.danaa.popup.model.vo.Popup;

public interface PopupService {

	int selectListCount();

	ArrayList<Popup> selectListPopup(int page, int limit);

	int insertPopup(Popup popup);
	
	//팝업삭제
	int deletePopup(int pop_no);

	ArrayList<Popup> selectMainList();
	
	// 제목검색
	ArrayList<Popup> selectNameSearch(String keyword);
	
	//노출여부 검색
	ArrayList<Popup> selectYnSearch(String keyword);
	
	//수정할 번호 선택
	Popup selectPopup(int popup_no);
	
	//수정
	int updatePopstate(Popup popup);
	
}
