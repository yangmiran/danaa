package com.kh.danaa.event.model.vo;

import java.io.Serializable;

public class Event implements Serializable{
	private static final long serialVersionUID = 2227L;
	
	private int event_no;
	private String event_title;
	private String event_content;
	private String event_period;
	private String event_file;
	private String event_thumb;
	private String event_state;
	
	
	public Event() {}


	public Event(int event_no, String event_title, String event_content, String event_period, String event_file,
			String event_thumb, String event_state) {
		super();
		this.event_no = event_no;
		this.event_title = event_title;
		this.event_content = event_content;
		this.event_period = event_period;
		this.event_file = event_file;
		this.event_thumb = event_thumb;
		this.event_state = event_state;
	}


	public int getEvent_no() {
		return event_no;
	}


	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}


	public String getEvent_title() {
		return event_title;
	}


	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}


	public String getEvent_content() {
		return event_content;
	}


	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}


	public String getEvent_period() {
		return event_period;
	}


	public void setEvent_period(String event_period) {
		this.event_period = event_period;
	}


	public String getEvent_file() {
		return event_file;
	}


	public void setEvent_file(String event_file) {
		this.event_file = event_file;
	}


	public String getEvent_thumb() {
		return event_thumb;
	}


	public void setEvent_thumb(String event_thumb) {
		this.event_thumb = event_thumb;
	}


	public String getEvent_state() {
		return event_state;
	}


	public void setEvent_state(String event_state) {
		this.event_state = event_state;
	}


	@Override
	public String toString() {
		return "Event [event_no=" + event_no + ", event_title=" + event_title + ", event_content=" + event_content
				+ ", event_period=" + event_period + ", event_file=" + event_file + ", event_thumb=" + event_thumb
				+ ", event_state=" + event_state + "]";
	}

	
}
