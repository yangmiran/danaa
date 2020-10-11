package com.kh.danaa.reservation.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.danaa.doctor.model.vo.Doctor;
import com.kh.danaa.reservation.model.service.ReservationService;
import com.kh.danaa.reservation.model.vo.Askform;
import com.kh.danaa.reservation.model.vo.Reservation;

@Controller
public class ReservationController {
	
	@Autowired
	private ReservationService reservationService;
	
	//회원 예약 페이지 이동
	@RequestMapping("moveRes.do")
	public String moveMemReservation(Model model) {
		ArrayList<Doctor> list = reservationService.selectDoctor();
		model.addAttribute("list", list);
		return "reservation/memReservationForm";
	}
	
	//비회원 예약 페이지 이동
	@RequestMapping("moveNres.do")
	public String moveNonmemReservation(Model model) {
		ArrayList<Doctor> list = reservationService.selectDoctor();
		model.addAttribute("list", list);
		return "reservation/nonmemReservationForm";
	}
	
	//선예약여부확인
	@RequestMapping(value="checkReserved.do", method=RequestMethod.POST)
	public void checkReservedMethod(HttpServletResponse response, Reservation reservation) throws IOException {
		int result = reservationService.selectReserved(reservation);
		
		//1. 보내는 정보에 대한 Mime type 지정함
		response.setContentType("text/html; charset=utf-8");
		//2. 출력에 사용할 스트림 생성
		PrintWriter out = response.getWriter();
		
		if(result > 0) {
			out.append("1");
			out.flush();
		} else {
			out.append("0");
			out.flush();
		}		
		out.close();
	}	
	
	//회원 예약
	@RequestMapping(value="insertRes.do", method=RequestMethod.POST)
	public String insertMemReservationMethod(Reservation reservation, Model model)   {
		if(reservationService.insertMemReservation(reservation) > 0) {
			Reservation res = reservationService.selectForaskform(reservation);
			model.addAttribute("reservation", res);
			return "reservation/covidAskform";
		} else {
			model.addAttribute("message", "예약 실패");
			model.addAttribute("url", "/moveRes.do");
			return "common/alert";
		}		
	}
	
	//비회원 예약
	@RequestMapping(value="insertNres.do", method=RequestMethod.POST)
	public String insertNonmemReservationMethod(Reservation reservation, Model model) {
		if(reservationService.insertNonmemReservation(reservation) > 0) {
			Reservation res = reservationService.selectForaskform(reservation);
			model.addAttribute("reservation", res);
			return "reservation/covidAskform";
		} else {
			model.addAttribute("message", "예약 실패");
			model.addAttribute("url", "/moveNres.do");
			return "common/alert";
		}
	}
	
	//문진표 입력
	@RequestMapping(value="insertAskform.do", method=RequestMethod.POST)
	public String insertAskformMethod(Askform askform, Model model) {
		if(reservationService.insertAskform(askform) > 0) {
			return "redirect:/main.do";
		} else {
			model.addAttribute("message", "문진표 입력 실패");
			model.addAttribute("url", "/main.do");
			return "common/alert";
		}
	}
	
	//예약확인페이지 이동
	@RequestMapping("moveCheckRes.do")
	public String moveCheckReservation() {
		return "reservation/connectResCheckPage";
	}
	
	//비회원 예약 리스트 출력
	@RequestMapping(value="checkNres.do", method={RequestMethod.GET, RequestMethod.POST})
	public String checkNonmemReservation(Reservation reservation, Model model) {
		
		//현재 페이지에 출력할 게시글 목록 조회
		ArrayList<Reservation> list = reservationService.selectNonmemList(reservation);
				
		if(list.size() > 0) {
			model.addAttribute("reservation", reservation);
			model.addAttribute("list", list);
			return "reservation/myReservationList";
		} else {
			model.addAttribute("message", "해당 정보로 조회되는 예약 리스트가 없습니다.");
			model.addAttribute("url", "/moveCheckRes.do");
			return "common/alert";
		}		
	}
	
