<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<!--맨 밑 footer만 보이게 설정-->
<style type="text/css">
#footer .footer_in .cont {
	display: none;
}
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
					<li><a href="${ pageContext.servletContext.contextPath }/pgchkmove.do" title="회원가입">회원가입</a></li>
					<!-- <li><a href="#" title="약관동의">약관동의</a></li> -->
				</ul>
			</nav>
		</div>
	</div><!-- subPageTop:e 서브페이지 상단 제목 공통-->
	<!--outLogWrap:s-->
	<div id="enrollCon_allwrap">
		<h2>미앤란 클리닉 회원가입</h2>
		<p>기존에 가지고 계시는 계정으로 간편하게 회원가입 가능합니다</p>
		
		<hr style="width: 100%;">
		<div id="wrap2_first">
			<ul class="clear">

				<li class="type_left">
				<%-- <a href="${ pageContext.servletContext.contextPath}/typepage.do" 
						class="cp">--%>  
						<span><img src="/danaa/resources/images/enroll_logo_01.png" alt="일반회원"></span> 
						<p>일반회원 회원가입</p>
						
					<!-- </a> -->
					<hr class="enrollBorder">
					<div class="function-box-nor" >
						
							<span><a href="${ pageContext.servletContext.contextPath}/typepage.do" class="btn btn-block btn-lg btn-category font-weight-bold"  style="opacity: 1; cursor:pointer;" onmouseover="this.style.opacity='0.7'"
						onmouseout="this.style.opacity='1'"> 일반회원 가입하기</a>
								</span>
						
					</div>
				</li>
				<li class="type_right_">
					<!-- 네이버 로그인 창으로 이동 --> <a href="#" class="cp"> <span><img
							src="/danaa/resources/images/enroll_logo_02.png" alt="일반회원" style="margin-bottom: 21px"></span>
						SNS간편 회원가입
				</a>
					<hr class="enrollBorder"> <a href="<c:url value='${nurl}'/>" class="cp_naver_first">
						<img src="/danaa/resources/images/naver_enroll_logo_02.png"
							alt="네이버로고">
				</a> <!-- 카카오 로그인 창으로 이동 --> 
				<a href="<c:url value='${kurl}'/>"  class="cp_kakao_first">
					<img src="/danaa/resources/images/kakao_enroll_logo_02.png" alt="카카오로고">
						
				</a>


				</li>
			</ul>
		</div>

		<!--outLogWrap:e-->
	
		<%-- <div class="enroll_m_check">
			<span>이미 회원이신가요?</span> 
			<a href="<c:url value='loginpage.do'/>">로그인</a>
		</div> --%>
	
	</div><!--outallWrap:e-->
		<!-- footer -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />
	
	
</body>
</html>