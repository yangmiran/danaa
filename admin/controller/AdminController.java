package com.kh.danaa.admin.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.danaa.admin.model.service.AdminService;
import com.kh.danaa.admin.model.vo.Admin;
import com.kh.danaa.event.model.service.EventService;
import com.kh.danaa.member.model.service.MemberService;
import com.kh.danaa.qna.model.service.QnaService;
import com.kh.danaa.qna.model.vo.Qna;
import com.kh.danaa.reservation.model.service.ReservationService;
import com.kh.danaa.review.model.service.ReviewService;
import com.kh.danaa.review.model.vo.Review;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired	//이벤트서비스
	private EventService eventService;
	
	@Autowired //문의글서비스
	private QnaService qnaService;
	
	@Autowired //예약서비스
	private ReservationService reservationService;
	
	@Autowired //리뷰서비스
	private ReviewService reviewService;
	
	@Autowired //회원서비스
	private MemberService memberService;
	
	@RequestMapping("moveAdmain.do")
	public String moveIntroPage(Model model) {
		
		//진행중인 이벤트 카운트
		int proEventCount = eventService.selectProceedCount();		
		
		// 새 후기글 카운트 
		int recount = reviewService.selectReviewCount();
		
		// 후기 top3 리스트
		ArrayList<Review> list = reviewService.selectTop3();
		
		// 미처리 문의글 
		// 번호 가져오기
		ArrayList<String> qnano = qnaService.selectNoList();
		//값 담을 list 객체 생성
		ArrayList<Qna> qnalist = new ArrayList<Qna>();
		
		for(int  i = 0; i<qnano.size(); i++) {
			String str =qnano.get(i);
			//번호 보내서 값 가져오기
			 Qna qna =qnaService.selectOneQna(Integer.parseInt(str));			
			 qnalist.add(qna);		
		}
		
		//의사별 예약현황
		int resLeeCount = reservationService.selectResLee();
		int resChaeCount = reservationService.selectResChae();
		int resAhnCount = reservationService.selectResAhn();
		
		//미확정 예약
		int notYetRes = reservationService.selectNotYet();
		
		// 총회원 수 카운트
		int memberCount = memberService.selectMemberCount();
		
		model.addAttribute("resLeeCount", resLeeCount);
		model.addAttribute("resChaeCount", resChaeCount);
		model.addAttribute("resAhnCount", resAhnCount);
		model.addAttribute("notYetRes", notYetRes);
		model.addAttribute("proEventCount",proEventCount);
		model.addAttribute("qnalist", qnalist);
		model.addAttribute("reviewCount", recount);
		model.addAttribute("list", list);
		model.addAttribute("memberCount", memberCount);
		return "admin/admain";
	}

	@RequestMapping("moveAdinfo.do")
	public ModelAndView AdinfoMethod(ModelAndView mv) {
		
		Admin admin = adminService.selectAdmin();
		//logger.info("admin_name");
		
		if(admin != null) {
			mv.setViewName("admin/adinfo");
			mv.addObject("admin", admin);
		}else {
			mv.addObject("message","정보 조회 실패!");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
	@RequestMapping(value="adupdate.do", method=RequestMethod.POST)
	public String adminUpdateMethod(Admin admin, Model model) {
		if(adminService.updateAdmin(admin) > 0) {
			return "redirect:/moveAdinfo.do";
		}else {
			model.addAttribute("message", "관리자정보 수정 실패!");
			return "common/error";
		}
	}
	
	@RequestMapping(value="footer.do", method=RequestMethod.POST)
	@ResponseBody
	public String FooterMethod(HttpServletResponse response) throws UnsupportedEncodingException {
		//logger.info("footer.do run...");
		response.setContentType("application/json; charset=utf-8");
		
		Admin admin = adminService.selectAdmin();
		
		//전송용 json 객체 준비
		//JSONObject sendJson = new JSONObject();
		
		//json 배열 객체 생성
		JSONArray jarr = new JSONArray();
		JSONObject job = new JSONObject();
		
		job.put("admin_name", URLEncoder.encode(admin.getAdmin_name(), "utf-8"));
		job.put("admin_person", URLEncoder.encode(admin.getAdmin_person(), "utf-8"));
		job.put("admin_no", URLEncoder.encode(admin.getAdmin_no(), "utf-8"));
		job.put("admin_tel", URLEncoder.encode(admin.getAdmin_tel(), "utf-8"));
		job.put("admin_fax", URLEncoder.encode(admin.getAdmin_fax(), "utf-8"));
		job.put("admin_add", URLEncoder.encode(admin.getAdmin_add(), "utf-8"));
		job.put("admin_time", URLEncoder.encode(admin.getAdmin_time(), "utf-8"));
		
		//jarr.add(job);
		
		return job.toJSONString();  //뷰리졸버로 리턴함
	}

}
