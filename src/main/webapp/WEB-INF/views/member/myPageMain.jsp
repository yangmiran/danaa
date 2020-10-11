<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
  
  <c:set var="userid" value="${loginMember.id}"/>   
	<c:set var="okMember" value="${okMember}"/>
	<c:set var="curres" value="${curres}"/>
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
<div class="subPageTop">
		<div class="sub">
			<div class="s_top_gp_wrap">
				<img src="resources/images/mypage_01.png">
				<div class="title_wrap">
					<p>마이 페이지</p>
					<p>MNR CLINIC MYPAGE</p>
					<p>회원으로 가입하시면 더욱 다양한 컨텐츠 및 서비스를 받아보실 수 있습니다.</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span> Home
					</a></li>
					<li><a href="#" title="마이페이지">마이페이지</a></li>
					<li><a href="#" title="내 정보 보기">내 정보 보기</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->
	
		<div id="mypage_all_wrap">
			<div class="content_wrap content_mypage_home">
				<!-- -------------------------------------------------------------------------------------- -->
				<div class="box_information">
					<div class="box information">
						<div class="head">
							<h4>
								<strong>${loginMember.name}</strong>님  개인정보 내역입니다.
							</h4>
							
						</div>
						<table class="tbl_form_write">
							
							<colgroup>
								<col style="width: 110px">
								<col>
								<col style="width: 150px">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">아이디</th>
							<c:if test = "${fn:contains(userid, '@')}"><!--sns 간편 회원 가입 회원일 경우 -->
									<td colspan="2">sns간편회원가입</td>
							</c:if>
							<c:if test = "${!(fn:contains(userid, '@'))}"><!--일반 회원일 경우 -->
									<td colspan="2">${okMember.id}</td>
							</c:if>
								</tr>
								<tr>
									<th scope="row">휴대폰번호</th>
									<td colspan="2">${okMember.phone}</td>
								</tr>
								<tr>
									<th scope="row">생년월일</th>
									<td colspan="2">${okMember.birth}</td>
								</tr>
								<tr>
									<th scope="row">이메일</th>
									<td colspan="2">${okMember.email}</td>
								</tr>
				
								<tr class="tr_end">
									<th scope="row">이메일 수신여부</th>
				
							<td colspan="2">${(okMember.ag_email eq "Y")? "동의" : "미동의"}
							
							</td>
								
								</tr>
								
							</tbody>
						</table>
						
						<div class="btn_bottom">
							<a class="btn_common mid blu" href="${pageContext.servletContext.contextPath}/mchgpwdpage.do" style="opacity:1; cursor:pointer;" 
						onmouseover="this.style.opacity='0.7'" 
						onmouseout="this.style.opacity='1'">비밀번호 변경</a> 
							<a class="btn_common mid blu"href="${pageContext.servletContext.contextPath}/mchangeinfo.do" style="opacity:1; cursor:pointer;" 
						onmouseover="this.style.opacity='0.7'" 
						onmouseout="this.style.opacity='1'">회원정보 수정</a> 
						</div>
					</div>
					<!----------------------------------------------------------------------->
					<div class="box money">
						<div class="head">
							<h4 class="mypage_res">
								${loginMember.name}님의 최근 <strong> 예약 현황</strong>입니다.
							
							</h4>
							
							
						</div>
						<c:if test="${empty curres}">
						<hr>
						</c:if>
						<table class="tbl_form_write">
							
							<colgroup>
								<col style="width: 110px">
								<col>
								<col style="width: 150px">
							</colgroup>
							<tbody>
	
							<c:if test="${!empty curres}">
								<tr>
									<th scope="row">예약일</th>
									
									<td colspan="2">${curres.res_date}</td>
									
									
								</tr>
								<tr>
									<th scope="row">예약시간</th>
									<td colspan="2">${curres.res_time}</td>
								</tr>
								<tr>
									<th scope="row">담당의사</th>
									<td colspan="2">${(curres.res_doctor==1)? "이익준" :((curres.res_doctor==2)?"채송화":"안정원")}</td>
								</tr>
								<tr>
									<th scope="row">예약내용</th>
									<td colspan="2">${curres.res_content}</td>
								</tr>
				
								<tr class="tr_end">
									<th scope="row">예약상태</th>							
									<td colspan="2">${(curres.res_status==1)? "예약신청" : ((curres.res_status==2)? "예약확정" :((curres.res_status==3)? "진료완료" : "예약취소"))}</td>

								</tr>
							</c:if>
							<c:if test="${empty curres}">
							  <h2> 예약 내역이 없습니다</h2>
							</c:if>
								
							</tbody>
						</table>
						<c:if test="${empty curres}">
						<hr>
						</c:if>
						<div class="btn_bottom">
							<a class="btn_common mid blu" href="checkRes.do?member_id=${ loginMember.id }" style="opacity:1; cursor:pointer;" 
						onmouseover="this.style.opacity='0.7'" 
						onmouseout="this.style.opacity='1'">다른 예약 확인</a> 
							
						
						
						</div>
						
					</div>
					
				</div>
			<!-- -------------------------------------------------------------------------------------- -->
	

		</div>
		</div>

	<!-- footer -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />
	
</body>
</html>