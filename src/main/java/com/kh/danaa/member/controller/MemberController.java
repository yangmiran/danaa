package com.kh.danaa.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;

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
import javax.servlet.http.HttpSession;
import javax.validation.Valid;


import org.codehaus.jackson.JsonNode;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.validation.BindingResult;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.github.scribejava.core.model.OAuth2AccessToken;

import com.kh.danaa.member.model.vo.KakaoLoginApi;
import com.kh.danaa.member.model.vo.NaverLoginBO;
import com.kh.danaa.member.model.service.MemberService;

import com.kh.danaa.member.model.vo.Member;
import com.kh.danaa.member.model.vo.MemberPage;
import com.kh.danaa.member.model.vo.RandomPassword;
import com.kh.danaa.reservation.model.service.ReservationService;
import com.kh.danaa.reservation.model.vo.Reservation;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class MemberController {
	// 로그 출력 객체 생성
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;
	
	//예약내역 가져오기 위한 DI
	@Autowired
	private ReservationService reservationService;
	
	
	//패스워드 암호화 처리위한 DI
	/*@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;*/
	

	// 로그인하기(SNS 외의 방법) **비밀번호 암호화 적용해야함
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String loginMethod(Member member, HttpSession session, Model model, SessionStatus status) {

		Member loginMember = memberService.selectLogin(member);

		if (loginMember != null) {

			model.addAttribute("message", loginMember.getName() + "님 환영합니다!");
			session.setAttribute("loginMember", loginMember);
			status.setComplete();// 요청 성공시 200 전송

			// 마지막 수정일 확인하여 현재 날짜 간의 차이 구하기
			long diffDay = (new Date().getTime() - loginMember.getLast_modified().getTime()) / (24 * 60 * 60 * 1000);

			if (diffDay < 180) { // 로그인 완료&&비밀번호 변경 필요 없음 메인으로 이동
				model.addAttribute("url", "/main.do");

			} else {// 날짜 차이가 180일 이상이면 비밀번호 변경 요청 페이지로 이동
				model.addAttribute("url", "/chgpwdpage.do");

			}

		} else {// 입력한 정보가 틀렸을 경우
			model.addAttribute("message", "일치하는 회원 정보가 없습니다");
			model.addAttribute("url", "/loginpage.do");
		}

		return "common/alert";

	}

	// 로그아웃 하기 ( 카카오, 네이버 로그아웃 토큰 만료로 처리 안함)
	@RequestMapping("logout.do")
	public String logoutMethod(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);// 있는 세션 가져오기

		if (session != null) {// 로그인 상태면
			session.invalidate();
			return "redirect:/main.do";
		} else {// 이미 로그아웃 된 상태
			model.addAttribute("message", "로그인한 상태가 아닙니다");
			model.addAttribute("url", "/main.do");
			return "common/alert";
		}
	}

	// 6개월 이상 비밀번호 미변경 회원-비밀번호 변경 요청 페이지로 이동
	@RequestMapping("chgpwdpage.do")
	public String moveChangePwdPage() {
		return "member/updatePwdPage";
	}

	// 비밀번호 변경 전 현재 비밀번호 확인 **비밀번호 암호화 적용해야함**
	@RequestMapping(value = "pwdchk.do", method = RequestMethod.POST)
	public String pwdCheck(Member member, Model model,@RequestParam("pwd2") String pwd2) {

		if (memberService.selectCkPwd(member) > 0) {// 일치하는 정보 존재시
			member.setPwd(pwd2);//비밀번호 변경값을 가져가기
			System.out.println(member);
			if (memberService.updatePwd(member) > 0) {
				model.addAttribute("message", "비밀번호 변경에 성공했습니다");			
			
			} else {
				model.addAttribute("message", "비밀번호 변경에 실패했습니다");
					
			}
			model.addAttribute("url", "/main.do");
		} else {
			model.addAttribute("message", "비밀번호가 일치 하지 않습니다");
			model.addAttribute("url", "/chgpwdpage.do");
			
		}
		return "common/alert";
	}


	// 비밀번호 다음에 변경하기 ( 오늘날짜로 변경됨 -3개월뒤로 유예)
	@RequestMapping("delaychgpwd.do")
	public String updateDelayChgPwd(Member member, Model model) {

		if (memberService.updateDelayChgPwd(member.getId()) > 0) {
			return "redirect:/main.do";
		} else {
			model.addAttribute("message", "비밀번호 변경 유예 요청에 오류가 발생했습니다");
			model.addAttribute("url", "/main.do");
			return "common/alert";
		}

	}
	
	//회원가입 진짜 첫 페이지 - sns간편회원가입 or 일반 회원가입 결정하는 페이지로 이동
	@RequestMapping("enrollfp.do")
	public String moveEnrollFPage(Model model, HttpSession session) {
		// 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		String kakaoAuthUrl = kakao_loginapi.getAuthorizationUrl(session);

		model.addAttribute("nurl", naverAuthUrl);
		model.addAttribute("kurl", kakaoAuthUrl);
		return "member/enrollFirstPage";
	}

	// 회원가입 첫 페이지로 이동(회원유형 선택페이지-14세미만여부 선택페이지)
	@RequestMapping("typepage.do")
	public String moveTypePage(HttpSession session) {
		if (session != null) {// sns로그인 상태 대비
		session.invalidate();
		}
		return "member/enrollTypePage";
	}

	// 회원가입 두번째 페이지로 이동 -일반회원가입(sns간편 회원가입 제외)(이용약관 동의 페이지)
	@RequestMapping("tospage.do")
	public String moveTosPage(@RequestParam("child") String child, HttpSession session) {
				
		session.setAttribute("child", child);
		return "member/enrollAuthPage";
	}
	
	

	// 회원가입 세번째 페이지로 이동(회원정보 입력 페이지)--일반회원가입 
	@RequestMapping(value = "enrollpage.do")
	public String moveEnrollPage(Model model,@RequestParam("child") String child) {
		Member member = new Member();
		member.setChild(child);		
		model.addAttribute("member", member);
		return "member/enrollInfoPage"; // 
	}
	
	// 회원가입 세번째 페이지로 이동(회원정보 입력 페이지)--sns 간편 회원가입
	@RequestMapping(value = "enrollsnspage.do")
	public String moveEnrollSnsPage(Model model,@RequestParam("child") String child) {
		Member member = new Member();
		member.setChild(child);		
		model.addAttribute("member", member);
		return "member/enrollSnsInfoPage";  
	}
	

	/*-------------------------SNS 로그인---------------------------*/

	/* 네이버 변수 생성 */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	/* 네이버 연동 객체 자동 생성 */
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	/* 카카오 연동 객체 생성 */
	KakaoLoginApi kakao_loginapi = new KakaoLoginApi();

	/* 로그인페이지로 이동-(+ 네이버 버튼에 연결url전송 , + 카카오톡 버튼에 연결url전송) */
	@RequestMapping(value = "loginpage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveLoginPage(Model model, HttpSession session) {

		// 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		String kakaoAuthUrl = kakao_loginapi.getAuthorizationUrl(session);
		
		model.addAttribute("nurl", naverAuthUrl);
		model.addAttribute("kurl", kakaoAuthUrl);

		return "member/loginPage";
	}

	// 2. 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/ncallback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);

		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터

		/**
		 * apiResult json 구조 {"resultcode":"00", "message":"success",
		 * "response":{"id":"33666449","nickname":"shinn****"
		 * ,"age":"20-29","gender":"M","email":"sh@naver.com"
		 * ,"name":"\uc2e0\ubc94\ud638"}}
		 **/

		// 2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;

		// 3. 데이터 파싱

		// Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");

		// response의 값 파싱
		 String id = (String)response_obj.get("id");
		 String age = (String)response_obj.get("age");
		
		
		//*값 받아온 것을 회원 정보와 확인해야함*//
		Member member = new Member();
		//아이디 저장되 있는 이름 만들기	
		String checkid = "@N"+id;//네이버 아이디 저장 값
		member.setId(checkid);
		//간편 로그인 아이디에 해당하는 회원 정보 확인하러가기
		Member loginMember = memberService.selectChkSns(checkid);  
		if(loginMember != null) {//해당하는 아이디가 있으면 로그인 완료
			// 4. 파싱 닉네임 세션으로 저장
			session.setAttribute("loginMember", loginMember); // 세션 생성
			model.addAttribute("result", apiResult);
			model.addAttribute("message", loginMember.getName()+ "님 환영합니다!"); 
		
			// 마지막 수정일 확인하여 현재 날짜 간의 차이 구하기
			long diffDay = (new Date().getTime() - loginMember.getLast_modified().getTime()) / (24 * 60 * 60 * 1000);

			if (diffDay < 180) { // 로그인 완료&&비밀번호 변경 필요 없음 메인으로 이동
				model.addAttribute("url", "/main.do");

			} else {// 날짜 차이가 180일 이상이면 비밀번호 변경 요청 페이지로 이동
				model.addAttribute("url", "/chgpwdpage.do");

			}
			return "common/alert";
		}else {//해당되는 아이디가 없으면 정보를 가지고 회원가입 페이지로 이동함
			// 회원가입시 사용
			session.setAttribute("id", id);//id만 보냄(변환아이디는 가입시 사용)
			
			if(age!= null) { //사용자가 age 값을 제공했다면
				//(연령대를 알 수 있으므로 10-19사이가 아닌지 판단하여 회원정보 입력 페이지로 바로 넘어감)
				if(age.substring(0, 2).equals(10)) {//연령대가 10-19사이에 속해있지 않다면
				
					String child ="N";					
				//	session.setAttribute("child", child);
					model.addAttribute("child", child);
					return "redirect:/tospage.do"; //바로 약관동의 페이지로 이동
					
				}else {//연령대정보가 10-19사이에 있다면 (14세 미만인지 체크가 들어가야 함)
				
				//	logger.info(age.substring(0, 2));
				//	return "redirect:/typepage.do";	
					String child ="N";	
					model.addAttribute("child", child);
					return "redirect:/tospage.do"; //바로 약관동의 페이지로 이동
				}				
			
			}else {//사용자가 age 값을 제공하지 않았다면  (14세 미만인지 체크가 들어가야 함)
				//return "redirect:/typepage.do";
				String child ="N";	
				model.addAttribute("child", child);
				return "redirect:/tospage.do"; //바로 약관동의 페이지로 이동
			}
			
		}  
	

	}// 네이버 end

	// 카카오
	@RequestMapping(value = "/kcallback.do", produces = "application/json", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String kakaoLogin(@RequestParam("code") String code, Model model, HttpSession session) throws Exception {

		// 결과값을 node에 담아줌
		JsonNode node = kakao_loginapi.getAccessToken(code); // accessToken에 사용자의 로그인한 모든 정보가 들어있음
		JsonNode accessToken = node.get("access_token"); // 사용자의 정보
		JsonNode userInfo = kakao_loginapi.getKakaoUserInfo(accessToken);

		// 회원가입시 사용		
		String kid = null;//카카오 로그인 id 값 받아오기
		// 유저정보 카카오에서 가져오기 Get properties
		JsonNode properties = userInfo.path("properties");
		JsonNode kakao_account = userInfo.path("kakao_account");// 값 가져올 수 있지만 사용은 안함		
		kid = userInfo.path("id").asText();
		
		// *값 받아온 것을 회원 정보와 확인해야함*//
		Member member = new Member();
		// 아이디 저장되 있는 이름 만들기
		String checkid = "@K" + kid;// 카카오 아이디 저장 값
		member.setId(checkid);
		
		// 간편 로그인 아이디에 해당하는 회원 정보 확인하러가기
		Member loginMember = memberService.selectChkSns(checkid);
		if(loginMember != null) {//해당하는 아이디가 있으면 로그인 완료
			//카카오 로그인 세션에 저장
			session.setAttribute("loginMember", loginMember); // 세션 생성			
			model.addAttribute("message", loginMember.getName()+ "님 환영합니다!"); 
		
			// 마지막 수정일 확인하여 현재 날짜 간의 차이 구하기
			long diffDay = (new Date().getTime() - loginMember.getLast_modified().getTime()) / (24 * 60 * 60 * 1000);

			if (diffDay < 180) { // 로그인 완료&&비밀번호 변경 필요 없음 메인으로 이동
				model.addAttribute("url", "/main.do");

			} else {// 날짜 차이가 180일 이상이면 비밀번호 변경 요청 페이지로 이동
				model.addAttribute("url", "/chgpwdpage.do");

			}
			return "common/alert";
			
		}else {//해당되는 아이디가 없으면 정보를 가지고 회원가입 페이지로 이동함
			//연령대를 알 수 없으므로 모두 회원 가입 제일 처음 페이지로 보낸다.(원래 이래야함)
			//14세 이상으로 보내봄
			String child ="N";					
			model.addAttribute("child", child);
			session.setAttribute("id", kid);//id만 보냄(변환아이디는 가입시 사용)
			session.setAttribute("snstype", "k");//네이버와 비교하기위한 값 같이 보냄
			return"redirect:/tospage.do";
			//return"redirect:/typepage.do";
		}

	}// end kakaoLogin()

	/*----------------------SNS 로그인 : e----------------------------*/
	
	
	// SMS(단문) 발송 2.2v
	// 90바이트( 한글 45자 ) 이내의 내용을 문자 메시지로 보낼 수 있음 
	//회원가입(본인,보호자) 및 회원 정보 수정시 인증번호 발송
	@RequestMapping(value = "sendsms.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void sendSms(@RequestParam("phone") String phone, HttpSession session) {

		String api_key = "NCSUROQB8LPQDULH"; // 개인용 키
		String api_secret = "UR00YWTXK8QGKC6MPQWKGGHAJLXINCLU";// 개인용 시크릿 키

		// 인증 번호 생성
		int key = ThreadLocalRandom.current().nextInt(100000, 1000000);
		
		Message coolsms = new Message(api_key, api_secret);// 메세지 보내기 객체 생성

		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", phone); // 수신번호
		params.put("from", "01071322475");// 발신번호- 픽스값임
		params.put("type", "SMS");// 문자 타입
		params.put("text", "[MNR 클리닉] 본인확인 인증번호[" + key + "]를 화면에 입력해주세요");// 문자내용
		params.put("app_version", "test app 1.2"); // application name and version

		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			logger.info("obj" + obj.toString());

		} catch (CoolsmsException e) {
			logger.info("sms에러 :" + e.getMessage());
			logger.info("sms에러 :" + e.getCode());

		}
		session.setAttribute("key", key);
		

	}
	
	//비밀번호 전송 완료 페이지로 이동
	@RequestMapping("mencompage.do")
	public String moveEnPComPage() {
		
		return"member/sendEnPComPage";
	}
	
	//비밀번호 찾기 -sms로 임시 비밀번호 발송
	@RequestMapping(value = "sendsmspwd.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void sendSmsPwd(Member member,Model model, HttpServletResponse response)throws IOException {
			
		response.setContentType("text/html; charset=UTF-8");	 
		PrintWriter out = response.getWriter();	
		
		//회원정보 일치하는 회원이 있나 확인
		int result = 0;
		result = memberService.selectChkMem(member);
		
		if(result>0) {//일치하는 회원이 있다면
			
			
			String api_key = "NCSUROQB8LPQDULH"; // 개인용 키
			String api_secret = "UR00YWTXK8QGKC6MPQWKGGHAJLXINCLU";// 개인용 시크릿 키
			
			//수신 번호
			String phone = member.getPhone();
			
			/*비밀번호를 임시 비밀번호로 변경하기*/
			//임시 비밀번호 랜덤으로 생성
			RandomPassword rpwd = new RandomPassword();
			String temppwd = rpwd.randomPassword(10);

			Message coolsms = new Message(api_key, api_secret);// 메세지 보내기 객체 생성

			// 4 params(to, from, type, text) are mandatory. must be filled
			HashMap<String, String> params = new HashMap<String, String>();
			params.put("to", phone); // 수신번호
			params.put("from", "01071322475");// 발신번호- 픽스값임
			params.put("type", "SMS");// 문자 타입
			params.put("text", "[MNR 클리닉] 임시 비밀번호는[" + temppwd + "]입니다");// 문자내용
			params.put("app_version", "test app 1.2"); // application name and version

			try {
				JSONObject obj = (JSONObject) coolsms.send(params);
				logger.info("obj" + obj.toString());

			} catch (CoolsmsException e) {
				logger.info("sms에러 :" + e.getMessage());
				logger.info("sms에러 :" + e.getCode());

			}
			//랜덤 생성한 비밀번호로 업데이트하기
			Member chkmember = new Member();
			chkmember.setId(member.getId());
			chkmember.setPwd(temppwd);
			memberService.updateTempPwd(chkmember);
			
			out.println("<script> location.href='mencompage.do?';</script>");	 
			out.flush();
			
		
		}else {//일치하는 회원이 없다면
			out.println("<script> location.href='searchPwdMove.do';</script>");	 
			out.flush();
		}
	
		out.close();
	}
	

	// 아이디 중복체크
	@ResponseBody
	@RequestMapping(value = "idcheck.do", method = RequestMethod.POST)
	public int idDuplCheck(@RequestParam("id") String id) {
		int result = 0;
		result = memberService.selectIdCheck(id);
		return result;
	}

	// 이메일 중복체크
	@ResponseBody
	@RequestMapping(value = "emailCheck.do", method = RequestMethod.POST)
	public int emailDupCheck(@RequestParam("email") String email) {
		int result = 0;
		result = memberService.selectEmailCheck(email);
		return result;
	}
	
	//아이디 찾기 페이지로 이동
	@RequestMapping(value="searchIdMove.do")
	public String searhchIDMove() {	
		return "member/searchIdPage";
	}
		
	//이메일로 아이디 찾기
	//@ResponseBody
	@RequestMapping(value="chkidinfo.do", method =RequestMethod.POST)
	public String checkFindIdInfo(Member member, Model model) {
		
		String id = memberService.selectMemberFid(member);
		logger.info(id);
		
		if(id !=null) {//일치하는 회원정보가 있음
			
			if(id.contains("@")) {//만일 sns 간편 회원 가입 회원일 경우
				logger.info("확인");
				model.addAttribute("message", "sns 간편가입 회원이십니다. sns로 로그인 해주세요");
				model.addAttribute("url", "/searchIdMove.do");
				return "common/alert";
			}else {
				model.addAttribute("id", id);
				return "member/findIdComPage";
			}
			
		}else {//일치하는 회원정보가 없음
			model.addAttribute("message", "일치하는 회원정보가 없습니다.");
			model.addAttribute("url", "/searchIdMove.do");
			return "common/alert";
		}

	}
	
	//휴대폰으로 아이디 찾기
	@RequestMapping(value="chkidphinfo.do", method =RequestMethod.POST)
	public String checkFindIdInfo2(Member member, Model model) {
		
		String id = memberService.selectMemberFid2(member);
		logger.info(id);
		//return id;
		if(id !=null) {//일치하는 회원정보가 있음
			
			if(id.contains("@")) {//만일 sns 간편 회원 가입 회원일 경우
				logger.info("확인");
				model.addAttribute("message", "sns 간편가입 회원이십니다. sns로 로그인 해주세요");
				model.addAttribute("url", "/searchIdMove.do");
				return "common/alert";
			}else {
				model.addAttribute("id", id);
				return "member/findIdComPage";
			}
			
		}else {//일치하는 회원정보가 없음
			model.addAttribute("message", "일치하는 회원정보가 없습니다.");
			model.addAttribute("url", "/searchIdMove.do");
			return "common/alert";
		}

	}

	//비밀번호 찾기 페이지로 이동
	@RequestMapping("searchPwdMove.do")
	public String searchPwdMove() {
		return "member/searchPwdPage";
	}
	
	
	//관리자 고객관리 페이지로 이동	
	@RequestMapping("adpagemove.do")
	public String moveAdminPage() {
		return "redirect:/mlist.do?page=1";
	}
	
	//회원 전체 조회 (한 페이지에 10명씩 출력)
	@RequestMapping("mlist.do")
	public String memberList(HttpServletRequest request,Model model){
		
		// 페이지 기본 값 지정​
		int currentPage = 1;

		// 전송 온 페이지값 추출​
		if (request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}

		// 한 페이지당 출력할 목록 갯수 지정​
		int limit = 10;

		// 전체 목록 갯수 조회
		int listCount = memberService.selectMemberGetListCount();

	
		// 밑에 나올 페이지 숫자를 계산해야 함
		int maxPage = (int) ((double) listCount / limit + 0.9);
		// 현재 페이지가 속한 그룹의 시작 페이지 수 지정
		int startPage = ((int) ((double) currentPage / limit + 0.9) - 1) * limit + 1;
		int endPage = startPage + limit - 1;

		if (maxPage < endPage) {
			endPage = maxPage;
		}
		  
		int startRow = (currentPage -1) * limit +1;
		int endRow = startRow + limit -1;
		MemberPage mPage = new MemberPage(startRow, endRow);		
		
		ArrayList<Member> list = new ArrayList<Member>();
		list=memberService.selectMemberList(mPage);
		
		if(list.size()>0) {
			model.addAttribute("list", list);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("listCount", listCount);
			return "member/memberListPage";
		}else {
			model.addAttribute("message", "전체 회원 목록을 불러올 수 없습니다");
			model.addAttribute("url", "/mlist.do");
			return "common/alert";
		}
		
	}

	//회원 유형별 조회
	@RequestMapping(value="msearch.do", method=RequestMethod.POST)
	public String memberSearch(HttpServletRequest request,Model model) {


		String action = request.getParameter("action");
		String keyword = request.getParameter("keyword"); 
		// 페이지 기본 값 지정​
		int currentPage = 1;

		// 전송 온 페이지값 추출​
		if (request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}

		// 한 페이지당 출력할 목록 갯수 지정​
		int limit = 10;
		
		// 전체 목록 갯수 조회
		int listCount = 0;

		switch (action) { // action value 값에 따른 각 목록의 갯수 조회
		case "id":
			listCount = memberService.selectGetListCountId(keyword);
			break;
		case "name":
			listCount = memberService.selectGetListCountName(keyword);
			break;
		case "gender":
			listCount = memberService.selectGetListCountGen(keyword);
			break;
		case "age":
			listCount = memberService.selectGetListCountAge(Integer.parseInt(keyword));
			break;
		
		}
		
		// 밑에 나올 페이지 숫자를 계산해야 함
		int maxPage = (int) ((double) listCount / limit + 0.9);
		// 현재 페이지가 속한 그룹의 시작 페이지 수 지정
		int startPage = ((int) ((double) currentPage / limit + 0.9) - 1) * limit + 1;
		int endPage = startPage + limit - 1;

		if (maxPage < endPage) {
			endPage = maxPage;
		}

		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		MemberPage mPage = new MemberPage(startRow, endRow);
		
		// 서비스 객체 생성하고, 메소드 실행하고 결과 받기
		ArrayList<Member> list = null;

		switch (action) {
		case "id":
			list = memberService.selectSearchid(keyword);
			break;
		case "name":
			list = memberService.selectSearchName(keyword);
			break;	
		case "gender":
			list = memberService.selectSearchGender(keyword);
			break;
		case "age":
			list = memberService.selectSearchAge(Integer.parseInt(keyword));
			break;
		}

		// 받은 결과에 대한 뷰 내보내기
		if (list.size() > 0) {
			model.addAttribute("list", list);		
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("listCount", listCount);
			return "member/memberListPage";
		} else {
			model.addAttribute("message","해당 결과가 존재하지 않습니다");
			model.addAttribute("url","/mlist.do");
			return "common/alert";
		}
		
	}
	
	//관리자의 회원 탈퇴처리	
	@RequestMapping("mdeletead.do")
	public String deleteMemberAd(HttpServletRequest request,Model model)  {
			System.out.println(request.getParameterValues("mid"));
		if (request.getParameterValues("mid")== null) {
			model.addAttribute("message","탈퇴시킬 회원을 선택해주세요");			
			
		} else {
			// 받아온 체크박스 id 배열에 담기
			String[] idarr = request.getParameterValues("mid");

			// id[] 길이만큼 delete 실행
			int result = 0;
			for (int i = 0; i < idarr.length; i++) {
				String id = idarr[i];
				result = memberService.deleteMemberAd(id);
			}

			if (result > 0) {
				model.addAttribute("message","회원 탈퇴 요청에 성공했습니다");
								
			} else {
				model.addAttribute("message","회원 탈퇴 요청에 실패했습니다");
							
			}
		}
		
		model.addAttribute("url","/mlist.do?page=1");
		return "common/alert";
	}
	
	
	//비밀번호 찾기 이메일 보내기
	//@ResponseBody
	@RequestMapping(value="sendemail.do", method=RequestMethod.POST)
	public String sendEmail(HttpServletRequest request, Model model)throws Exception{
		logger.info("이메일 보내기");
		//입력한 정보 받아오기
		String id = request.getParameter("id");
		String email = request.getParameter("email2");
		Member member = new Member();
		member.setId(id);
		member.setEmail(email);
		
		//받은 정보에 일치하는 회원 있는지 확인하기
		Member chkmember = memberService.selectChkMember(member);
		int result=0;
		if(chkmember !=null) {//일치하는 회원 정보가 있다면
			
			/*비밀번호를 임시 비밀번호로 변경하기*/
			//임시 비밀번호 랜덤으로 생성
			RandomPassword rpwd = new RandomPassword();
			String temppwd = rpwd.randomPassword(10);
			chkmember.setPwd(temppwd); //임시 비밀번호 담기
			result = memberService.updateTempPwd(chkmember);
			if(result>0) {//임시비밀번호 바꾸기에 성공하면 이메일 보냄
				//메일 관련 정보
				String host ="smtp.naver.com";
				final String username="good_in123";//네이버 주소중@앞부분 작성
				final String password ="rntrnt!123";
				int port=465;
				
				//메일 내용
				String recipient=email;//받는 이메일 주소
				String subject ="미앤란 클리닉에서 임시비밀번호 안내입니다";//이메일 발송 제목
				String body ="임시 비밀번호는 "+temppwd+" 입니다";//메일 발송시 내용
				
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
			
				return "member/sendEnPComPage";
			}else { //임시 비밀번호로 바꾸기 실패
				
				model.addAttribute("message","일시적인 오류가 발생했습니다.\n다시 시도해주세요");
				model.addAttribute("url","/searchIdMove.do");
				return "common/alert";
			}
			
		}else {//일치하는 회원 정보가 없다면
			
			model.addAttribute("message","일치하는 회원 정보가 없습니다.");
			model.addAttribute("url","/searchIdMove.do");
			return "common/alert";
		}
		
	}
	
	//일반회원가입-SNS회원가입 제외 (+유효성 검사+가입환영 메일 발송) //***비밀번호 암호화 적용해야함
	@RequestMapping(value = "menroll.do", method = RequestMethod.POST)
	public String enrollMember(@Valid @ModelAttribute Member member,
			 BindingResult bindingResult,HttpSession sess,Model model) throws java.text.ParseException, AddressException, MessagingException {
		
		if (bindingResult.hasErrors()) {
			logger.info("회원가입 유효성 검사를 통과하지 못함");		
		//	session.setAttribute("child", member.getChild());
			logger.info(member.toString());		
			
			return "member/enrollInfoPage";
			
		} else {// 유효성 검사 통과시
			logger.info("유효성 검사를 통과함");
			logger.info(member.toString());
		
			
			int result = memberService.insertMember(member);
			if (result > 0) {// 회원 가입 완료됨
			
				//회원가입 완료시 환영 이메일 발송합니다
				//메일 관련 정보
				String host ="smtp.naver.com";
				final String username="good_in123";//네이버 주소중@앞부분 작성
				final String password ="rntrnt!123";
				int port=465;
				
				//메일 내용
				String recipient=member.getEmail();//받는 이메일 주소
				String subject ="미앤란 클리닉의 회원이 되신 것을 환영합니다!";//이메일 발송 제목
				String body =member.getName()+"님 미앤란 클리닉의 회원이 되신 것을 환영합니다\n";//메일 발송시 내용
				String content ="<img src=\"https://postfiles.pstatic.net/MjAyMDA5MjdfMjA1/MDAxNjAxMTMzNjQwNDgz.MQsPwismXrqZMPcqezKF0VHDJ-gtdpRvzyUJ2f0qk1wg.uM1hv29NfE7Tnuqzew6T_IhNcalLeaYAGPhxqoewd4Yg.JPEG.kyzuna/welcom-1.jpg?type=w773\">";
				 			
				
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
				mimeMessage.setContent(content, "text/html");
				
				Transport.send(mimeMessage);
				
				// 회원가입 완료시 session을 만료해야함
				sess.invalidate(); // session 값 사용하던 것을 만료해야함
				model.addAttribute("message", "회원가입에 성공했습니다");
				model.addAttribute("url", "/loginpage.do");// 회원가입 성공시 로그인 페이지로 이동함
			
				
			} else {
				model.addAttribute("message", "일시적인 오류가 발생했습니다\n 다시 시도해 주세요");
				model.addAttribute("url", "/enrollpage.do");// 회원정보 입력 페이지로 다시이동

			}
			return "common/alert";
			}
		

	}
	
	
	
	//SNS 간편 회원가입 (+유효성 검사+가입환영메일 발송) //***비밀번호 암호화 추가해야함
	@RequestMapping(value = "msnsenroll.do", method = RequestMethod.POST)
	public String enrollSnsMember(@Valid @ModelAttribute Member member,
			 BindingResult bindingResult,HttpSession sess,Model model) throws AddressException, MessagingException {
		
		if (bindingResult.hasErrors()) {
			logger.info("sns 간편 회원가입을 위한 유효성 검사를 통과하지 못함");		
			sess.setAttribute("child", member.getChild());
			System.out.println(member);
			return "member/enrollSnsInfoPage"; //sns 간편 회원가입 페이지로 리턴
			
		} else {//유효성 검사 통과시
			logger.info("sns 간편 회원가입의 유효성 검사를 통과함");
			if(sess.getAttribute("snstype")==null) {//카카오sns 가입이 아닐경우
				//sns 회원가입시 db에 저장될 아이디 생성
				String snsId = "@N"+member.getId();
				member.setId(snsId);
				logger.info("네이버 snsId :"+snsId);
				logger.info(member.toString());
				
			}else {//카카오sns 가입일 경우
				String snsId = "@K"+member.getId();
				member.setId(snsId);
				logger.info("카카오 snsId :"+snsId);
				logger.info(member.toString());			
			}
			//네이버/카카오 공통임
			if (member.getChild() == null) {// 체크박스 값이 체크 되있지 않은 상태로 전송 됨
				member.setChild("N");//14세 미만 아니라는 값으로 보내져야함
			}
			int result = memberService.insertMember(member);
			if (result > 0) {// 회원 가입 완료됨
				
				//회원가입 완료시 환영 이메일 발송합니다
				//메일 관련 정보
				String host ="smtp.naver.com";
				final String username="good_in123";//네이버 주소중@앞부분 작성
				final String password ="rntrnt!123";
				int port=465;
				
				//메일 내용
				String recipient=member.getEmail();//받는 이메일 주소
				String subject ="미앤란 클리닉의 회원이 되신 것을 환영합니다!";//이메일 발송 제목
				String body =member.getName()+"님 미앤란 클리닉의 회원이 되신 것을 환영합니다";//메일 발송시 내용
				String content ="<img src=\"https://postfiles.pstatic.net/MjAyMDA5MjdfMjA1/MDAxNjAxMTMzNjQwNDgz.MQsPwismXrqZMPcqezKF0VHDJ-gtdpRvzyUJ2f0qk1wg.uM1hv29NfE7Tnuqzew6T_IhNcalLeaYAGPhxqoewd4Yg.JPEG.kyzuna/welcom-1.jpg?type=w773\">";
				
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
				mimeMessage.setContent(content, "text/html");
				Transport.send(mimeMessage);
				
				// 회원가입 완료시 session을 만료해야함
				sess.invalidate(); // session 값 사용하던 것을 만료해야함
				model.addAttribute("message", "회원가입에 성공했습니다");
				model.addAttribute("url", "/loginpage.do");// 회원가입 성공시 로그인 페이지로 이동함
				return "common/alert";
			} else {
				model.addAttribute("message", "일시적인 오류가 발생했습니다\n 다시 시도해 주세요");
				model.addAttribute("url", "/enrollpage.do");// 회원정보 입력 페이지로 다시이동
				return "common/alert";
			}
			
			
		}
	
		
	}
	
	//마이페이지 메인에서 회원정보 수정 페이지로 이동 전 현재 비밀번호 체크 페이지로 이동
	@RequestMapping("mchangeinfo.do")
	public String moveChangeInfo() {
		return "member/checkPwdPage";
	}
	
	//회원정보 수정 전 현재 비밀번호 확인하기
	@RequestMapping(value="chkinfobc.do", method = RequestMethod.POST)	
	public void checkInfobc(Member member,Model model,HttpSession session, HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html; charset=UTF-8");	 
		PrintWriter out = response.getWriter();	
		if(memberService.selectCkPwd(member)>0) {//일치하는 회원 정보가 존재한다면
		
				out.println("<script> location.href='mupmpage.do';</script>");	 
				out.flush();
						
		}else {//일치하는 회원 정보가 존재하지 않는다면
			
			out.println("<script>alert('비밀번호가 일치하지 않습니다'); location.href='mchangeinfo.do';</script>");	 
			out.flush();
					
		}
		out.close();
	
	}
	
	//회원정보 수정페이지로 이동
	@RequestMapping("mupmpage.do")
	public String moveUpdateMPage(Model model,HttpSession session,HttpServletRequest request) {
		HttpServletRequest hrequest = (HttpServletRequest)request;
        Member loginMember = (Member)hrequest.getSession(false).getAttribute("loginMember");//false : 있는 것 가져와
        String id=loginMember.getId();			
        Member okMember =memberService.selectOneMem(id);
		model.addAttribute("okMember", okMember);	
		return "member/changeInfoPage";
	}
	
	
	//회원정보 수정하기
	@RequestMapping(value="chgmeminfo.do", method = RequestMethod.POST)
	public String changeMemInfo(Member member,Model model,HttpServletResponse response) {
		logger.info(member.toString());
		
		int result =memberService.updateMemInfo(member);
		if(result>0) {//회원정보 수정 완료
			logger.info(member.toString());
			Member loginMember = memberService.selectOneMem(member.getId());
			model.addAttribute("okMember", loginMember);
			return "redirect:/mypagefm.do";
		}else {//회원정보 수정 실패
			model.addAttribute("message", "회원정보 수정에 실패했습니다 \n 다시 시도해 주세요");
			model.addAttribute("url", "/mchangeinfo.do");
			return "common/alert";
		}
		
	}
	
	//마이페이지에서 비밀번호 변경 페이지
	@RequestMapping("mchgpwdpage.do")
	public String MvChangeMemPwdPage() {
		return "member/changePwdPage";
	}
	
	// 마이페이지에서 비밀번호 변경 전 현재 비밀번호 확인 **비밀번호 암호화 적용해야함**
		@RequestMapping(value = "pwdchk2.do", method = RequestMethod.POST)
		public String pwdCheck2(Member member, Model model,@RequestParam("pwd2") String pwd2) {

			if (memberService.selectCkPwd(member) > 0) {// 일치하는 정보 존재시
				member.setPwd(pwd2);//비밀번호 변경값을 가져가기
				System.out.println(member);
				if (memberService.updatePwd(member) > 0) {
					model.addAttribute("message", "비밀번호 변경에 성공했습니다");			
				
				} else {
					model.addAttribute("message", "비밀번호 변경에 실패했습니다");
						
				}
				model.addAttribute("url", "/mypagefm.do");
			} else {
				model.addAttribute("message", "비밀번호가 일치 하지 않습니다");
				model.addAttribute("url", "/mchgpwdpage.do");//
				
			}
			return "common/alert";
		}
	
	//마이페이지에서 탈퇴 요청 처리 전 현재 비밀번호 확인하는 페이지로 이동
	@RequestMapping("mdelchkinfo.do")
	public String moveDelteCheckInfo() {
		return "member/checkPwdDelPage";
	}
	
	//회원탈퇴 전 현재 비밀번호 확인하기
	@RequestMapping("chkinfobd.do")
	public void checkInfobd(Member member,Model model,HttpSession session, HttpServletResponse response) throws IOException {	
		response.setContentType("text/html; charset=UTF-8");	 
		PrintWriter out = response.getWriter();	
		if(memberService.selectCkPwd(member)>0) {//일치하는 회원 정보가 존재한다면
			//회원 탈퇴 시키기
			int result =0;
			result = memberService.deleteMemberAd(member.getId());

			if(result>0) {//탈퇴 처리에 성공하였다면
				
				session.invalidate();//세션 만료 시키기
				
				out.println("<script>alert('탈퇴처리가 완료되었습니다'); location.href='main.do';</script>");	 
				out.flush();
			
			}else {//탈퇴 처리에 실패 하였다면
				
			
				out.println("<script>alert('탈퇴처리에 실패했습니다'); location.href='mdelchkinfo.do';</script>");	 
				out.flush();
			}
			
		}else {//비밀번호가 일치하지 않을 경우
			
			out.println("<script>alert('비밀번호가 일치하지 않습니다'); location.href='mdelchkinfo.do';</script>");	 
			out.flush();
			
		
		}
		out.close();
		
	}
	
	//마이페이지 메인 페이지로의 이동
		@RequestMapping(value="mypagefm.do")
		public String moveMyPageMain(Model model,HttpSession session,HttpServletRequest request) {
			//회원 정보 가져오기
			HttpServletRequest hrequest = (HttpServletRequest)request;
	        Member loginMember = (Member)hrequest.getSession(false).getAttribute("loginMember");//false : 있는 것 가져와
	        String id=loginMember.getId();			
	        Member okMember =memberService.selectOneMem(id);
	        
	        //가장최근 예약 가져오기
	       //전체 리스트를 일단 가져옴 
	       ArrayList<Reservation> list = reservationService.selectMyList(loginMember.getId());
	      	Reservation curres = null;
	       		if (list.size()> 0) {
	       				curres = list.get(0);
	       				logger.info("가장최근 예약값:" + curres.toString());
	       				
	       		}
	       	model.addAttribute("curres", curres);	
			model.addAttribute("okMember", okMember);	
			return "member/myPageMain";
		}
				
		//회원수정 페이지에서 휴대폰 번호 수정 팝업
		@RequestMapping("mphonepop.do")
		public String moveEmailUpdate() {
			return"member/checkPhonePopup";
		}
		
		
		/*중복되는 정보 있는지 확인*/
		//14세 이상 성인 본인인증 메소드  //
		@ResponseBody
		@RequestMapping(value = "test2.do", method = RequestMethod.POST)
		public String testMethod2(@RequestParam("phone") String phone, HttpSession session, Model model) {

			String keycode = "";
			if (memberService.selectChkPhone(phone) > 0) {// 중복정보 있음
				logger.info("중복정보가 있음");
				keycode = "dul";
				return keycode;
			} else {
				logger.info("중복정보 없음");
				logger.info("휴대폰 번호 :" + phone);
				String api_key = "NCSUROQB8LPQDULH"; // 개인용 키
				String api_secret = "UR00YWTXK8QGKC6MPQWKGGHAJLXINCLU";// 개인용 시크릿 키

				// 인증 번호 생성
				int key = ThreadLocalRandom.current().nextInt(100000, 1000000);
				System.out.println("key값" + key);
				Message coolsms = new Message(api_key, api_secret);// 메세지 보내기 객체 생성

				// 4 params(to, from, type, text) are mandatory. must be filled
				HashMap<String, String> params = new HashMap<String, String>();
				params.put("to", phone); // 수신번호
				params.put("from", "01071322475");// 발신번호- 픽스값임
				params.put("type", "SMS");// 문자 타입
				params.put("text", "[MNR 클리닉] 휴대폰  인증번호[" + key + "]를 화면에 입력해주세요");// 문자내용
				params.put("app_version", "test app 1.2"); // application name and version

				try {
					JSONObject obj = (JSONObject) coolsms.send(params);
					logger.info("obj" + obj.toString());

				} catch (CoolsmsException e) {
					logger.info("sms에러 :" + e.getMessage());
					logger.info("sms에러 :" + e.getCode());

				}
				// session.setAttribute("key", key);
				keycode = Integer.toString(key);
				logger.info("keycode값:" + keycode);
				return keycode;
			}

		}

	
	//14세 미만 보호자 인증 메소드  //
	@ResponseBody
	@RequestMapping(value = "test7.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String testMethod7(@RequestParam("phone") String phone, HttpSession session, Model model) {

		String keycode = "";

		logger.info("보호자 휴대폰 번호 :" + phone);
		String api_key = "NCSUROQB8LPQDULH"; // 개인용 키
		String api_secret = "UR00YWTXK8QGKC6MPQWKGGHAJLXINCLU";// 개인용 시크릿 키

		// 인증 번호 생성
		int key = ThreadLocalRandom.current().nextInt(100000, 1000000);
		System.out.println("key값" + key);
		Message coolsms = new Message(api_key, api_secret);// 메세지 보내기 객체 생성

		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", phone); // 수신번호
		params.put("from", "01071322475");// 발신번호- 픽스값임
		params.put("type", "SMS");// 문자 타입
		params.put("text", "[MNR 클리닉] 보호자 인증번호[" + key + "]를 화면에 입력해주세요");// 문자내용
		params.put("app_version", "test app 1.2"); // application name and version

		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			logger.info("obj" + obj.toString());

		} catch (CoolsmsException e) {
			logger.info("sms에러 :" + e.getMessage());
			logger.info("sms에러 :" + e.getCode());

		}
		// session.setAttribute("key", key);
		keycode = Integer.toString(key);
		logger.info("keycode값:" + keycode);
		return keycode;

	}

	
}
