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
	<script type="text/javascript">
		function moveModal(){
			$('#res_no2').val(${ reservation.res_no })
			document.getElementById('id01').style.display='block';
		}
	</script>
</head>
<body>
<div id="adwrap">
	<c:import url="/WEB-INF/views/common/adheader.jsp" />	
	<c:import url="/WEB-INF/views/reservation/resModal.jsp" />		
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
								<h2>예약 상세보기</h2>
							</div>
	
							<div class="mTable gMedium">
								<table border="1" summary="">
									<caption>예약 상세보기</caption>
									<tbody>
										<tr>
											<th scope="row">예약번호</th>
											<td>${ reservation.res_no }</td>
											<th scope="row">예약자</th>
											<td>${ reservation.res_name }</td>
										</tr>
										<tr>										
											<th scope="row">생년월일</th>
											<td>
												<fmt:parseDate var="parsedDate" value="${ reservation.res_birth }" pattern="yyyy-MM-dd HH:mm:ss.s" />
												<fmt:formatDate value="${ parsedDate }" pattern="yyyy-MM-dd" />
											</td>
											<th scope="row">성별</th>
											<td>${ reservation.res_gender }</td>
										</tr>
										<tr>
											<th scope="row">연락처</th><td>${ reservation.res_phone }</td>
											<th scope="row">이메일</th><td>${ reservation.res_email }</td>
										</tr>
										<tr>
											<th scope="row">예약일</th><td>${ reservation.res_date }</td>
											<th scope="row">예약시간</th><td>${ reservation.res_time }</td>
										</tr>
										<tr>
											<th scope="row">담당의</th><td>
												<c:if test="${ reservation.res_doctor eq 1 }">
												이익준
												</c:if><c:if test="${ reservation.res_doctor eq 2 }">
												채송화
												</c:if><c:if test="${ reservation.res_doctor eq 3 }">
												안정원
												</c:if></td>			
											<th scope="row">예약상태</th><td>
												<c:if test="${ reservation.res_status eq 1 }">
												예약 신청
												</c:if><c:if test="${ reservation.res_status eq 2 }">
												예약 확정
												</c:if><c:if test="${ reservation.res_status eq 3 }">
												진료 완료
												</c:if><c:if test="${ reservation.res_status eq 4 }">
												예약 취소
												</c:if></td>
										</tr>
										<tr>
											<th scope="row">예약내용</th><td>${ reservation.res_content }</td>
											<c:url var="askform" value="checkAskform.do">
												<c:param name="res_no" value="${ reservation.res_no }" />
											</c:url>
											<th scope="row">사전문진표</th><td><a href=${ askform }>확인하기</a></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div> <!-- inn:e -->
				</section> <!-- pagecontent:e -->
				
				<!-- 버튼 공통 -->
				<div class="input-btn4">
					<input type="button" value="확정" onclick="javascript:location.href='resConfirm.do?res_no=${ reservation.res_no }';"/>
					<input type="button" value="취소" onclick="javascript:location.href='resCancelAdmin.do?res_no=${ reservation.res_no }';"/>
					<input type="button" value="완료" onclick="javascript:location.href='resComplete.do?res_no=${ reservation.res_no }';"/>
					<input type="button" value="변경" onclick="moveModal()"/>
				</div>	
				<div class="blank"></div>
				<div class="input-btn0">      
	       			<input type="button" value="목록으로 돌아가기" onclick="javascript:location.href='adcheckRes.do'">
	     		</div>
			</form>  			
		</div> <!-- main-con:e -->

	</main>
</div>	
</body>
</html>