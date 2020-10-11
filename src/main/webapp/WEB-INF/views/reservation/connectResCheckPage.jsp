<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<c:import url="/WEB-INF/views/common/meta.jsp" />
<!--맨 밑 footer만 보이게 설정-->
<style type="text/css">
#footer .footer_in .cont {
	display: none;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/header.jsp" />
	<!-- subPageTop:s 서브페이지 상단 제목 공통-->
	<div class="subPageTop">
		<div class="sub">
                 	<div class="s_top_gp_wrap">
                  	<img src="resources/images/sub_top_03.jpg">
                      <div class="title_wrap">
                         <p>예약 확인</p>
                         <p>MNR CLINIC RESERVATION</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a href="${ pageContext.servletContext.contextPath }/main.do" title="홈 바로가기"> <span class="ti-home"></span> Home</a></li>
					<li><a href="#" title="진료예약">진료예약</a></li>
					<c:if test="${ empty loginMember }"><!--로그인 안한 상태일 경우-->					
						<li><a href="moveCheckRes.do" title="예약확인">예약확인</a></li>
					</c:if>			
					<c:if test="${ !empty loginMember }"><!--로그인 한 상태일 경우-->
						<li><a href="checkRes.do?member_id=${ loginMember.id }" title="예약확인">예약확인</a></li>
					</c:if>	
				</ul>
			</nav>
                </div>
	</div>
	<div id="rrwrap" align="center">
	<!--section loginWrap:s-->
	<section id="ssWrap">
		<!--login-left:s-->
			<form action="login.do" name="login" id="login" method="post">
				<div class="checkRes">
					<h2>회원 로그인</h2>
					<h4 style="color:red;">회원은 로그인 후 이용해주시기 바랍니다.</h4>
				</div>
				<div class="sw-form">
					<dl>
						<dt>
							<label for="id"><span class="ti-user"></span></label>
						</dt>
						<dd>
							<input type="text" name="id" id="id" placeholder="ID">
						</dd>
					</dl>
					<dl>
						<dt>
							<label for="password"><span class="ti-unlock"></span></label>
						</dt>
						<dd>
							<input type="password" name="pwd" id="password"
								placeholder="Password">
						</dd>
					</dl>
					<div class="res_btn_box">
						<input type="submit" id="resSubmit" class="resboard_btn btn_common" value="로그인" style="cursor:pointer;">
					</div>
				</div>
			</form>
		<!--login-left:e-->	
	</section>
	
	<!--section loginWrap:e-->
	<section id="btwrap">
	
	<form action="checkNres.do" method="post" name="regc_form">
		<div class="checkRes">
			<h2>비회원 온라인 예약 확인</h2>
			<h4 style="color:red;">예약 시 입력하신 이름, 연락처, 비밀번호를 입력해주세요.</h4>
			<!-- <h4 style="color:red;">(회원은 로그인 후 이용해주시기 바랍니다.)</h4> -->
		</div>
		<div class="sw-form">
		<span class="checkResInput">		
			<input name="res_name" id="res_name" class="inputRes" placeholder="이름">
		</span>
		<span class="checkResInput">	
			<input type="text" name="res_phone" id="res_phone" class="inputRes" placeholder="연락처" required>
		</span>
		<span class="checkResInput">	
			<input type="password" placeholder="비밀번호" class="inputRes" name="res_passwd" id="res_passwd">
		</span>

		<div class="res_btn_box">
			<input type="submit" id="resSubmit" class="resboard_btn btn_common" value="예약확인" style="cursor:pointer;">
		</div>
		</div>
	</form>
	</section>
	</div>
	
	<c:import url="/WEB-INF/views/common/footer.jsp" />	
</body>
</html>