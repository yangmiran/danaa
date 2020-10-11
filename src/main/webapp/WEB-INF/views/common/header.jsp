<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<script>
$(document).ready(function () {
	$("#uheader").mouseover(function () {
		$(".gnb_more").show();
		$("#uheader .sub_bg").addClass("on");
    });
	$("#uheader").mouseout(function () {
		$(".gnb_more").hide();
		$("#uheader .sub_bg").removeClass("on");
    });
});

//메뉴 고정z
$(window).scroll(function () {
	if ($(this).scrollTop() > 10){
		$('#uheader .uheader_in .logo').css("display","none"); //스크롤했을때 나오게
		$("#uheader .sub_bg").css("top","69px");
		$("#uheader #uheader_wrap, #uheader .sub_bg").css("background","#fff");
		$(".subPageTop").css("padding-top","71px");
	}else{
		$('#uheader .uheader_in .logo').css("display","block"); //스크롤했을때 없앰
		$("#uheader .sub_bg").css("top","165px");
		$("#uheader #uheader_wrap, #uheader .sub_bg").css("background","rgba(255,255,255,0.8)");
		$(".subPageTop").css("padding-top","167px");
	}
});

</script>
<header id="uheader">
	<div id="uheader_wrap">
		<!-- uheader_in:s -->
		<div class="uheader_in">
			<div class="logo"><a href="${ pageContext.servletContext.contextPath }/main.do"><img src="resources/images/logo.png" alt="로고"></a></div>
			<div class="menuwrap">
				<div class="menu">
					<ul class="gnb clear">
						<li class="gnb_list">
							<a href="${ pageContext.servletContext.contextPath }/moveIntro.do">병원소개</a>
							<div class="gnb_more">
								<ul>
									<li><a href="${ pageContext.servletContext.contextPath }/moveIntro.do">미앤란소개</a></li>
									<li><a href="${ pageContext.servletContext.contextPath }/moveIntro.do#staff">의료진소개</a></li>
									<li><a href="${ pageContext.servletContext.contextPath }/moveIntro.do#footer">오시는길</a></li>
								</ul>
							</div>
						</li>
						<li class="gnb_list">
							<a href="${ pageContext.servletContext.contextPath }/serchPage.do">진료과목</a>
							<div class="gnb_more">
								<ul>
									<c:url var="mdlist" value="medicalPage.do">
		                              <c:param name="mdlist" value="${ md.md_num }"/>
		                           </c:url>
		                           <li><a href="${ pageContext.servletContext.contextPath }/medicalPage.do?mdlist=11111">색소레이저</a></li>
		                           <li><a href="${ pageContext.servletContext.contextPath }/medicalPage.do?mdlist=11112">기미레이저</a></li>
		                           <li><a href="${ pageContext.servletContext.contextPath }/medicalPage.do?mdlist=22211">바디보톡스</a></li>
		                           <li><a href="${ pageContext.servletContext.contextPath }/medicalPage.do?mdlist=22212">특수부위보톡스</a></li>
		                           <li><a href="${ pageContext.servletContext.contextPath }/medicalPage.do?mdlist=22213">필러</a></li>
		                           <li><a href="${ pageContext.servletContext.contextPath }/medicalPage.do?mdlist=22214">리프팅</a></li>
		                           <li><a href="${ pageContext.servletContext.contextPath }/medicalPage.do?mdlist=33311">여드름케어</a></li>
		                           <li><a href="${ pageContext.servletContext.contextPath }/medicalPage.do?mdlist=33312">모공케어</a></li>
		                           <li><a href="${ pageContext.servletContext.contextPath }/medicalPage.do?mdlist=33313">탄력 주름 케어</a></li>
								</ul>
							</div>
						</li>
						<li class="gnb_list">
							<a href="#">진료예약</a>
							<div class="gnb_more">
								<ul>
									<li><a href="moveRes.do">회원예약</a></li>
									<li><a href="moveNres.do">비회원예약</a></li>
									<c:if test="${ empty loginMember }"><!--로그인 안한 상태일 경우-->					
										<li><a href="moveCheckRes.do">예약확인</a></li>
									</c:if>			
									<c:if test="${ !empty loginMember }"><!--로그인 한 상태일 경우-->
										<li><a href="checkRes.do?member_id=${ loginMember.id }">예약확인</a></li>
									</c:if>									
								</ul>
							</div>
						</li>
						<li class="gnb_list">
							<a href="#">병원소식</a>
							<div class="gnb_more">
								<ul>
									<li><a href="nlist.do?page=1">미앤란소식</a></li>
									<li><a href="elist.do?page=1">이벤트</a></li>
								</ul>
							</div>
						</li>
						<li class="gnb_list">
							<a href="#">커뮤니티</a>
							<div class="gnb_more">
								<ul>
									<li><a href="rlist.do">진료후기</a></li>
									<li><a href="qlist.do?page=1">QNA</a></li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
				<div class="umember">
					<ul>						
						<c:if test="${ empty loginMember }"><!--로그인 안한 상태일 경우-->					
							<li><a href="${pageContext.servletContext.contextPath}/loginpage.do"><span class="ti-lock"></span>로그인</a></li>
						</c:if>					
						
						<c:if test="${ !empty loginMember }"><!--로그인 한 상태일 경우-->
							<li><a href="${pageContext.servletContext.contextPath}/logout.do"><span class="ti-lock"></span> 로그아웃</a></li>
						</c:if>	
											
						<c:if test="${ empty loginMember }"><!--로그인 안한 상태일 경우-->					
							<li><a href="<c:url value='enrollfp.do'/>"><span class="ti-user"></span> 회원가입</a></li>
						</c:if>
						<c:if test="${ !empty loginMember }"><!--로그인 한 상태일 경우-->	
							<li><a href="<c:url value='mypagefm.do'/>"><span class="ti-user"></span> 마이페이지</a></li>					
						</c:if>
						<c:if test="${ loginMember.status eq 2}"> <!-- 관리자일 경우 -->  
							<li class="adminlink"><a href="${ pageContext.servletContext.contextPath }/moveAdmain.do">관리자</a></li>
						</c:if>  
					</ul>
				</div>
			</div>
		</div>
		<!-- uheader_in:e -->
	</div> <!-- uheader_wrap:e -->
	<div class="sub_bg"></div>
</header>