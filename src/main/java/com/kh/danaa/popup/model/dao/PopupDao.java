package com.kh.danaa.popup.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.danaa.popup.model.vo.Popup;
import com.kh.danaa.popup.model.vo.PopupPage;

@Repository("popupDao")
public class PopupDao {

	@Autowired
	private SqlSessionTemplate session;
	
	private PopupDao() {}

	// 총갯수
	public int selectListCount() {
		return session.selectOne("popupMapper.selectListCount");
	}
	//목록조회
	public ArrayList<Popup> selectListPopup(int page, int limit) {
		int startRow = (page-1) *limit +1;
		int endRow = startRow + limit -1;
		PopupPage ppage = new PopupPage(startRow, endRow);
		
		List<Popup> list = session.selectList("popupMapper.selectListPopup", ppage);
		return (ArrayList<Popup>) list;
	}

	public int insertPopup(Popup popup) {
		return session.insert("popupMapper.insertPopup", popup);
	}

	public int deletePopup(int pop_no) {
		return session.delete("popupMapper.deletePopup", pop_no);
	}

	public ArrayList<Popup> selectMainList() {
		List<Popup> plist = session.selectList("popupMapper.selectMainList");
		return (ArrayList<Popup>) plist;
	}
	// 제목검색
	public ArrayList<Popup> selectNameSearch(String keyword) {
		List<Popup> list = session.selectList("popupMapper.selectNameSearch", keyword);
		return (ArrayList<Popup>) list;
	}
	// 노출여부검색
	public ArrayList<Popup> selectYnSearch(String keyword) {
		List<Popup> list = session.selectList("popupMapper.selectYnSearch", keyword);
		return (ArrayList<Popup>) list;
	}

	public int updatePopstate(Popup popup) {
		return session.update("popupMapper.updatePopstate", popup);
	}

	public Popup selectPopup(int popup_no) {
		return session.selectOne("popupMapper.selectPopup", popup_no);
	}

}