	//회원 로그인시 예약 리스트 출력
	@RequestMapping(value="checkRes.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String checkMemReservation(@RequestParam("member_id") String member_id, Model model) {
		
		//현재 페이지에 출력할 게시글 목록 조회
		ArrayList<Reservation> list = reservationService.selectMyList(member_id);
				
		if(list.size() > 0) {
			model.addAttribute("list", list);
			return "reservation/myReservationListLogin";
		} else {
			model.addAttribute("message", "해당 정보로 조회되는 예약 리스트가 없습니다.");
			model.addAttribute("url", "/main.do");
			return "common/alert";	        
		}		
	}
	
	//예약 취소 (비로그인)
	@RequestMapping(value="resCancel.do", method=RequestMethod.POST)
	public String cancelReservationMethod(Reservation reservation, @RequestParam("res_no") int res_no, Model model){
		if(reservationService.updateResCancel(res_no) > 0) {
			ArrayList<Reservation> list = reservationService.selectNonmemList(reservation);
			model.addAttribute("reservation", reservation);
			model.addAttribute("list", list);
			return "reservation/myReservationList";
		} else {
			model.addAttribute("message", "예약 취소에 실패하였습니다.");
			model.addAttribute("url", "/moveCheckRes.do");
			return "common/alert";
		}
	}
	
	//예약 취소 (로그인)
	@RequestMapping(value="resCancelLogin.do", method=RequestMethod.POST)
	public String cancelReservationLoginMethod(HttpServletRequest request, @RequestParam("res_no") int res_no, Model model) {
		if(reservationService.updateResCancel(res_no) > 0) {
			String referer = request.getHeader("Referer");
	        return "redirect:"+ referer;	
		} else {
			model.addAttribute("message", "예약 취소에 실패하였습니다.");
			model.addAttribute("url", "/main.do");
			return "common/alert";
		}
	}
		
	//예약상태 확인
	@RequestMapping(value="checkCancel.do", method=RequestMethod.POST)
	public void checkCancelOk(@RequestParam("res_no") int res_no, HttpServletResponse response) throws IOException {
		int result = reservationService.selectCancelOk(res_no);
		//1. 보내는 정보에 대한 Mime type 지정함
		response.setContentType("text/html; charset=utf-8");
		//2. 출력에 사용할 스트림 생성
		PrintWriter out = response.getWriter();
		
		if(result == 1) {
			out.append("1");
			out.flush();
		} else {
			out.append("0");
			out.flush();
		}		
		out.close();
	}
	
	//관리자 예약 확인
	@RequestMapping("adcheckRes.do")
	public String adminCheckReservation(HttpServletRequest request, Model model) {
		
		//페이지 기본값 지정
		int currentPage = 1;
		//전송 온 페이지값 추출
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		//한 페이지당 출력할 목록 갯수 지정
		int limit = 10;
		
		//전체 목록 갯수 조회
		int listCount = reservationService.selectListCount();
		
		//현재 페이지에 출력할 예약 목록 조회
		ArrayList<Reservation> list = reservationService.selectAllList(currentPage, limit);
		
		//뷰에 출력될 총 페이지 수 계산
		int maxPage = (int)((double)listCount / limit + 0.9);
		//현재 페이지가 속한 그룹의 시작 페이지 수 지정
		//예 : currentPage가 35이면 페이지그룹이 10일 때 시작페이지는 31이 됨.
		int startPage = (((int)((double)currentPage / limit + 0.9)) - 1) * limit + 1;
		int endPage = startPage + limit - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		ArrayList<Doctor> dlist = reservationService.selectDoctor();		
		
		if(list.size() > 0) {
			model.addAttribute("list", list);
			model.addAttribute("dlist", dlist);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("listCount", listCount);
			return "reservation/adminReservationList";
		} else {
	        model.addAttribute("message", "예약 목록 조회에 실패하였습니다.");
			model.addAttribute("url", "/moveAdmain.do");
			return "common/alert";
		}
	}
	
	//관리자 예약 상세보기
	@RequestMapping("addetailRes.do")
	public String adminDetailReservation(@RequestParam("rno") int res_no, Model model, HttpServletResponse response,
			HttpServletRequest request) throws IOException {
		Reservation reservation = reservationService.selectReservation(res_no);
		
		if(reservation != null) {
			model.addAttribute("reservation", reservation);
			return "reservation/adminReservationDetail";
		} else {
	        String referer = request.getHeader("Referer");
	        return "redirect:"+ referer;
		}
	}
	
