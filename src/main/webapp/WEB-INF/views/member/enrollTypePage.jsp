<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<!-- 회원가입STEP01 페이지 -->

<!--맨 밑 footer만 보이게 설정--> 
<style type="text/css">
#footer .footer_in .cont {display: none;}
</style>

<c:import url="/WEB-INF/views/common/meta.jsp" />

<!-- header -->
<c:import url="/WEB-INF/views/common/header.jsp" />

</head>
<body>

<!-- subPageTop:s 서브페이지 상단 제목 공통-->
	<div class="subPageTop">
		<div class="sub">
			<div class="s_top_gp_wrap">
				<img src="resources/images/sub_top_join_01.jpg">
				<div class="title_wrap">
					<p>회원가입</p>
					<p>MNR CLINIC JOIN</p>
					<p>회원으로 가입하시면 더욱 다양한 컨텐츠 및 서비스를 받아보실 수 있습니다.</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span> Home
					</a></li>
					<li><a href="${ pageContext.servletContext.contextPath }/enrollfp.do" title="회원가입">회원가입</a></li>
					<li><a href="<c:url value='typepage.do'/>" title="회원가입 유형">회원가입 유형</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->
	<div id="enrollT_allwrap"><!-- 전체 :s -->
	<div id="wrap">
		<div class="enroll_bar">

				<div class="sub-title">
				
		<h3>회원가입 유형을 선택해 주시기 바랍니다.</h3><br>
	    <p>회원 유형에 따라 이용 가능한 서비스가 다를 수 있습니다.</p>
	<hr>
	</div>
		</div>
	
	</div><!-- wrap 끝 -->
	
	
	<div id="wrap2">
		<ul class="clear">
			
			<li class="type_left">
					<c:url var="tospy" value="tospage.do">
						<c:param name="child" value="Y"/> 
					</c:url>				
					<a href="${tospy}" style="opacity:0.7" 
						onmouseover="this.style.opacity='1'" 
						onmouseout="this.style.opacity='0.7'">
				<img src = "/danaa/resources/images/child.png" alt="어린이회원" >				
					<span>어린이 회원</span>
					<p>만 14세 미만</p>
				</a>
			</li>
			<li class="type_right">
					<c:url var="tospn" value="tospage.do">
						<c:param name="child" value="N"/> 
					</c:url>
				<a href="${tospn}" style="opacity:0.7" 
					onmouseover="this.style.opacity='1'" 
					onmouseout="this.style.opacity='0.7'">
				<img src = "/danaa/resources/images/adult.png" alt="일반회원">
					<span>일반 회원</span>
					<p>만 14세 이상</p>
				</a>
			</li>
			
		
		</ul>
			
	</div>
	<div class="sub-title2">
	<br>
	<hr>
	<br>
		<pre>환자 본인의 정보로 회원가입을 하셔야 합니다.
홈페이지 진료회원은 진료예약관리 및 다양한 환자 서비스를 이용하실 수 있습니다.
어린이 진료회원(14세 미만)은 법적대리인(보호자)의 실명인증 후 가입이 가능합니다.</pre>
	
	</div>
	
<br>
</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>