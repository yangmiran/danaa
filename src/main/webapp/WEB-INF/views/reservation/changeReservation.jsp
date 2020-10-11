<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	//의사에 따라 달력 다르게 출력
	$("#res_doctor").change(function(){
		if($("#res_doctor option:selected").val() == 1) {
			$( "#datepicker" ).datepicker({
				dateFormat: "yy-mm-dd",
				minDate: 0,
				regional: "ko",
				beforeShowDay: function(date){
					var day = date.getDay();
					return [(day != 0 && day!= 3 && day != 6)];
				}
	    	});
		} else if($("#res_doctor option:selected").val() == 2) {
			$( "#datepicker" ).datepicker({
				dateFormat: "yy-mm-dd",
				minDate: 0,
	    		regional: "ko",
				beforeShowDay: function(date){
					var day = date.getDay();
					return [(day != 0 && day!= 4 && day != 6)];
				}
			});
		} else if($("#res_doctor option:selected").val() == 3) {
			$( "#datepicker" ).datepicker({
	    		dateFormat: "yy-mm-dd",
	    		minDate: 0,
	    		regional: "ko",
				beforeShowDay: function(date){
					var day = date.getDay();
					return [(day != 0 && day!= 2 && day != 6)];
				}
			});
		}
	}); //달력 출력 끝
	
	//의사 선택 안했을 시 alert 창
	$("#datepicker").click(function(){
		if($("#res_doctor option:selected").val() == ""){
			alert("진료 담당의를 먼저 선택하세요.");
		}
	}); // alert창 끝
	
});
</script>

<script  type="text/javascript">
function validate(){		
	var flag = true;
	$.ajax({
		url: "checkReserved.do",
		data: {res_doctor: $("#res_doctor option:selected").val(), res_date: $("#datepicker").val(), res_time: $("#res_time option:selected").val()},
		type: "post",
		async: false,
		success: function(result){
			if(result > 0){
				alert("이미 예약된 시간입니다.\n다른 시간을 선택해 주세요.");
				flag = false;
			} else { 
				flag = true;
			}
		},
		error: function(request, status, errorData){
			console.log("error code : " + request.status
					+ "\nMessage : " + request.responseText
					+ "\nError : " + errorData);
		}
	}); //ajax		
	return flag;
}

</script>
</head>
<body>	
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<!-- subPageTop:s 서브페이지 상단 제목 공통-->
			<div class="subPageTop">
				<div class="sub">
                   	<div class="s_top_gp_wrap">
                    	<img src="resources/images/sub_top_03.jpg">
                        <div class="title_wrap">
                           <p>예약변경</p>
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
	<div id="wrap">
	<form action="resChange.do" method="post" name="res_form" class="res_form" onsubmit="return validate();">		
		<input type="hidden" name="res_no" value="${ reservation.res_no }">
		<input type="hidden" name="member_id" value="${ reservation.member_id }">
		<div class="box">
			<p>진료 담당의 </p>
			<div class="input">
				<select name="res_doctor" id="res_doctor" class="input1" style="display: inline-block;" required>
					<option value="">진료 담당의를 선택해주세요.</option>
						<c:forEach items="${ requestScope.list }" var="d">
							<option value="${ d.doc_no }">${ d.doc_name }</option>
						</c:forEach>
				</select>
			</div>
		</div>
		<div class="box">
			<p>예약일 선택 </p>
			<div class="input">
				<input type="text" name="res_date" id="datepicker" class="input1" placeholder="예약일을 선택해주세요." required>
			</div>
		</div>

		<div class="box">
			<p>예약 시간 </p>
			<div class="input">
				<select name="res_time" id="res_time" class="input1" required>
					<option value="">예약시간을 선택해주세요.</option>
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
				</select>
			</div>
		</div>		
		<div class="res_btn_box">
		<input type="submit" id="resSubmit" class="resboard_btn btn_common" value="변경하기" style="cursor:pointer;">
		<input type="button" onclick="javascript:history.go(-1)" id="resBtn" class="resboard_btn btn_white" value="취소" style="cursor:pointer;">
		</div>
	</form>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />		
</body>
</html>