	//사전문진표 확인하기
	@RequestMapping("checkAskform.do")
	public String checkAskformMethod(@RequestParam("res_no") int res_no, Model model) {
		Askform askform = reservationService.selectAskform(res_no);
		model.addAttribute("askform", askform);
		return "reservation/checkAskform";
	}
	
	//예약 취소 (관리자)
	@RequestMapping(value="resCancelAdmin.do", method=RequestMethod.GET)
	public String cancelReservationAdminMethod(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//받아온 체크박스 rno 배열에 담기
		String[] rno = request.getParameterValues("res_no");		
		
		//rno[] 길이만큼 실행
		int result = 0;		
		for(int i = 0; i < rno.length; i++) {
			int res_no = Integer.parseInt(rno[i]);			
			result = reservationService.updateResCancel(res_no);	
		}						
		
		if(result > 0) {		
			String referer = request.getHeader("Referer");
	        return "redirect:"+ referer;	
		} else {
			response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>alert('예약 취소에 실패하였습니다.'); history.go(-1);</script>");
	        out.flush();
	        out.close();
	        
	        String referer = request.getHeader("Referer");
	        return "redirect:"+ referer;
		}
	}
	
	//예약 확정 (관리자)
	@RequestMapping(value="resConfirm.do", method=RequestMethod.GET)
	public String confirmReservationAdminMethod(HttpServletRequest request, 
			HttpServletResponse response) throws IOException, AddressException, MessagingException {
		//받아온 체크박스 rno 배열에 담기
		String[] rno = request.getParameterValues("res_no");		
		
		//rno[] 길이만큼 실행
		int result = 0;		
		for(int i = 0; i < rno.length; i++) {
			int res_no = Integer.parseInt(rno[i]);			
			result = reservationService.updateResConfirm(res_no);
			Reservation r = reservationService.selectReservation(res_no);
			
			String email = r.getRes_email();
			String name = r.getRes_name();
			java.sql.Date date = r.getRes_date();
			String time = r.getRes_time();			

			String host ="smtp.naver.com";
			final String username="good_in123";//네이버 주소중@앞부분 작성
			final String password ="rntrnt!123";
			int port=465;
			
			//메일 내용
			String recipient=email;//받는 이메일 주소
			String subject ="[MNR CLINIC] 예약이 확정되었습니다.";//이메일 발송 제목
			String body = "\n\n" + name + "님의 예약이 확정되었습니다.";//메일 발송시 내용
			body += "\n예약하신 일정은 " + date + " " + time + "입니다.";
			body += "\n일정에 변경이 생기실 경우 본원으로 연락 부탁드립니다.";
			
			Properties props = System.getProperties();
			
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", port);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.ssl.enable", "true");
			props.put("mail.smtp.ssl.trust", host);
			
			Session session = Session.getDefaultInstance(props, new Authenticator() {
				String un=username;
				String pw=password;
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(un,pw);
				}
			});
			session.setDebug(true);
			
