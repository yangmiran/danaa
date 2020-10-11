<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="listCount" value="${ requestScope.listCount }" />
<c:set var="startPage" value="${ requestScope.startPage }" />
<c:set var="endPage" value="${ requestScope.endPage }" />
<c:set var="maxPage" value="${ requestScope.maxPage }" />
<c:set var="currentPage" value="${ requestScope.currentPage }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
	<c:import url="/WEB-INF/views/common/meta.jsp" />
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<script>
		$(function() {	
			$( "#datepicker" ).datepicker({
				dateFormat: "yy-mm-dd",
				minDate: 0,
				regional: "ko",
				beforeShowDay: function(date){
					var day = date.getDay();
					return [(day != 0 && day != 6)];
				}
		   	});	
		});
	</script>
	<script type="text/javascript">
		//전체 선택 checkbox 클릭
		function allCk(objCheck){
			var checks = document.getElementsByName('res_no');
			for( var i = 0; i < checks.length; i++ ){
				checks[i].checked = objCheck;
			}
		}
		
		function validate(){
			//유효성 검사 코드
			var flag = true;
			$.ajax({
				url: "checkReserved.do",
				data: {res_doctor: $("#res_doctor option:selected").val(), res_date: $("#datepicker").val(), res_time: $("#res_time option:selected").val()},
				type: "post",
				async: false,
				success: function(result){
					if(result > 0){
						alert("이미 예약이 완료되었습니다.");
						flag=false;
					} else { 
						flag=true;
					}
				}				
			}); //ajax			
			return flag;
		}		
	</script>
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
					<li class="now" title="현재 위치">예약비활성화</li>
				</ol>
				<h2>예약 비활성화</h2>
			</div>
			<!-- 타이틀:e -->
			<form name="mall_config" id="mallConfig" method="post" action="insertDisable.do" onsubmit="return validate();">
				<!-- pagecontent:s -->
				<section class="pagecontent">
					<!-- inn:s -->
					<div class="inn">
						<div class="section">
							<div class="mTitle">
								<h2>예약 비활성화</h2>
							</div>
	
							<div class="mTable gMedium">
								<table border="1" summary="">
									<caption>예약 비활성화</caption>
									<tbody>
										<tr>
											<th scope="row">담당의</th>
											<td>
												<span class="mFormRequired">
												<select name="res_doctor" id="res_doctor" style="display: inline-block;" required>
													<option value="">선택</option>
														<c:forEach items="${ requestScope.dlist }" var="d">
															<option value="${ d.doc_no }">${ d.doc_name }</option>
														</c:forEach>
												</select>
												</span>
											</td>
											<th scope="row">날짜</th>
											<td>
												<span class="mFormRequired">
												<input type="text" name="res_date" id="datepicker" placeholder="선택" required>
												</span>
											</td>
											<th scope="row">시간</th>
											<td>
												<span class="mFormRequired">												
												<select name="res_time" id="res_time" required>
												<option value="">선택</option>
													<option value="10:00">10:00</option>
													<option value="10:30">10:30</option>
													<option value="11:00">11:00</option>
													<option value="11:30">11:30</option>
													<option value="12:00">12:00</option>
													<option value="12:30">12:30</option>
													<option value="14:00">14:00</option>
													<option value="14:30">14:30</option>
													<option value="15:00">15:00</option>
													<option value="15:30">15:30</option>
													<option value="16:00">16:00</option>
													<option value="16:30">16:30</option>
													<option value="17:00">17:00</option>
													<option value="17:30">17:30</option>
												</select></span>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div> <!-- inn:e -->
				</section> <!-- pagecontent:e -->
				
				<!-- 버튼 공통 -->
				<div class="input-btn">      
	       			<input type="submit" value="비활성화">
	     		</div>
			</form>
			
			<!-- 빈칸 -->
			<div class="blank"></div>
			
			<!-- 타이틀:e -->
			<form name="mall_config" id="mallConfig" method="post" action="deleteDisable.do">				
				<!-- pagecontent:s -->
				<section class="pagecontent">
					<!-- inn:s -->
					<div class="inn">
						<div class="mTitle">
								<h2>예약 비활성화 목록</h2>
							</div>
						<div class="listTable">						
							<table>
								<colgroup>
									<col style="width:5%">
									<col style="width:20%">
									<col style="width:25%">									
									<col style="width:25%">
									<col style="width:25%">
									<col style="*">
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" id="allck" name="allck" onclick="allCk(this.checked);"></th>
										<th>번호</th>
										<th>담당의</th>
										<th>날짜</th>
										<th>시간</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${ requestScope.list }" var="r">
										<tr>
											<td><input type="checkbox" name="res_no" value="${ r.res_no }"></td>
											<td>${ r.res_no }</td>			
											<td>
												<c:if test="${ r.res_doctor eq 1 }">
												이익준
												</c:if><c:if test="${ r.res_doctor eq 2 }">
												채송화
												</c:if><c:if test="${ r.res_doctor eq 3 }">
												안정원
												</c:if>
											</td>	
											<td>${ r.res_date }</td>			
											<td>${ r.res_time }</td>											
										</tr>
									</c:forEach>																	
								</tbody>
							</table>
						</div>
		   			</div> <!-- inn:e -->
		   		</section> <!-- pagecontent:e -->		

	    	<!-- 버튼 공통 -->
				<div class="input-btn">      
	       			<input type="submit" value="활성화">
	     		</div>		   		
    		</form>    			
		</div> <!-- main-con:e -->
		
		<!-- 빈칸 -->
		<div class="blank"></div>
		
		<!-- 페이징공통:s -->
    	<div class="adpage">
    		<c:if test="${ currentPage <= 1 }">
    			<a href="#" class="ti-angle-double-left"></a>
    		</c:if><c:if test="${ currentPage > 1 }">
    			<c:url var="ubl" value="disableRes.do">
					<c:param name="page" value="1" />
				</c:url>
    			<a href="${ ubl }" class="ti-angle-double-left"></a>
    		</c:if>
    		
    		<!-- 현재 페이지가 속한 페이지그룹의 숫자 출력 처리 -->
			<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
				<c:if test="${ p eq currentPage }">
					<a href="#" class="on">${ p }</a>
				</c:if><c:if test="${ p ne currentPage }">
					<c:url var="ubl2" value="disableRes.do">
						<c:param name="page" value="${ p }" />
					</c:url>
					<a href="${ ubl2 }">${ p }</a>
				</c:if>
			</c:forEach>			    		
    		
    		<c:if test="${ currentPage >= maxPage }">
				<a href="#" class="ti-angle-double-right"></a>
			</c:if><c:if test="${ currentPage < maxPage }">
				<c:url var="ubl3" value="disableRes.do">
					<c:param name="page" value="${ maxPage }"/>
				</c:url>
				<a href="${ ubl3 }" class="ti-angle-double-right"></a>
			</c:if>
    	</div>
    	<!-- 페이징공통:e -->   
	</main>
</div>
</body>
</html>