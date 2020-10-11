package com.kh.danaa.popup.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.danaa.popup.model.dao.PopupDao;
import com.kh.danaa.popup.model.vo.Popup;

@Service("popupService")
public class PopupServiceImpl implements PopupService{

	@Autowired
	private PopupDao popupDao;

	@Override
	public int selectListCount() {
		return popupDao.selectListCount();
	}

	@Override
	public ArrayList<Popup> selectListPopup(int page, int limit) {
		return popupDao.selectListPopup(page, limit);
	}

	@Override
	public int insertPopup(Popup popup) {
		return popupDao.insertPopup(popup);
	}
	
	//삭제
	@Override
	public int deletePopup(int pop_no) {
		return popupDao.deletePopup(pop_no);
	}

	@Override
	public ArrayList<Popup> selectMainList() {
		return popupDao.selectMainList();
	}

	@Override
	public ArrayList<Popup> selectNameSearch(String keyword) {
		return popupDao.selectNameSearch(keyword);
	}

	@Override
	public ArrayList<Popup> selectYnSearch(String keyword) {
		return popupDao.selectYnSearch(keyword);
	}

	//수정
	@Override
	public int updatePopstate(Popup popup) {
		return popupDao.updatePopstate(popup);
	}

	@Override
	public Popup selectPopup(int popup_no) {
		return popupDao.selectPopup(popup_no);
	}

}
