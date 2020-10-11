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
		function validate(){
			var flag = true;
			$.ajax({
				url: "checkCancel.do",
				data: {res_no: $('[name=res_no]:checked').val()},
				type: "post",
				async: false,
				success: function(result){
					if(result > 0){
						flag=true;
					} else { 
						alert("예약 신청 상태에서만 취소 및 변경이 가능합니다.");
						flag=false;
					}
				},				
			}); //ajax	
			return flag;
		};
	</script>
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
						<p>나의 예약 리스트</p>
						<p>MNR clinic Reservation</p>
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
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->
	<div class="writecon">
	<form method="post" action="" onsubmit="return validate();">
	<div class="box" id="cancelNotice">
			※예약 상태가 '예약 신청' 일 때만 예약 취소 및 변경이 가능합니다.
	</div>
	<table class="dt" id="diary" align="center">
	<colgroup>
			<col width="5%" />
			<col width="10%" />
			<col width="25%" />
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
			<col width="*" />
	</colgroup>
    <thead>
    <tr>
		<th> </th><th>예약번호</th><th>예약일</th><th>예약시간</th><th>담당의</th><th>예약 상태</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${ requestScope.list }" var="r">
		<tr>
			<td><input type="radio" name="res_no" id="res_no" value="${ r.res_no }"></td>
			<td>${ r.res_no }</td>	
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
	<div class="res_btn_box">
		<input type="submit" class="resboard_btn btn_common" value="예약 취소" style="cursor:pointer;" onclick="javascritp:this.form.action='resCancelLogin.do';">
		<input type="submit" class="resboard_btn btn_white" value="예약 변경" style="cursor:pointer;" onclick="javascritp:this.form.action='moveChange.do';">
	</div>
	</form>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />		
</body>
</html>