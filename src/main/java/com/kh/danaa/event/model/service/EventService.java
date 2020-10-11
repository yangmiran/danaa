package com.kh.danaa.event.model.service;

import java.util.ArrayList;

import com.kh.danaa.event.model.vo.Event;

public interface EventService {

	int selectListCount();

	ArrayList<Event> selectListEvent(int currentPage, int limit);

	Event selectEvent(int event_no);

	//Event selectPrev(int event_no);

	//Event selectNext(int event_no);

	//Event selectPrevPrev(int event_no);

	//Event selectNextNext(int event_no);

	ArrayList<Event> selectSearch(String keyword);

	int selectProceedCount();

	ArrayList<Event> selectProceedEvent(int currentPage, int limit);

	int selectEndCount();

	ArrayList<Event> selectEndEvent(int currentPage, int limit);

	int insertEvent(Event event);

	ArrayList<Event> selectDetail(int event_no);

	int deleteEvent(Event event);

	int updateEvent(Event event);
	
	ArrayList<Event> selectMainEvent();
}
