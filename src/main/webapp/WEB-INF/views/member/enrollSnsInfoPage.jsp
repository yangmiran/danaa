<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"  %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<!-- 회원가입STEP03 회원정보 입력 페이지  (SNS 회원가입)-->

<!--맨 밑 footer만 보이게 설정--> 
<style type="text/css">

#footer .footer_in .cont {
display: none;
}

</style>
<!-- 유효성 검사 따로 관리 -->
<c:import url="/WEB-INF/views/member/validation.jsp"/> 

<script type="text/javascript"
	src="/danaa/resources/js/jquery-3.5.1.min.js">
	
</script>
<script type="text/javascript">

//form태그에서 가입하기/본인인증 버튼에 따라 action 값 다르게 설정
	
	//1.아이디 중복확인 체크 여부 확인을 위한 전역 변수 설정
	var idchk = 0;
	//2.이메일 중복확인 체크 여부 확인을 위한 전역변수
	var emailchk = 0;
	//3. 휴대폰 인증번호 발송 여부 확인을 위한 전역변수
	var phonesend = 0;
	
	function enrollSubmit1() { //가입하기
		//14세 미만 체크
		if(birthdatechk == 'N'&& (yearNow-$('#birth').val().substr(0, 4))>=14){ //14세 이상+체크 제대로함
				console.log('맞음');	
				console.log(birthdatechk);
				console.log((yearNow-$('#birth').val().substr(0, 4)));
				//휴대폰 인증여부 체크
				if($('#phone_check').text()!='인증 완료'|| ($('#phonekey').val() != key && phonesend==1)){
					$("#demo").empty();
					$('#phone_check').text('본인 인증을 해주세요');
					$('#phone_check').css('color', 'red');
					$('#phone').focus(function() { //포커스가 phone으로 가면 리셋
						$('#phone_check').text('');	
					});
					//alert('입력 정보를 확인해주세요');
					//return false;
				}
			
			}else if(birthdatechk == 'Y'&& (yearNow-$('#birth').val().substr(0, 4))<14){//14세 미만+체크 제대로함
				console.log('맞음');	
				console.log(birthdatechk);
				console.log((yearNow-$('#birth').val().substr(0, 4)));
		
			}else{
				console.log(birthdatechk);	
				//$('#under14_check').text('입력하신 생년월일과 맞지 않습니다');
				//$('#under14_check').css('color', 'red');
				alert('14세 미만은 보호자 동의가 필요합니다');
			//	return false;
			}	
	}

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
		

	//ajax으로 이메일 중복 여부 확인
	//이메일 중복 체크 확인
	function dupEmailCheck() {
		if (emailJ.test($('#email').val())) {//이메일 유효성 검사 통과시
			$.ajax({
				url : "/danaa/emailCheck.do",
				type : "post",
				data : {
					email : $("#email").val()
				},
				success : function(result) {
					if (result != 1) {
						alert("사용 가능한 이메일입니다.");
						//중복 체크를 완료 했다면
						emailchk=1;
						$("#phone").focus();
					} else {
						alert("이미 가입된 이메일입니다.\n다시 확인해 주세요.");
						$("#email").val('');
						/* $("#email").select(); */
					}
				},
				error : function(jqXHP, textstatus, errorthrown) {
					console.log("error : " + jqXHR + ", " + textstatus + ", "
							+ errorthrown);
				}
			});

			return false;
		} else {//이메일 유효성 불일치시
			$('#email_check').text('이메일 형식이 맞지 않습니다');
			$('#email_check').css('color', 'red');
			$('#email').focus(function() { //포커스가 email로 가면 멘트 리셋
				$('#email_check').text('');	
			});
		}

	}
	//이메일 수신여부 checked 상태로 //성별 checked 상태로
	$(function() {
		$("#Y").attr("checked", "checked");
		
		$("#female").attr("checked", "checked");
	});
</script>
<c:import url="/WEB-INF/views/common/meta.jsp" />

