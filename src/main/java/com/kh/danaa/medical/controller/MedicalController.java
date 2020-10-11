package com.kh.danaa.medical.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import com.kh.danaa.medical.model.service.MedicalService;
import com.kh.danaa.medical.model.vo.Medical;

@Controller
public class MedicalController {
	private static final Logger logger = LoggerFactory.getLogger(MedicalController.class);

	@Autowired
	private MedicalService medicalService;

	
	@RequestMapping(value = "medicalPage.do")
	public String medicalPage(Model model) {
		logger.info("medicalPage.do run....");

		ArrayList<Medical> list = medicalService.selectList();

		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "medical/medicalPage";
		} else {
			model.addAttribute("message", "페이지리스트 조회 실패");
			return "common/error";
		}
	}
	
	
	// 진료과목 검색 페이지
	@RequestMapping(value = "serchPage.do")
	public String medicalList(Model model) {
		logger.info("serchPage.do run....");

		ArrayList<Medical> list = medicalService.selectList();

		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "medical/serchPage";
		} else {
			model.addAttribute("message", "페이지리스트 조회 실패");
			return "common/error";
		}
	}

	// 진료과목 제목으로 검색
	@RequestMapping(value = "searchName.do", method = RequestMethod.POST)
	public String nameSearch(HttpServletRequest request, Model model) {
		logger.info("searchName.do run....");

		String action = request.getParameter("action");
		String keyword = null;

		keyword = request.getParameter("keyword");

		// 서비스 객체 생성하고, 메소드 실행하고 결과 받기
		ArrayList<Medical> list = null;

		switch (action) {
		case "name":
			list = medicalService.selectSearchName(keyword);
			break;
		}

		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "medical/serchPage";
		} else {
			model.addAttribute("message", "페이지리스트 조회 실패");
			return "common/error";
		}
	}
	
	//메인 진료과목 리스트 ajax
	@RequestMapping(value="mainMedical.do", method=RequestMethod.POST)
	@ResponseBody
	public String mainMedical(HttpServletResponse response) throws UnsupportedEncodingException {
		logger.info("mainMedical.do run..");
		
		ArrayList<Medical> list = medicalService.selectList();
		
		//전송용 json 객체 준비
		JSONObject sendJson = new JSONObject();
		//json 배열 객체 생성
		JSONArray jarr = new JSONArray();
		
		for(Medical medical : list) {
			//user 객체 저장용 json 객체 생성
			JSONObject job = new JSONObject();
			
			job.put("md_num", medical.getMd_num());
			job.put("md_name", URLEncoder.encode(medical.getMd_name(), "utf-8"));
			job.put("md_tag", URLEncoder.encode(medical.getMd_tag(), "utf-8"));
			job.put("md_cont", URLEncoder.encode(medical.getMd_cont(), "utf-8"));
			job.put("md_filename", URLEncoder.encode(medical.getMd_filename(), "utf-8"));
			
			//jarr 에 json 객체 저장
			jarr.add(job);
		}
		
		sendJson.put("list", jarr);
		
		return sendJson.toJSONString();
	}
	
}
