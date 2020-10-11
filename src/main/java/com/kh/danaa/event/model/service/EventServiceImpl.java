package com.kh.danaa.event.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.danaa.event.model.dao.EventDao;
import com.kh.danaa.event.model.vo.Event;


@Service("eventService")
public class EventServiceImpl implements EventService{
	
	@Autowired
	private EventDao eventDao;

	@Override
	public int selectListCount() {
		return eventDao.selectListCount();
	}

	@Override
	public ArrayList<Event> selectListEvent(int currentPage, int limit) {
		return eventDao.selectListEvent(currentPage, limit);
	}

	@Override
	public Event selectEvent(int event_no) {
		return eventDao.selectEvent(event_no);
	}

	/*
	 * @Override public Event selectPrev(int event_no) { return
	 * eventDao.selectPrev(event_no); }
	 * 
	 * @Override public Event selectNext(int event_no) { return
	 * eventDao.selectNext(event_no); }
	 * 
	 * @Override public Event selectPrevPrev(int event_no) { return
	 * eventDao.selectPrevPrev(event_no); }
	 * 
	 * @Override public Event selectNextNext(int event_no) { return
	 * eventDao.selectNextNext(event_no); }
	 */
	
	@Override
	public ArrayList<Event> selectSearch(String keyword) {
		return eventDao.selectSearch(keyword);
	}

	@Override
	public int selectProceedCount() {
		return eventDao.selectProceedCount();
	}

	@Override
	public ArrayList<Event> selectProceedEvent(int currentPage, int limit) {
		return eventDao.selectProceedEvent(currentPage, limit);
	}

	@Override
	public int selectEndCount() {
		return eventDao.selectEndCount();
	}

	@Override
	public ArrayList<Event> selectEndEvent(int currentPage, int limit) {
		return eventDao.selectEndEvent(currentPage, limit);
	}

	@Override
	public int insertEvent(Event event) {
		return eventDao.insertEvent(event);
	}

	@Override
	public ArrayList<Event> selectDetail(int event_no) {
		return eventDao.selectDetail(event_no);
	}

	@Override
	public int deleteEvent(Event event) {
		return eventDao.deleteEvent(event);
	}

	@Override
	public int updateEvent(Event event) {
		return eventDao.updateEvent(event);
	}
	
	@Override
	public ArrayList<Event> selectMainEvent() {
		return eventDao.selectMainEvent();
	}
}