<!-- header -->
<c:import url="/WEB-INF/views/common/header.jsp" />
</head>
<body>
<!-- subPageTop:s 서브페이지 상단 제목 공통-->
	<div class="subPageTop">
		<div class="sub">
			<div class="s_top_gp_wrap">
				<img src="resources/images/sub_top_join_01.jpg">
				<div class="title_wrap">
					<p>회원가입</p>
					<p>MNR CLINIC JOIN</p>
					<p>회원으로 가입하시면 더욱 다양한 컨텐츠 및 서비스를 받아보실 수 있습니다.</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span> Home
					</a></li>
					<li><a href="#" title="회원가입">회원가입</a></li>
					<li><a href="#" title="가입정보 입력">가입정보 입력</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->

<div id="wrap">
		<div class="enroll_bar">			
				<div class="sub-title">
		<h3>가입 정보를 입력해 주세요</h3><br>
	    <p>*표시는 필수 입력 항목입니다</p> 
	
	</div>
		</div>
	
	</div><!-- wrap :e -->


	<!--enroll_info:s-->
	<div class="enroll_info">
		<div class="tableWrap">

			<form:form method="post" id="allsendForm" name="allsendForm"
				action="msnsenroll.do" onsubmit='return enrollSubmit1()' modelAttribute="member">			
			<form:hidden path="child" value="${child}"/> 	
			<form:hidden path="id" value="${id}"/>
		
				<table>
					<colgroup>
						<col width="150">
						<col width="*">
					</colgroup>
					<tbody>
						<%-- <tr>
							<th><label for="under14">14세 미만여부</label></th>
							<td>
							<form:checkbox path="child" value="Y" item="${child}"/>

								<form:checkbox path="child" checked/>
							</td>
						</tr>  --%>
						<tr>
							<th><label for="id">아이디</label><span class="requiredTxt"> *</span></th>
							<td>
								sns 간편 회원가입
							</td>
						</tr>
						<tr>
							<th><label for="password">패스워드</label><span class="requiredTxt"> *</span></th>
							<td>
								<form:input path="pwd" id="pwd" name="pwd" class="inputPass"
								type="password" maxlength="20"/>
								<span class="password_ch"> 								
								<label for="password2">패스워드 확인</label></span> 
								<input name="pwd2" id="pwdck" class="inputPass" type="password">							
								<div class="check_font" id="pwd_check"></div> 
								 <div class="spring_error">
								 <font color="red">
								<spring:hasBindErrors name="member"> 
           							<c:if test="${errors.hasFieldErrors('pwd') }">                                    
               		 					<form:errors path="pwd" id="pwd_check2"/>               	
               						 </c:if> 
								</spring:hasBindErrors> 
								</font>
								</div>
								<span class="id_txt">영문자,숫자,특수문자 조합. 최소 6자이상 입력하세요.</span>	
							</td>
						</tr>
						<tr>
							<th><label for="name">이름</label><span class="requiredTxt"> *</span></th>
							<td>
								<form:input path="name" id="name" name="name" class="inputName"
								type="text" maxlength="20"/>
								<div class="check_font" id="name_check"></div>
								 <div class="spring_error">
								 <font color="red">
								<spring:hasBindErrors name="member"> 
           							<c:if test="${errors.hasFieldErrors('name') }">                                    
               		 					<form:errors path="name" id="name_check2"/>               	
               						 </c:if> 
								</spring:hasBindErrors> 
								</font>
								</div>
							</td>
						</tr>
						<tr>
							 <th><label for="birth">생년월일</label><span class="requiredTxt"> *</span></th>
							<td>  
								<form:input path="birth" id="birth" name="birth" class="inputBirth"
								type="text" maxlength="20"/> 	
								<div class="check_font" id="birth_check"></div>
								 <div class="spring_error">
								 <font color="red">
								<spring:hasBindErrors name="member"> 
           							<c:if test="${errors.hasFieldErrors('birth') }">                                    
               		 					<form:errors path="birth" id="birth_check2"/>               	
               						 </c:if> 
								</spring:hasBindErrors> 
								</font>
								</div>
							</td> 
								
						</tr>
						<tr>
							<th>성별<span class="requiredTxt"> *</span></th>
							 <td class="gender">
								
								<fieldset>
									<legend class="blind">성별</legend>								
									<form:radiobutton path="gender" id="female" value="F" name="gender"  /><label
										for="female">여성</label> 
									<form:radiobutton path="gender" id="male" value="M" name="gender"  /><label
										for="male">남성</label>
									 <font color="red">
									<spring:hasBindErrors name="member"> 
           							<c:if test="${errors.hasFieldErrors('gender') }">                                    
               		 					<form:errors path="gender" id="gender_check2"/>               	
               						 </c:if> 
								</spring:hasBindErrors> 
								</font>	
								</fieldset> 
							</td> 
						</tr>
						<tr>
							<th><label for="email">이메일</label><span class="requiredTxt"> *</span></th>
							<td class="mail_type">								
								<form:input path="email" id="email" name="email" class="inputEmail"
								type="text" maxlength="30"/>
								<input type="button"
								id="email_dupCheck" onclick='dupEmailCheck();' value="중복확인"
								style="opacity: 1" onmouseover="this.style.opacity='0.7'"
								onmouseout="this.style.opacity='1'"> 
								<div class="check_font" id="email_check"></div>
								 <div class="spring_error">
								 <font color="red">
								<spring:hasBindErrors name="member"> 
           							<c:if test="${errors.hasFieldErrors('email') }">                                    
               		 					<form:errors path="email" id="email_check2"/>               	
               						 </c:if> 
								</spring:hasBindErrors> 
								</font>
								</div>
							</td>
						</tr>

						<tr>
							<th>휴대폰</th>
							<td>
							<form:input path="phone" id="phone" name="phone" class="inputPhone" type="text" maxlength="20"/>
							
									<input type='button' onclick='return enrollSubmit2();'
										value='인증번호 전송' style="opacity: 1; cursor:pointer;" onmouseover="this.style.opacity='0.7'" onmouseout="this.style.opacity='1'">
								 
									<div id="phone_chk_com" class="phone_chk_com">
									<input type="text" name="phonekey" id="phonekey" maxlength="13">
									<input type='button' onclick='checkKey();' value='인증번호 확인' style="opacity: 1; cursor:pointer;" onmouseover="this.style.opacity='0.7'" onmouseout="this.style.opacity='1'">
									</div>
									<div id="demo" class="demo"></div>							 
								<div class="check_font" id="phone_check"></div>
								<span class="id_txt">-없이 숫자만 입력하세요.</span>
								 
							</td>
						</tr>

						<tr>
							<th>이메일 수신여부<span class="requiredTxt"> *</span></th>
							<td class="ag_email">

								<fieldset>
									<legend class="blind">이메일 수신여부</legend>
									<form:radiobutton path="ag_email" id="Y" value="Y" name="ag_email" /><label for="Y">예</label>
									<form:radiobutton path="ag_email" id="N" value="N" name="ag_email" /><label for="N">아니오</label>
									 <font color="red">
									<spring:hasBindErrors name="member"> 
           							<c:if test="${errors.hasFieldErrors('ag_email') }">                                    
               		 					<form:errors path="ag_email" id="ag_email_check2"/>               	
               						 </c:if> 
								</spring:hasBindErrors> 
								</font>
								</fieldset>

							</td>
						</tr>
						
					</tbody>
				</table>
				<hr>
					<!-- <input type='submit' value='가입하기' style="opacity: 1"
						onmouseover="this.style.opacity='0.7'"
						onmouseout="this.style.opacity='1'"> -->
					<input type='submit' value='가입하기' style="opacity: 1; cursor:pointer;" onmouseover="this.style.opacity='0.7'"
						onmouseout="this.style.opacity='1'" class="enroll_button btn_common_n2" onclick='return enrollSubmit1()'>

				

			</form:form>
			<!--allsendForm :e  -->
		</div>
	</div>
	<!--enroll_info:e-->




	<!-- footer -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>