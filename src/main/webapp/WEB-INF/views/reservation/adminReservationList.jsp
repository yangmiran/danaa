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
	<script type="text/javascript">
		//전체 선택 checkbox 클릭
		function allCk(objCheck){
			var checks = document.getElementsByName('res_no');
			for( var i = 0; i < checks.length; i++ ){
				checks[i].checked = objCheck;
			}
		}
		
		function moveModal(){
			$('#res_no2').val($("input:checkbox[name='res_no']:checked").val())
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
			
			<div class="input-btn0">      
	       			<input type="button" value="달력으로 보기" onclick="location.href='moveCalendar.do';">
	     	</div>	
			
			<!-- 타이틀:e -->
			<form name="mall_config" id="mallConfig" method="get" action="">
				<!-- pagecontent:s -->
				<section class="pagecontent">
					<!-- inn:s -->
					<div class="inn">
						<div class="section">
							<div class="mTitle">
								<h2>분류별 조회</h2>
							</div>							
							<div class="mTable gMedium">
								<table border="1" summary="">
									<caption>분류별 조회</caption>
									<tbody>
										<tr>
											<th scope="row">담당의별</th>
											<td>
												<span class="mFormRequired">
												<select name="res_doctor" id="res_doctor"  class="inputs" style="display: inline-block;">
													<option value="">선택</option>
														<c:forEach items="${ requestScope.dlist }" var="d">
															<option value="${ d.doc_no }">${ d.doc_name }</option>
														</c:forEach>
												</select>
												<input type="submit" value="조회" class="small_btn" style="cursor:pointer;" onclick="javascript:this.form.action='resByDoc.do';"/>
												</span>
											</td>
											<th scope="row">예약상태별</th>
											<td>
												<span class="mFormRequired">
												<select name="res_status" id="res_status" class="inputs" style="display: inline-block;">
													<option value="">선택</option>
														<option value="1">예약 신청</option>
														<option value="2">예약 확정</option>
														<option value="3">진료 완료</option>
														<option value="4">예약 취소</option>
												</select>
												<input type="submit" value="조회" class="small_btn" style="cursor:pointer;" onclick="javascript:this.form.action='resByStatus.do';"/>
												</span>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div> <!-- inn:e -->
				</section> <!-- pagecontent:e -->
			</form>
			
			<!-- 타이틀:e -->
			<form name="mall_config" id="mallConfig" method="get" action="">				
				<!-- pagecontent:s -->
				<section class="pagecontent">
					<!-- inn:s -->
					<div class="inn">
						<div class="mTitle">
								<h2>예약 목록</h2>
							</div>
						<div class="listTable">						
							<table>
								<colgroup>
									<col width="5%" />
									<col width="15%" />
									<col width="15%" />
									<col width="20%" />
									<col width="15%" />
									<col width="15%" />
									<col width="15%" />
									<col width="*" />
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" id="allck" name="allck" onclick="allCk(this.checked);"></th>
										<th>예약번호</th><th>예약자</th><th>예약일</th><th>예약시간</th><th>담당의</th><th>예약 상태</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${ requestScope.list }" var="r">							
										<tr>
											<td><input type="checkbox" name="res_no" value="${ r.res_no }"></td>
											<c:url var="detail" value="addetailRes.do">
												<c:param name="rno" value="${ r.res_no }" />
											</c:url>
											<td><a href="${ detail }">${ r.res_no }</a></td>			
											<td>${ r.res_name }</td>	
											<td>${ r.res_date }</td>			
											<td>${ r.res_time }</td>
											<td>
												<c:if test="${ r.res_doctor eq 1 }">
												이익준
												</c:if><c:if test="${ r.res_doctor eq 2 }">
												채송화
												</c:if><c:if test="${ r.res_doctor eq 3 }">
												안정원
												</c:if>
											</td>
											<td>
												<c:if test="${ r.res_status eq 1 }">
												예약 신청
												</c:if><c:if test="${ r.res_status eq 2 }">
												예약 확정
												</c:if><c:if test="${ r.res_status eq 3 }">
												진료 완료
												</c:if><c:if test="${ r.res_status eq 4 }">
												예약 취소
												</c:if>
											</td>									
										</tr>
									</c:forEach>																	
								</tbody>
							</table>
						</div>
		   			</div> <!-- inn:e -->
		   		</section> <!-- pagecontent:e -->			
    	
	    	<!-- 버튼 공통 -->
				<div class="input-btn4">      
	       			<input type="submit" value="예약 확정" onclick="javascript:this.form.action='resConfirm.do';">
	       			<input type="submit" value="예약 취소" onclick="javascript:this.form.action='resCancelAdmin.do';"/>
					<input type="submit" value="진료 완료" onclick="javascript:this.form.action='resComplete.do';"/>
					<input type="button" value="예약 변경" onclick="moveModal()"/>
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
    			<c:url var="ubl" value="adcheckRes.do">
					<c:param name="page" value="1" />
				</c:url>
    			<a href="${ ubl }" class="ti-angle-double-left"></a>
    		</c:if>
    		
    		<!-- 현재 페이지가 속한 페이지그룹의 숫자 출력 처리 -->
			<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
				<c:if test="${ p eq currentPage }">
					<a href="#" class="on">${ p }</a>
				</c:if><c:if test="${ p ne currentPage }">
					<c:url var="ubl2" value="adcheckRes.do">
						<c:param name="page" value="${ p }" />
					</c:url>
					<a href="${ ubl2 }">${ p }</a>
				</c:if>
			</c:forEach>			    		
    		
    		<c:if test="${ currentPage >= maxPage }">
				<a href="#" class="ti-angle-double-right"></a>
			</c:if><c:if test="${ currentPage < maxPage }">
				<c:url var="ubl3" value="adcheckRes.do">
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