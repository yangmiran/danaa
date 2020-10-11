package com.kh.danaa.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.danaa.member.model.vo.Member;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
					Object handler) throws Exception {
		//DispatcherServlet에서 Controller 가기 전에 구동되는 메소드

		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		if(loginMember != null) { //로그인한 상태라면
			
		} else { //로그인하지 않았다면			
			request.setAttribute("url", "/loginpage.do");
			request.setAttribute("message", "로그인하셔야 이용할 수 있는 서비스입니다.");
			request.getRequestDispatcher("/WEB-INF/views/common/alert.jsp").forward(request, response);
			
			return false; //컨트롤러로 안 가고 리턴하면, 뷰를 직접 지정함.//			
		}
		return super.preHandle(request, response, handler); //기본이 true임.
		
	}
}
