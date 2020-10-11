<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<c:import url="/WEB-INF/views/common/meta.jsp" />
<script type="text/javascript"
	src="/danaa/resources/js/jquery-3.5.1.min.js">
	
</script>
<script type="text/javascript">

//ajax로 보호자 휴대폰 인증번호 요청 
//보호자 휴대폰 인증번호 요청	
var key = 0;//인증번호 확인을 위한 전역 변수

var x =0; //함수 초기화
function enrollSubmit2() {
	 // 휴대폰 번호 정규식
	 var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;  
 
	 if (phoneJ.test($('#phone').val())) {//휴대폰 유효성 검사 통과시
		console.log("휴대폰 유효성 검사 통과");
		
	 	$.ajax({
			url : "/danaa/test2.do",
			type : "post",
			data : {
				phone : $("#phone").val()
			},
			
			success : function(keycode) {

				$('.phonekey').val('');//인증번호 클릭후 리셋
				
				if (keycode == '') {
					alert("휴대폰 문자 전송에 실패 했습니다.");
					$("#phone").focus();
					$('#phone').focus(function() { //포커스가 phone으로 처음가면 멘트 리셋
						$('#phone_check').text('');	
					});
				}else if(keycode == 'dul'){//중복되는 핸드폰 번호가 있다면
					alert("이미 가입된 휴대폰 번호입니다");
					$("#phone").focus();
					$("#phone").val('');
					$('#phone').focus(function() { //포커스가 phone으로 처음가면 멘트 리셋
						$('#phone_check').text('');	
					});
				}else {
					alert("인증번호 전송이 완료되었습니다");
					//$("#id").select();
					//console.log(session.getAttribute("keycode"));
					clearInterval(x);
					//$('.demo').remove();
					$('#phone_check').text('');
					$("#phone_chk_com").show();
					$("#demo").show();
					key = keycode;
					console.log('key 값');
					console.log(keycode);
					
					phonesend = 1 ; //인증번호 전송이 완료됬다면
					
					
					//휴대폰 인증번호 타이머 만들기 :s
					var time = 180; //기준시간 작성  180
					var min = ""; //분
					var sec = ""; //초
					
					//setInterval(함수,시간) : 주기적인 실행
					x = setInterval(function(){
						//parseInt() : 정수를 반환
						//몫을 계산
						min = parseInt(time/60); 
						sec = time%60; //나머지를 계산
						
						document.getElementById("demo").innerHTML = min+"분"+sec+"초";
						
						time--;
						
						//타임아웃시
						if(time<0){
							phonesend=0;//타이머가 완료되면 0으로 리셋
							clearInterval(x);//setInterval()실행 끝
							document.getElementById("demo").innerHTML ="인증시간 초과";
							$('#phone').focus(function() { //포커스가 phone으로 가면 리셋
								document.getElementById("demo").innerHTML ="";
							});
							
							}
						}, 1000);//휴대폰 인증번호 :e
					}
				
			},
			error : function(jqXHP, textstatus, errorthrown) {
				console.log("error : " + jqXHR + ", " + textstatus + ", "
						+ errorthrown);
			}
		});

		return false;
	} else {//휴대폰 유효성 검사에 적합하지 않을 경우 
		$('#phone_check').text('휴대폰 번호 형식이 맞지 않습니다');
		$('#phone_check').css('color', 'red');
		$('#phone').focus(function() { //포커스가 phone으로 가면 리셋
			$('#phone_check').text('');	
		});
	}

}
 

//인증번호 확인:s
 function checkKey() {
		
		//인증번호 전송 완료, 인증번호 확인과 일치
		if($('#phonekey').val() != key && phonesend==1){
			console.log('인증번호 key');
			console.log(key);
			$('#phone_check').text('인증번호가 일치하지 않습니다');//인증번호와 불일치시
			$('#phone_check').css('color', 'red');
		
		//인증번호 전송 완료되지 않음 or 완료됬으나 인증번호 시간 만료됨	
		}else if(phonesend==0){
			$('#phone_check').text('인증번호 전송을 클릭해주세요');
			$('#phone_check').css('color', 'red');
		
		//인증번호 전송 완료but,인증번호 확인과 불일치
		}else{
			clearInterval(x);
			$("#phone_chk_com").hide();
			$("#demo").hide();
			$('#phone_check').text('인증 완료');//인증번호와 일치시
			$('#phone_check').css('color', 'blue');
		}
}//인증번호 확인:e	

//팝업창 닫기
	function close_popup() {
		window.close();
	}
	
	//변경하기 누르면 값을 부모창으로 보냄
	function setParentText(){
        if($('#phone_check').text()=='인증 완료' && $('#phone').val()!=''){//만일 인증 완료 됬다면
        	opener.document.getElementById("phone").value = document.getElementById("phone").value
            window.close();	
        }else{
        	alert('휴대폰 번호를 입력하고 인증을 해주세요');
        }
		
   }



</script>
	
</head>
<body>
	<div class="layer_pop_manage layer_identify open"
		id="layer_pop_bymobile">
		<div class="layer_manage_wrap">
			<h4>휴대폰 번호 수정</h4>
			<button type="button" class="btn_layer_close"
				onclick="close_popup();">
				<!-- <span>닫기</span> -->
			</button>
			<p class="txt" id="layer_title_bymobile" name="layer_title_bymobile">문자로
				전달받은 인증번호를 입력해주세요.</p>
			<input type="hidden" name="sms_confirm_complete" value="n"
				id="sms_confirm_complete">
			<table class="tbl_fieldset">
				<caption></caption>
				<colgroup>
					<col style="width: 130px;">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th>휴대폰 번호</th>
						<td>
							<div class="sri_select" style="width: 70px;">

								<input type="text" id="phone" name="phone" value="" placeholder="-없이 입력해주세요">
								
							</div> 
							<input type='button' onclick='return enrollSubmit2();' value='인증번호전송' style="opacity: 1; width:120px; background-color:#2070a1; color:#ffffff;cursor:pointer;" onmouseover="this.style.opacity='0.7'"
								onmouseout="this.style.opacity='1'">
							<div id="demo" class="demo" class="phone_pop"></div>	
							
						</td>
						
						

						
					</tr>
					<tr id="sms_code_table_bymobile" name="sms_code_table_bymobile">
						<th>인증번호</th>
						<td>
								<input type="text" name="phonekey" id="phonekey" class="phonekey" maxlength="13"> 			
								<input type='button'onclick='checkKey();' value='인증번호확인' style="opacity: 1; width:120px; background-color:#2070a1; color:#ffffff;cursor:pointer;" onmouseover="this.style.opacity='0.7'"
								onmouseout="this.style.opacity='1'"> 															
								<div id="phone_chk_com" class="phone_chk_com"> </div>
								
								</td>
					</tr>
					<tr>
					<th class="phonend_check"></th>
					<td><div class="check_font" id="phone_check"></div></td>
					</tr>
	
				</tbody>
			</table>
			<div class="bottom_btn_wrap">
				<button type="button" class="btn_basic_type05"
					onclick="setParentText();" style="opacity: 1; cursor:pointer;" onmouseover="this.style.opacity='0.7'"
						onmouseout="this.style.opacity='1'">변경</button>
				<button type="button" class="btn_basic_type05"
					onclick="close_popup();"style="opacity: 1; cursor:pointer;" onmouseover="this.style.opacity='0.7'"
						onmouseout="this.style.opacity='1'">취소</button>
				
			</div>
		</div>
	</div>
</body>
</html>