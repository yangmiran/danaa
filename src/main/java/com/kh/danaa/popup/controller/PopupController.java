package com.kh.danaa.popup.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.danaa.popup.model.service.PopupService;
import com.kh.danaa.popup.model.vo.Popup;

@Controller
public class PopupController {

	@Autowired
	private PopupService popupService;

	// 팝업 리스트
	@RequestMapping("plist.do")
	public ModelAndView movePopup(@RequestParam("page") int page, ModelAndView mv) {

		int limit = 5;

		int listCount = popupService.selectListCount();

		ArrayList<Popup> list = popupService.selectListPopup(page, limit);

		// 뷰에 출력될 총 페이지 수 계산식
		int maxPage = (int) (((double) listCount / limit) + 0.9);

		// 현재 페이지가 속한 그룹의 시작페이지 수 지정
		int startPage = (((int) ((double) page / limit + 0.9)) - 1) * limit + 1;
		int endPage = startPage + limit - 1;

		if (maxPage < endPage) {
			endPage = maxPage;
		}

		if (list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("page", page);
			mv.addObject("maxPage", maxPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("listCount", listCount);
			mv.setViewName("popup/popupList");
		} else {
			mv.addObject("message", page + "페이지에 대한 목록 조회 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 이동 (등록페이지)
	@RequestMapping("moveWrite.do")
	public String moveInsert(@RequestParam("page") int page) {
		return "popup/popupWriteForm";
	}

	// 팝업 등록
	@RequestMapping(value = "pinsert.do", method = RequestMethod.POST)
	public String popupInsert(Popup popup, HttpServletRequest request,
			@RequestParam(name = "pfile", required = false) MultipartFile file, Model model) {
		// 저장할 폴더를 지정해야해서 request 사용한다

		String fileName = file.getOriginalFilename();

		String savePath = request.getSession().getServletContext().getRealPath("/resources/pupfiles");

		// 업로드된 파일이 있다면
		if (file != null) {
			// 바꿀 파일명에 대한 포맷문자열 만들기 : 년월일시분초 형식으로 지정
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); // java.text.SimpleDateFormat

			// 바꿀파일명 만들기 // 현재 시스템 시간의 long형 정수
			// 업로드된 파일의 확장자를 추출해서, 새 파일명 뒤에 붙여줌
			String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())); // 파일명
			renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1); // 원래 파일명 . 뒤에서부터 추출해라

			popup.setPopup_file(fileName);
			popup.setPopup_refile(renameFileName);

			// 업로드된 파일을 지정한 폴더로 옮기는 작업
			try {
				file.transferTo(new File(savePath + "\\" + renameFileName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}

		if (popupService.insertPopup(popup) > 0) {
			return "redirect:/plist.do?page=1";
		} else {
			model.addAttribute("message", "새 공지글 등록 실패");
			return "common/error";
		}

	}

	// 팝업글 삭제
	@RequestMapping("pdelete.do")
	public String popupDelete(Popup popup, HttpServletRequest request, @RequestParam("popup_no") int popup_no,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {

		String[] pno = request.getParameterValues("popup_no");

		// pno[] 값 담아두기
		for (int i = 0; i < pno.length; i++) {
			int pop_no = Integer.parseInt(pno[i]);

			// pop_no삭제가 되면
			if (popupService.deletePopup(pop_no) > 0) {
			} else {
				request.setAttribute("message", popup.getPopup_no() + " 번 글 삭제 실패");
				return "common/error";
			}
		}
		return "redirect:/plist.do?page=" + page;
	}


	// 팝업 검색
	@RequestMapping("psearch.do")
	public String searchPop(@RequestParam("searchType") String searchType, @RequestParam("keyword") String keyword,
			Model model) {

		ArrayList<Popup> list = null;
		
		if(keyword.equals("노출")) {
			keyword = "0";
		}
		
		if(keyword.equals("미노출")) {
			keyword ="1";
		}

		switch (searchType) {
		case "sj":
			list = popupService.selectNameSearch(keyword);
			break;

		case "cn":
			list = popupService.selectYnSearch(keyword);
			break;
		}

		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "popup/popupList";
		} else {
			model.addAttribute("message", "검색결과 조회 실패");
			return "common/error";
		}
	}
	
	//팝업수정
	@RequestMapping("pupdate.do")
	public String pupdate(@RequestParam("popup_no") int popup_no, @RequestParam("popup_state") int popup_state) {
		
		Popup popup = popupService.selectPopup(popup_no);		
		popup.setPopup_state(popup_state);
		popupService.updatePopstate(popup);		
		return "redirect:/plist.do?page=1";
	}
	
}
