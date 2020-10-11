<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<c:import url="/WEB-INF/views/common/meta.jsp" />
</head>
<body>
<c:import url="/WEB-INF/views/common/header.jsp" />
	<!-- subPageTop:s 서브페이지 상단 제목 공통-->
	<div class="subPageTop">
		<div class="sub">
                 	<div class="s_top_gp_wrap">
                  	<img src="resources/images/sub_top_03.jpg">
                      <div class="title_wrap">
                         <p>코로나19 관련 사전 문진표</p>
                         <p>Ask about COVID 19</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a href="${ pageContext.servletContext.contextPath }/main.do" title="홈 바로가기"> <span class="ti-home"></span> Home</a></li>
				</ul>
			</nav>
                </div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->
	<div id="wrap">
	<form action="insertAskform.do" method="post" name="res_form" class="res_form">
		<input type="hidden" name="res_no" value="${ reservation.res_no } " >
		<input type="hidden" name="res_name" value="${ reservation.res_name } " >		
		<div class="box" id="covidNotice">
			※ 감염병의 예방 및 관리에 관한 법 제 35조에 의거하여 고의적으로 사실을 누락, 은폐할 경우 과태료가 부과될 수 있습니다.
		</div>
		
		<div class="box">
			<div class="covidQ">1. 발열 또는 호흡기 증상(기침, 가래, 인후통, 콧물), 후각이나 미각 소실 여부가 있습니까?</div>
			<div class="ask">				
				<input type="radio" name="ask1" id="ask" value="Y"> 예
				<input type="radio" name="ask1" id="ask" value="N"> 아니오
			</div>
		</div>
		
		<div class="box">
			<div class="covidQ">2. 최근 14일 이내 해외 방문 및 확진자의 접촉자로 자가격리 대상자입니까?</div>
			<div class="ask">				
				<input type="radio" name="ask2" id="ask" value="Y"> 예
				<input type="radio" name="ask2" id="ask" value="N"> 아니오
			</div>
		</div>
		
		<div class="box">
			<div class="covidQ">3. 최근 14일 이내 확진자 발생지역 또는 장소(의료기관 포함) 방문하신 적이 있습니까?</div>
			<div class="ask">				
				<input type="radio" name="ask3" id="ask" value="Y"> 예
				<input type="radio" name="ask3" id="ask" value="N"> 아니오
			</div>
		</div>
		
		<div class="box">
			<div class="covidQ">4. 최근 14일 이내 장기요양기관 또는 재활/정신병원 재원 중이거나 퇴원 환자 혹은 방문하신 적이 있습니까?</div>
			<div class="ask">				
				<input type="radio" name="ask4" id="ask" value="Y"> 예
				<input type="radio" name="ask4" id="ask" value="N"> 아니오
			</div>
		</div>		
		
		<div class="res_btn_box">
		<input type="submit" id="resSubmit" class="resboard_btn btn_common" value="등록하기" style="cursor:pointer;">
		<input type="button" onclick="javascript:history.go(-1)" id="resBtn" class="resboard_btn btn_white" value="뒤로가기" style="cursor:pointer;">
		</div>
	</form>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />		

</body>
</html>