package com.kh.danaa.event.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.danaa.event.model.vo.Event;
import com.kh.danaa.event.model.vo.EventPage;


@Repository("eventDao")
public class EventDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public EventDao() {}
	
	// 총갯수
	public int selectListCount() {
		return session.selectOne("eventMapper.selectListCount");
	}
	
	// 목록조회
	public ArrayList<Event> selectListEvent(int currentPage, int limit) {
		int startRow = (currentPage-1) *limit +1;
		int endRow = startRow + limit -1;
		EventPage epage = new EventPage(startRow, endRow);
		
		List<Event> list = session.selectList("eventMapper.selectListEvent", epage);
		return (ArrayList<Event>) list;
	}
	// 현재 글선택
	public Event selectEvent(int event_no) {
		return session.selectOne("eventMapper.selectEvent", event_no);
	}

	/*
	 * // 이전 글 선택 public Event selectPrev(int event_no) { return
	 * session.selectOne("eventMapper.selectPrev", event_no); } // 다음 글 선택 public
	 * Event selectNext(int event_no) { return
	 * session.selectOne("eventMapper.selectNext", event_no); } // 전 전글 public Event
	 * selectPrevPrev(int event_no) { return
	 * session.selectOne("eventMapper.selectPrevPrev", event_no);
	 * 
	 * } // 다 다음글 public Event selectNextNext(int event_no) { return
	 * session.selectOne("eventMapper.selectNextNext", event_no); }
	 */
	
	// 글 검색
	public ArrayList<Event> selectSearch(String keyword) {
		List<Event> list = session.selectList("eventMapper.selectSearch", keyword);
		return (ArrayList<Event>) list;
	}
	// 진행중인 이벤트 갯수
	public int selectProceedCount() {
		return session.selectOne("eventMapper.selectProceedCount");
	}
	// 진행중인 이벤트
	public ArrayList<Event> selectProceedEvent(int currentPage, int limit) {
		int startRow = (currentPage-1) *limit +1;
		int endRow = startRow + limit -1;
		EventPage epage = new EventPage(startRow, endRow);
		
		List<Event> list = session.selectList("eventMapper.selectProceedEvent", epage);
		return (ArrayList<Event>) list;
	}

	public int selectEndCount() {
		return session.selectOne("eventMapper.selectEndCount");
	}

	public ArrayList<Event> selectEndEvent(int currentPage, int limit) {
		int startRow = (currentPage-1) *limit +1;
		int endRow = startRow + limit -1;
		EventPage epage = new EventPage(startRow, endRow);
		
		List<Event> list = session.selectList("eventMapper.selectEndEvent", epage);
		return (ArrayList<Event>) list;
	}
	// 이벤트 등록
	public int insertEvent(Event event) {
		return session.insert("eventMapper.insertEvent", event);
	}

	public ArrayList<Event> selectDetail(int event_no) {
		List<Event> list = session.selectList("eventMapper.selectDetail", event_no);
		return (ArrayList<Event>) list;
	}

	public int deleteEvent(Event event) {
		return session.delete("eventMapper.deleteEvent", event);
	}

	public int updateEvent(Event event) {
		return session.update("eventMapper.updateEvent", event);
	}
	
	public ArrayList<Event> selectMainEvent() {
		List<Event> evlist = session.selectList("eventMapper.selectMainEvent");
		return (ArrayList<Event>) evlist;
	}
	
}
