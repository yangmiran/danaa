package com.kh.danaa.event.controller;

import java.io.File;
import java.io.IOException;
//import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.danaa.event.model.service.EventService;
import com.kh.danaa.event.model.vo.Event;


@Controller
public class EventController {

	@Autowired
	private EventService eventService;

	// =========================== 페이지이동.s ===========================
	@RequestMapping("moveEwrite.do")
	public String moveEventWrite() {
		return "event/eventWriteForm";
	}

	@RequestMapping("eUpView.do")
	public String moveUpdat(@RequestParam("currentPage") String currentPage, Event event, Model model) {

		event = eventService.selectEvent(event.getEvent_no());

		//logger.info("값확인: " + event);

		model.addAttribute("event", event);
		return "event/eventUpdateForm";
	}

	// =========================== 페이지이동.e ===========================

	@RequestMapping("elist.do")
	public ModelAndView eventList(@RequestParam("page") int currentPage, ModelAndView mv) {
		// 한페이지에서 출력될 갯수
		int limit = 6;

		// 전체목록갯수
		int listCount = eventService.selectListCount();

		// 현재 페이지에 출력할 게시글 목록
		ArrayList<Event> list = eventService.selectListEvent(currentPage, limit);

		// 뷰에 출력될 총 페이지 수 계산식
		int maxPage = (int) (((double) listCount / limit) + 0.9);

		// 현재 페이지가 속한 그룹의 시작페이지 수 지정
		int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;
		int endPage = startPage + limit - 1;

		if (maxPage < endPage) {
			endPage = maxPage;
		}
		// 내보내기
		if (list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("currentPage", currentPage);
			mv.addObject("maxPage", maxPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("listCount", listCount);
			mv.setViewName("event/eventListView");
		} else {
			mv.addObject("message", currentPage + "페이지에 대한 목록 조회 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 상세보기 (이전글, 현재글, 다음글 상세보기 처리)
	@RequestMapping("edetail.do")
	public ModelAndView moveEventDetail(
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam("event_no") int event_no, ModelAndView mv) {
		// 게시글 상세보기
		// Event event = eventService.selectEvent(event_no);
		ArrayList<Event> detailList = eventService.selectDetail(event_no);

		if (detailList.size() == 3) { // 이전글, 현재글, 다음글이 있는 경우
			mv.addObject("event", detailList.get(1));
			mv.addObject("prevEvent", detailList.get(0));
			mv.addObject("nextEvent", detailList.get(2));
			mv.addObject("currentPage", currentPage);
			mv.setViewName("event/eventDetailView");
		} else if (detailList.size() == 2) { // 현재글은 있고 이전글/다음글이 없는 경우 중
			if (detailList.get(0).getEvent_no() < event_no) { // if 다음글이 없는 경우
				mv.addObject("event", detailList.get(1));
				mv.addObject("prevEvent", detailList.get(0));
			}
			if (detailList.get(0).getEvent_no() == event_no) { // if 이전글이 없는 경우
				mv.addObject("event", detailList.get(0));
				mv.addObject("nextEvent", detailList.get(1));
			}
			mv.addObject("currentPage", currentPage);
			mv.setViewName("event/eventDetailView");
		} else {
			mv.addObject("message", "이벤트글 상세보기 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}


	// 게시글 검색
	@RequestMapping("esearch.do")
	public String eventSerch(@RequestParam("keyword") String keyword, Model model) {

		ArrayList<Event> list = eventService.selectSearch(keyword);

		model.addAttribute("list", list);

		return "event/eventSearchView";
	}

	// 진행중인 이벤트
	@RequestMapping("proEvent.do")
	public ModelAndView proceedEvent(@RequestParam("page") int currentPage, ModelAndView mv) {
		// 한페이지에서 출력될 갯수
		int limit = 6;

		// 진행중인 이벤트 갯수
		int listCount = eventService.selectProceedCount();

		// 현재 페이지에 출력할 진행중인 이벤트 목록
		ArrayList<Event> list = eventService.selectProceedEvent(currentPage, limit);

		// 뷰에 출력될 총 페이지 수 계산식
		int maxPage = (int) (((double) listCount / limit) + 0.9);

		// 현재 페이지가 속한 그룹의 시작페이지 수 지정
		int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;
		int endPage = startPage + limit - 1;

		if (maxPage < endPage) {
			endPage = maxPage;
		}
		// 내보내기
		if (list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("currentPage", currentPage);
			mv.addObject("maxPage", maxPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("listCount", listCount);
			mv.setViewName("event/eventProView");
		} else {
			mv.addObject("message", currentPage + "페이지에 대한 목록 조회 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 종료된 이벤트
	@RequestMapping("endEvent.do")
	public ModelAndView endEvent(@RequestParam("page") int currentPage, ModelAndView mv) {
		// 한페이지에서 출력될 갯수
		int limit = 6;

		// 종료된 이벤트 목록 갯수
		int listCount = eventService.selectEndCount();

		// 현재 페이지에 출력할 종료된 이벤트 목록
		ArrayList<Event> list = eventService.selectEndEvent(currentPage, limit);

		// 뷰에 출력될 총 페이지 수 계산식
		int maxPage = (int) (((double) listCount / limit) + 0.9);

		// 현재 페이지가 속한 그룹의 시작페이지 수 지정
		int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;
		int endPage = startPage + limit - 1;

		if (maxPage < endPage) {
			endPage = maxPage;
		}
		// 내보내기
		if (list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("currentPage", currentPage);
			mv.addObject("maxPage", maxPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("listCount", listCount);
			mv.setViewName("event/eventEndView");
		} else {
			mv.addObject("message", currentPage + "페이지에 대한 목록 조회 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 게시글 등록
	@RequestMapping(value = "einsert.do", method = RequestMethod.POST)
	public String eventInsert(Event event, HttpServletRequest request, Model model,
			@RequestParam(value = "tfile", required = false) MultipartFile tfile,
			@RequestParam(value = "cfile", required = false) MultipartFile cfile) {// 저장할 폴더를 지정해야해서 request 사용한다

		// 저장할 위치지정
		String savePath = request.getSession().getServletContext().getRealPath("/resources/eupfiles");

		event.setEvent_thumb(tfile.getOriginalFilename());
		event.setEvent_file(cfile.getOriginalFilename());

		try {
			tfile.transferTo(new File(savePath + "\\" + tfile.getOriginalFilename()));
			cfile.transferTo(new File(savePath + "\\" + cfile.getOriginalFilename()));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			return "common/error";
		}

		if (eventService.insertEvent(event) > 0) {
			return "redirect:/elist.do?page=1";
		} else {
			request.setAttribute("message", "새 이벤트 등록 실패");
			return "common/error";
		}
	
	}
	
	// 수정하기
	@RequestMapping(value = "eupdate.do", method = RequestMethod.POST)
	public String updateEvent(Event event, HttpServletRequest request, Model model,
			@RequestParam(value = "currentPage", required = false) String currentPage,
			@RequestParam(value = "tupfile", required = false) MultipartFile tupfile,
			@RequestParam(value = "cupfile", required = false) MultipartFile cupfile) {

		String savePath = request.getSession().getServletContext().getRealPath("resources/eupfiles");
		
		// 새로운 내용파일이 있을때
	if(cupfile.getOriginalFilename()!="") {
		event.setEvent_file(cupfile.getOriginalFilename());
		try {
			cupfile.transferTo(new File(savePath + "\\" + cupfile.getOriginalFilename()));
			
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
	
	}
		// 새로운 썸네일이 있을때
	if(tupfile.getOriginalFilename()!="") {
		event.setEvent_thumb(tupfile.getOriginalFilename());
		try {
			tupfile.transferTo(new File(savePath + "\\" + tupfile.getOriginalFilename()));
			
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
	
	}
	
		
		if (eventService.updateEvent(event) > 0) {
			model.addAttribute("event", event);
		} else {
			model.addAttribute("message", event.getEvent_no() + "번 이벤트 수정 실패");
			return "common/error";
		}
		return "redirect:/elist.do?page=1"; 
		
	}
	// 이벤트 삭제하기
	@RequestMapping("edelete.do")
	public String eventDelete(Event event, HttpServletRequest request,
			@RequestParam(value = "currentPage", required = false) int currentPage) {
		String url;
		if (eventService.deleteEvent(event) > 0) {
			
				String savePath = request.getSession().getServletContext().getRealPath("resources/eupfiles");
				
				new File(savePath + "\\" + event.getEvent_thumb()).delete();
				new File(savePath + "\\" + event.getEvent_file()).delete();
			
			if (currentPage != 0) {
				url = "redirect:/elist.do?page=" + currentPage;
			}
			url = "redirect:/elist.do?page=1";
		} else {
			request.setAttribute("message", event.getEvent_no() + "번 글 삭제 실패");
			url = "common/error";
		}
		return url;
	}

}










