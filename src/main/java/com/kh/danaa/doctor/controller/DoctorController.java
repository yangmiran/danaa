package com.kh.danaa.doctor.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.danaa.doctor.model.service.DoctorService;
import com.kh.danaa.doctor.model.vo.Doctor;

@Controller
public class DoctorController {
	
	private static final Logger logger = LoggerFactory.getLogger(DoctorController.class);
	
	@Autowired
	private DoctorService doctorService;
	
	//관리자 의사리스트
	@RequestMapping(value = "doctor.do")
	public String doctorPage(Model model) {
		logger.info("doctorPage.do run....");
		
		ArrayList<Doctor> list = doctorService.selectDoctor();
		
		if(list.size() > 0) {
			model.addAttribute("list", list);
			return "introduce/doctor";
		} else {
			model.addAttribute("message", "페이지리스트 조회 실패");
			return "common/error";
		}
	}
	
	//관리자 의사상세
	@RequestMapping("doctorDetail.do")
	public ModelAndView doctorDetail(@RequestParam("doc_no") int doc_no, ModelAndView mv) {
		
		Doctor doctor = doctorService.selectOne(doc_no);
		
		if(doctor != null) {
			mv.setViewName("introduce/doctorDetailView");
			mv.addObject("doctor", doctor);
		}else {
			mv.addObject("message", doc_no + "에 대한 정보 조회 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	//관리자 의사 수정페이지 이동
	@RequestMapping("doctorUpview.do")
	public ModelAndView doctorUpview(@RequestParam("doc_no") int doc_no, ModelAndView mv) {
		
		Doctor doctor = doctorService.selectOne(doc_no);
		
		if(doctor != null) {
			mv.setViewName("introduce/doctorUpdate");
			mv.addObject("doctor", doctor);
		}else {
			mv.addObject("message", doc_no + "에 대한 정보 수정페이지 조회 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	//관리자 의사 수정
	@RequestMapping(value = "doctorUpdate.do", method = RequestMethod.POST)
	public ModelAndView updateDoctor(Doctor doctor, HttpServletRequest request, 
			@RequestParam(name="upfile", required=false) MultipartFile file, ModelAndView mv) {
		
		String savePath = request.getSession().getServletContext().getRealPath("resources/images");
		
		//logger.info(doctor.getDoc_pic());
		
		if(file.getOriginalFilename() != "") {
			doctor.setDoc_pic(file.getOriginalFilename());
			//업로드된 파일을 지정한 폴더로 옮기기
			try {
				file.transferTo(new File(savePath + "\\" + file.getOriginalFilename()));
			} catch (IllegalStateException | IOException e) {			
				e.printStackTrace();
			}
		}
				
		if(doctorService.updateDoctor(doctor) > 0) {
			mv.setViewName("redirect:/doctor.do");
		}else {
			mv.addObject("message", doctor.getDoc_no() + "번 의사정보 수정 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	//관리자 의사리스트
	@RequestMapping(value = "moveIntro.do")
	public String moveIntroPage(Doctor doctor, Model model) {
		//logger.info("doctorPage.do run....");
		
		ArrayList<Doctor> list = doctorService.selectDoctor();
		Doctor[] doc = new Doctor[3];
		for(int i = 0; i < list.size(); i++) {
			doc[i] = list.get(i);
		}
		Doctor d1 = doc[0];
		Doctor d2 = doc[1];
		Doctor d3 = doc[2];
		//System.out.println(d1);
		//System.out.println(d2);
		//System.out.println(d3);
		if(list.size() > 0) {
			model.addAttribute("d1", d1);
			model.addAttribute("d2", d2);
			model.addAttribute("d3", d3);			
			return "introduce/intro";
		} else {
			model.addAttribute("message", "페이지리스트 조회 실패");
			return "common/error";
		}

	}
}
