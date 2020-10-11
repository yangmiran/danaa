<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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
<style>
	h1, h2, h3, h4, h5, h6 {margin:0}
	body {font-size:16px}
</style>
<body>
<div class="w3-container">  
<div id="id01" class="w3-modal">
<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:800px">
<div class="w3-center">
  <br>
<span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
      
      </div>
<form action="adresChange.do" method="post" name="modal_form" class="modal_form" onsubmit="return validate();">		
		<input type="hidden" name="res_no2" id="res_no2" value="">
		<div class="box">
			<p>진료 담당의 </p>
			<div class="input">
				<select name="res_doctor" id="res_doctor" class="input1" style="display: inline-block;" required>
					<option value="">진료 담당의를 선택해주세요.</option>						
						<option value="1">이익준</option>
						<option value="2">채송화</option>
						<option value="3">안정원</option>
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
		<input type="button" id="resBtn" class="resboard_btn btn_white" value="취소" style="cursor:pointer;">
		</div>
	</form>
    </div>
  </div>
</div> 

<script>
	$("#resBtn").click(function(){
	 $(document.getElementById('id01')).attr("style", "display:none;");
	});
</script>      
</body>
</html>
