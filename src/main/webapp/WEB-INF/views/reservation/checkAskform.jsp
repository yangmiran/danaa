<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
	<c:import url="/WEB-INF/views/common/meta.jsp" />
</head>
<body>
<div id="adwrap">
	<c:import url="/WEB-INF/views/common/adheader.jsp" />		
	<main>
		<!-- main-con:s -->
		<div class="main-con">
			<!-- 타이틀:s -->
			<div class="adtit">
				<ol>
					<li class="home">홈</li>
					<li>예약관리</li>
					<li class="now" title="현재 위치">예약확인</li>
				</ol>
				<h2>예약확인</h2>
			</div>
			<!-- 타이틀:e -->
			<form name="mall_config" id="mallConfig" method="post" action="insertDisable.do" onsubmit="return validate();">
				<!-- pagecontent:s -->
				<section class="pagecontent">
					<!-- inn:s -->
					<div class="inn">
						<div class="section">
							<div class="mTitle">
								<h2>코로나19 사전문진표</h2>
							</div>
	
							<div class="mTable gMedium">
								<table border="1" summary="">
									<caption>코로나19 사전문진표</caption>
									<tbody>
										<tr>
											<th scope="row">예약번호</th><td>${ askform.res_no }</td>
											<th scope="row">예약자</th><td>${ askform.res_name }</td>
										</tr>
										<tr>
										<th scope="row" colspan="3">1. 발열 또는 호흡기 증상(기침, 가래, 인후통, 콧물), 후각이나 미각 소실 여부가 있습니까?</th>
										<td>
											<c:if test="${ askform.ask1 eq 'Y' }">
											예
											</c:if><c:if test="${ askform.ask1 eq 'N' }">
											아니오
											</c:if>
										</td>
									</tr>
									<tr>
										<th scope="row" colspan="3">2. 최근 14일 이내 해외 방문 및 확진자의 접촉자로 자가격리 대상자입니까?</th>
										<td>
											<c:if test="${ askform.ask1 eq 'Y' }">
											예
											</c:if><c:if test="${ askform.ask1 eq 'N' }">
											아니오
											</c:if>
										</td>
									</tr>
									<tr>
										<th scope="row" colspan="3">3. 최근 14일 이내 확진자 발생지역 또는 장소(의료기관 포함)에 방문하신 적이 있습니까?</th>
										<td>
											<c:if test="${ askform.ask1 eq 'Y' }">
											예
											</c:if><c:if test="${ askform.ask1 eq 'N' }">
											아니오
											</c:if>
										</td>
									</tr>
									<tr>
										<th scope="row" colspan="3">4. 최근 14일 이내 장기요양기관 또는 재활/정신병원 재원 중이거나 퇴원 환자 혹은 방문하신 적이 있습니까?</th>
										<td>
											<c:if test="${ askform.ask1 eq 'Y' }">
											예
											</c:if><c:if test="${ askform.ask1 eq 'N' }">
											아니오
											</c:if>
										</td>
									</tr>		
									</tbody>
								</table>
							</div>
						</div>
					</div> <!-- inn:e -->
				</section> <!-- pagecontent:e -->
				
				<div class="input-btn0">      
					<input type="button" value="뒤로가기" onclick="javascript:history.go(-1);">
	     		</div>
			</form>  			
		</div> <!-- main-con:e -->
	</main>
</div>	
</body>
</html>