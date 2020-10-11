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
$(function(){
	$("#checking").click(function(){
		$("input[name='checked_checking']").val('y');
		
		$.ajax({
			url: "checkReserved.do",
			data: {res_doctor: $("#res_doctor option:selected").val(), res_date: $("#datepicker").val(), res_time: $("#res_time option:selected").val()},
			type: "post",
			success: function(result){
				if(result > 0){
					alert("이미 예약된 시간입니다.\n다른 시간을 선택해 주세요.");
				} else { 
					alert("예약 가능한 시간입니다.");
				}
			},
			error: function(request, status, errorData){
				console.log("error code : " + request.status
						+ "\nMessage : " + request.responseText
						+ "\nError : " + errorData);
			}
		}); //ajax		
		return false;  //클릭이벤트 제거
	}); //checking click
});  //ready


function validate(){
	//유효성 검사 코드
	if($("input[name='checked_checking']").val()==''){
		   alert('예약 가능 여부를 확인해주세요.');
		   $("input[name='checked_checking']").eq(0).focus();
		   return false;
 	}
	return true;
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
                           <p>회원진료예약</p>
                           <p>MNR clinic Reservation</p>
						</div>
					</div>
					<nav class="sub_navi">
						<ul>
							<li><a href="${ pageContext.servletContext.contextPath }/main.do" title="홈 바로가기"> <span class="ti-home"></span> Home</a></li>
							<li><a href="#" title="진료예약">진료예약</a></li>
							<li><a href="moveRes.do" title="회원예약">회원예약</a></li>
						</ul>
					</nav>
                  </div>
			</div>
			<!-- subPageTop:e 서브페이지 상단 제목 공통-->
	<div id="wrap">
	<form action="insertRes.do" method="post" name="res_form" class="res_form" onsubmit="return validate();">
		<input type="hidden" name="member_id" value="${ loginMember.id }" >
		
		<div class="box">
			<p>진료 담당의 </p>
			<div class="input">
				<select name="res_doctor" id="res_doctor" class="input1" style="display: inline-block;" required>
					<option value="">진료 담당의를 선택해주세요</option>
						<c:forEach items="${ requestScope.list }" var="d">
							<option value="${ d.doc_no }">${ d.doc_name }</option>
						</c:forEach>
				</select>
			</div>
		</div>
		<div class="box">
			<p>예약일 선택 </p>
			<div class="input">
				<input type="text" name="res_date" id="datepicker" class="input1" placeholder="예약일을 선택해주세요" required>
			</div>
		</div>

		<div class="box">
			<p>예약 시간 </p>
			<div class="input">
				<select name="res_time" id="res_time" class="input1" required>
					<option value="">예약시간을 선택해주세요</option>
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
		<input type="button" name="checking" id="checking" class="resboard_btn btn_common" value="예약가능여부확인" style="cursor:pointer;">
		<input type="hidden" name="checked_checking" value="">
		</div>
		
		<div class="box">
			<p>이름 </p>
			<div class="input">
				<input type="text" name="res_name" id="res_name" class="input1" maxlength="10" placeholder="이름" value="${ loginMember.name }" required>
			</div>
		</div>
		
		<div class="box">
			<p>생년월일</p>
			<div class="input">
				<input type="text" name="res_birth" id="res_birth" class="input1" maxlength="6" value="${ loginMember.birth }" required>
			</div>
		</div>
		
		<div class="box">
			<p>성별 </p>
			<div class="input">
				<input type="radio" name="res_gender" id="res_gender" value="M" checked> 남 &nbsp;
				<input type="radio" name="res_gender" id="res_gender" value="F">  여
			</div>
		</div>

		<div class="box">
			<p>연락처 </p>
			<div class="input">
				<input type="text" name="res_phone" id="res_phone" class="input1" maxlength="15" value="${ loginMember.phone }" onkeydown="onlyNumber(this)" required>
			</div>
		</div>
		
		<div class="box">
			<p>이메일 </p>
			<div class="input">
				<input type="text" name="res_email" id="res_email" class="input1" value="${ loginMember.email }" required>
			</div>
		</div>
		
		<div class="box contents">
			<p>내용 </p>				
				<textarea placeholder="내용을 입력 하세요." name="res_content" id="res_content" style="display: inline-block; width:80%;" required></textarea>				
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