			javax.mail.Message mimeMessage = new MimeMessage(session);
			mimeMessage.setFrom(new InternetAddress("good_in123@naver.com"));
			mimeMessage.setRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress(recipient));
			mimeMessage.setSubject(subject);
			mimeMessage.setText(body);
			Transport.send(mimeMessage);	
		}		
		
		if(result > 0) {				
			String referer = request.getHeader("Referer");
	        return "redirect:"+ referer;	
		} else {
			response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>alert('예약 확정에 실패하였습니다.'); history.go(-1);</script>");
	        out.flush();
	        out.close();
	        
	        String referer = request.getHeader("Referer");
	        return "redirect:"+ referer;
		}
	}
	
	//진료 완료 (관리자)
	@RequestMapping(value="resComplete.do", method=RequestMethod.GET)
	public String completeReservationAdminMethod(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//받아온 체크박스 rno 배열에 담기
		String[] rno = request.getParameterValues("res_no");		
		
		//rno[] 길이만큼 실행
		int result = 0;		
		for(int i = 0; i < rno.length; i++) {
			int res_no = Integer.parseInt(rno[i]);			
			result = reservationService.updateResComplete(res_no);	
		}		
		
		if(result > 0) {			
			String referer = request.getHeader("Referer");
	        return "redirect:"+ referer;	
		} else {
			response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>alert('진료 완료에 실패하였습니다.'); history.go(-1);</script>");
	        out.flush();
	        out.close();
	        
	        String referer = request.getHeader("Referer");
	        return "redirect:"+ referer;
		}
	}
	
	//의사별 조회
	@RequestMapping("resByDoc.do")
	public String reservationByDoctor(@RequestParam("res_doctor") int res_doctor, Model model, HttpServletRequest request) {

		//페이지 기본값 지정
		int currentPage = 1;
		//전송 온 페이지값 추출
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		//한 페이지당 출력할 목록 갯수 지정
		int limit = 10;
		
		//전체 목록 갯수 조회
		int listCount = reservationService.selectDocListCount(res_doctor);
		
		//현재 페이지에 출력할 예약 목록 조회
		ArrayList<Reservation> list = reservationService.selectResDoctor(currentPage, limit, res_doctor);
		
		//뷰에 출력될 총 페이지 수 계산
		int maxPage = (int)((double)listCount / limit + 0.9);
		//현재 페이지가 속한 그룹의 시작 페이지 수 지정
		//예 : currentPage가 35이면 페이지그룹이 10일 때 시작페이지는 31이 됨.
		int startPage = (((int)((double)currentPage / limit + 0.9)) - 1) * limit + 1;
		int endPage = startPage + limit - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		ArrayList<Doctor> dlist = reservationService.selectDoctor();
		
		if(list.size() > 0) {
			model.addAttribute("dlist", dlist);
			model.addAttribute("list", list);
			model.addAttribute("res_doctor", res_doctor);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("listCount", listCount);
			return "reservation/doctorReservationList";
		} else {       
	        model.addAttribute("message", "해당 정보로 조회되는 예약 리스트가 없습니다.");
			model.addAttribute("url", "/adcheckRes.do");
			return "common/alert";
		}
	}
	
	//상태별 조회
	@RequestMapping("resByStatus.do")
	public String reservationByStatus(@RequestParam("res_status") int res_status, Model model,	HttpServletRequest request) {

		//페이지 기본값 지정
		int currentPage = 1;
		//전송 온 페이지값 추출
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		//한 페이지당 출력할 목록 갯수 지정
		int limit = 10;
		
		//전체 목록 갯수 조회
		int listCount = reservationService.selectStatusListCount(res_status);
		
		//현재 페이지에 출력할 예약 목록 조회
		ArrayList<Reservation> list = reservationService.selectResStatus(currentPage, limit, res_status);
		
		//뷰에 출력될 총 페이지 수 계산
		int maxPage = (int)((double)listCount / limit + 0.9);
		//현재 페이지가 속한 그룹의 시작 페이지 수 지정
		//예 : currentPage가 35이면 페이지그룹이 10일 때 시작페이지는 31이 됨.
		int startPage = (((int)((double)currentPage / limit + 0.9)) - 1) * limit + 1;
		int endPage = startPage + limit - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		ArrayList<Doctor> dlist = reservationService.selectDoctor();
		
		if(list.size() > 0) {
			model.addAttribute("dlist", dlist);
			model.addAttribute("list", list);
			model.addAttribute("res_status", res_status);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("listCount", listCount);
			return "reservation/statusReservationList";
		} else {
			 model.addAttribute("message", "해당 정보로 조회되는 예약 리스트가 없습니다.");
				model.addAttribute("url", "/adcheckRes.do");
				return "common/alert";
		}
	}
	
	//진료 비활성화 페이지 이동
	@RequestMapping("disableRes.do")
	public String moveAdminReservation(Model model, HttpServletRequest request) {
		//페이지 기본값 지정
		int currentPage = 1;
		//전송 온 페이지값 추출
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		//한 페이지당 출력할 목록 갯수 지정
		int limit = 10;
		
		//전체 목록 갯수 조회
		int listCount = reservationService.selectAdListCount();
		
		//현재 페이지에 출력할 예약 목록 조회
		ArrayList<Reservation> list = reservationService.selectResAdmin(currentPage, limit);
		
		//뷰에 출력될 총 페이지 수 계산
		int maxPage = (int)((double)listCount / limit + 0.9);
		//현재 페이지가 속한 그룹의 시작 페이지 수 지정
		//예 : currentPage가 35이면 페이지그룹이 10일 때 시작페이지는 31이 됨.
		int startPage = (((int)((double)currentPage / limit + 0.9)) - 1) * limit + 1;
		int endPage = startPage + limit - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}		
		
		ArrayList<Doctor> dlist = reservationService.selectDoctor();
		
		model.addAttribute("dlist", dlist);
		model.addAttribute("list", list);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("listCount", listCount);
		return "reservation/disableReservation";
		
	}
	
	//진료 비활성화
	@RequestMapping(value="insertDisable.do", method=RequestMethod.POST)
	public String insertAdminReservation(Reservation reservation) {
		reservationService.insertAdReservation(reservation);		
		return "redirect:/disableRes.do";
	}
	
	//진료 비활성화 삭제
	@RequestMapping(value="deleteDisable.do", method=RequestMethod.POST)
	public String deleteAdminReservation(HttpServletRequest request) {
		//받아온 체크박스 rno 배열에 담기
		String[] rno = request.getParameterValues("res_no");		
		
		//rno[] 길이만큼 deleteAdReservation 실행			
		for(int i = 0; i < rno.length; i++) {
			int res_no = Integer.parseInt(rno[i]);			
			reservationService.deleteAdReservation(res_no);	
		}		
		
		return "redirect:/disableRes.do";
	}
	
	//캘린더 페이지로 이동
	@RequestMapping("moveCalendar.do")
	public String reservationCalendar(Model model) {		
		ArrayList<Reservation> list = reservationService.selectCalList();
		model.addAttribute("list", list);
		return "reservation/adminReservationCalendar";
	}
	
	//예약 일정 변경 페이지로 이동
	@RequestMapping(value="moveChange.do", method={RequestMethod.POST, RequestMethod.GET})
	public String moveChangePage(@RequestParam("res_no") int res_no, Model model) {
		Reservation reservation = reservationService.selectReservation(res_no);
		ArrayList<Doctor> list = reservationService.selectDoctor();		
		model.addAttribute("reservation", reservation);
		model.addAttribute("list", list);
		return "reservation/changeReservation";
	}
	
	//예약 일정 변경
	@RequestMapping(value="resChange.do", method={RequestMethod.POST, RequestMethod.GET})
	public String changeReservationMethod(HttpServletRequest request, Reservation reservation, Model model) {	
		String check = reservation.getMember_id();
		if(reservationService.updateResChange(reservation) > 0) {	
			if(check == "") {
				model.addAttribute("message", "예약 일정이 변경되었습니다.");
				model.addAttribute("url", "/moveCheckRes.do");				
			} else {
				model.addAttribute("message", "예약 일정이 변경되었습니다.");
				model.addAttribute("url", "/checkRes.do?member_id=" + check);				
			}			
		} else {
			model.addAttribute("message", "일정 변경에 실패하였습니다.");
			model.addAttribute("url", "/main.do");			
		}
		return "common/alert";
	}
	
	//관리자 예약 일정 변경
	@RequestMapping(value="adresChange.do", method={RequestMethod.POST, RequestMethod.GET})
	public String changeReservationAdminMethod(HttpServletRequest request, Reservation reservation, Model model) {	
		int res_no = Integer.parseInt(request.getParameter("res_no2"));
		reservation.setRes_no(res_no);		
		if(reservationService.updateResChange(reservation) > 0) {				
			String referer = request.getHeader("Referer");
	        return "redirect:"+ referer;		
		} else {
			model.addAttribute("message", "일정 변경에 실패하였습니다.");
			model.addAttribute("url", "/adcheckRes.do");		
			return "common/alert";
		}		
	}	
}