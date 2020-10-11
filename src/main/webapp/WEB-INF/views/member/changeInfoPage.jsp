<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="okMember" value="${okMember}"/> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<!-- 마이페이지  내 정보 보기 페이지임 -->
<c:import url="/WEB-INF/views/common/meta.jsp" />
<!--맨 밑 footer만 보이게 설정-->
<style type="text/css">
#footer .footer_in .cont {
	display: none;
}
</style>


<script type="text/javascript"
	src="/danaa/resources/js/jquery-3.5.1.min.js">
	
</script>
<script type="text/javascript">


$(function(){
	//생년월일 유효성 검사 
	//생년월일 정규식
	var birthJ = RegExp(/^(19|20)[0-9]{2}(0[1-9]|1[1-2])(0[1-9]|[1-2][0-9]|3[0-1])$/);
	
		var birth = $('#birth')	
		var today = new Date();// 날짜 변수 선언
		var yearNow = today.getFullYear(); // 현재 년도
		var monthNow = today.getMonth()+1; // 현재 월 
		var dayNow = today.getDate(); // 현재 일
		
		birth.blur(function() { 
			
		 	if (birthJ.test($('#birth').val()) ) {//유효성 검사 통과시		 	
		 		console.log($('#birth').val().substr(4,1));
					if($('#birth').val().substr(4,1)==0){//월 추출 앞이 0이면
						
						//2월 달 윤달 + 28일 처리
						 if ($('#birth').val().substr(5,1) == 2) { 
				 	          var isleap = (($('#birth').val().substr(0, 4)) % 4 == 0 && (($('#birth').val().substr(0, 4)) % 100 != 0 || ($('#birth').val().substr(0, 4)) % 400 == 0));
				 	        if($('#birth').val().substr(6,1)!=0){//일 추출 앞이 0 이 아니면
				 	        	if ((($('#birth').val().substr(6,2))==29 && !isleap)) {//윤달 확인
 				 	        	$('#birth_check').text($('#birth').val().substr(0, 4)+'년도의 2월은'+ $('#birth').val().substr(6,2)+'일이 존재하지 않습니다');
	 							$('#birth_check').css('color', 'red');
	 							$('#birth').focus(function() { 
	 								$('#birth_check').text('');
	 								});
				 	        	}
	 							if (($('#birth').val().substr(6,2))>29) { 
	 								$('#birth_check').text('생년월일 형식이 맞지 않습니다');
		 							$('#birth_check').css('color', 'red');
		 							$('#birth').focus(function() { 
		 								$('#birth_check').text('');
		 							});
	 							}
 				 	         
				 	        }
						 	
				 	     }
					
						//31일이 존재하지 않는 월 제외하기(11,9월은 유효성 검사에서 걸러짐,  2월은 앞에서 처리)
						if(($('#birth').val().substr(5,1)==4 || $('#birth').val().substr(5,1)==6 ) && $('#birth').val().substr(6,2)==31) {
				 	        	$('#birth_check').text('생년월일 형식이 맞지 않습니다');
	 							$('#birth_check').css('color', 'red');
	 							$('#birth').focus(function() { 
	 								$('#birth_check').text('');
	 							});
				 	     }
						
						
		 		if ($('#birth').val().substr(0, 4)>1900 ){//1900년 이후 출생자
		 			console.log('1900년 이후 출생자 ok');
		 			if($('#birth').val().substr(0, 4)<=yearNow){//현재년도 내 출생자
		 				console.log('현재 년도 내 출생자임');
		 				
		 				if($('#birth').val().substr(0, 4)==yearNow){ //현재년도 출생자라면
		 					console.log('딱!현재년도 출생자임');				
		 						if($('#birth').val().substr(5,1)<monthNow){//현재 월과 비교시 전 달이면
		 							console.log('앞이 0 일때 전달이면 ok');
		 						}else if($('#birth').val().substr(5,1)==monthNow){//현재 월과 동일 달이면
		 							console.log('일을 비교하러 가야되여');
									if($('#birth').val().substr(6,1)==0){ //일 추출 앞이 0 이면
										if($('#birth').val().substr(7,1)<=dayNow){//일이 오늘 포함 전날이면
											console.log('오늘까지 출생한 사람ok');
										}else{//오늘 이후로 출생
											$('#birth_check').text('생년월일 형식이 맞지 않습니다');
				 							$('#birth_check').css('color', 'red');
				 							$('#birth').focus(function() { 
				 								$('#birth_check').text('');
				 							});
										}
									}else{//일 추출 앞이 0이 아니면(1이면)
										if($('#birth').val().substr(6,2)<=dayNow){//일이 오늘 포함 전날이면
											console.log('오늘까지 출생한 사람ok');
										}else{//오늘 이후로 출생
											$('#birth_check').text('생년월일 형식이 맞지 않습니다');
				 							$('#birth_check').css('color', 'red');
				 							$('#birth').focus(function() { 
				 								$('#birth_check').text('');
				 							});
										}
									}
		 						}else{//현재 월과 비교시 이 후 달이면
		 							$('#birth_check').text('생년월일 형식이 맞지 않습니다');
		 							$('#birth_check').css('color', 'red');
		 							$('#birth').focus(function() { 
		 								$('#birth_check').text('');
		 							});
		 						}
		 					}else{//월 추출 앞이 0이 아니면 (즉, 1이면)
		 						
		 					
		 					
		 					
		 						if($('#birth').val().substr(4,2)<monthNow){//현재 월 이전 출생자
		 							console.log('전달이면 ok');
		 						}else if($('#birth').val().substr(4,2)==monthNow){//현재 월과 동일 달이면
		 							//일을 비교하러 가야함
		 							console.log('일을 비교하러 가야되여');
									if($('#birth').val().substr(6,1)==0){ //일 추출 앞이 0 이면
										if($('#birth').val().substr(7,1)<=dayNow){//일이 오늘 포함 전날이면
											console.log('오늘까지 출생한 사람ok');
										}else{//오늘 이후로 출생
											$('#birth_check').text('생년월일 형식이 맞지 않습니다');
				 							$('#birth_check').css('color', 'red');
				 							$('#birth').focus(function() { 
				 								$('#birth_check').text('');
				 							});
										}
									}else{//일 추출 앞이 0이 아니면(1이면)
										if($('#birth').val().substr(6,2)<=dayNow){//일이 오늘 포함 전날이면
											console.log('오늘까지 출생한 사람ok');
										}else{//오늘 이후로 출생
											$('#birth_check').text('생년월일 형식이 맞지 않습니다');
				 							$('#birth_check').css('color', 'red');
				 							$('#birth').focus(function() { 
				 								$('#birth_check').text('');
				 							});
										}
									}
		 						}else{//현재 월 이후
		 							$('#birth_check').text('생년월일 형식이 맞지 않습니다');
		 							$('#birth_check').css('color', 'red');
		 							$('#birth').focus(function() { 
		 								$('#birth_check').text('');
		 							});
		 						}
		 					} 
		 				}else{//현재 년도 이후 출생자
		 					console.log('현재 년도보다 이후 년도임 ');
		 					$('#birth_check').text('생년월일 형식이 맞지 않습니다');
							$('#birth_check').css('color', 'red');
							$('#birth').focus(function() { 
								$('#birth_check').text('');
							});
		 				}		 				
		 			}else{//1900이전 출생자
						
						$('#birth_check').text('생년월일 형식이 맞지 않습니다');
						$('#birth_check').css('color', 'red');
						$('#birth').focus(function() { 
							$('#birth_check').text('');
						});
					}
		 		
		 		}else{//1900년 이전 출생자
					
					$('#birth_check').text('생년월일 형식이 맞지 않습니다');
					$('#birth_check').css('color', 'red');
					$('#birth').focus(function() { 
						$('#birth_check').text('');
					});
				}
			}else if($('#birth').val()==''){//빈칸일 경우 
				$('#birth_check').text('생년월일을 입력해주세요');
								
			}else{//유효성 검사 통과 못함
				
				$('#birth_check').text('생년월일 형식이 맞지 않습니다');
				$('#birth_check').css('color', 'red');
				$('#birth').focus(function() { 
					$('#birth_check').text('');
				});
			}		
	
		});//생년월일 유효성 검사:e

	
});

//ajax으로 이메일 중복 여부 확인	
//이메일 중복 체크 확인 (이메일이 기존 작성된 값과 다를 경우에만 검사함)	
var emailchk=0;
function dupEmailCheck() {
	//기존 값
	var bemail = '<c:out value="${okMember.email}"/>';
	//기존 작성 값과 같다면
	if($('#email').val()==bemail){ 	
		emailchk=1;
		alert('기존 이메일과 동일한 이메일입니다 \n 중복체크를 완료 했습니다');
	}else{ // 기존 값과 달라졌다면
		//이메일 검사 정규식
		var emailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		emailchk=0;
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

}

</script>

<c:import url="/WEB-INF/views/common/header.jsp" />

</head>
<body>

	<!-- subPageTop:s 서브페이지 상단 제목 공통-->
	<div class="subPageTop">
		<div class="sub">
			<div class="s_top_gp_wrap">
				<img src="resources/images/mypage_01.png">
				<div class="title_wrap">
					<p>마이 페이지</p>
					<p>MNR CLINIC MYPAGE</p>
					<p>회원으로 가입하시면 더욱 다양한 컨텐츠 및 서비스를 받아보실 수 있습니다.</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span> Home
					</a></li>
					<li><a href="#" title="마이페이지">마이페이지</a></li>
					<li><a href="#" title="내 정보 보기">내 정보 보기</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->

	<!--wrap:s-->
	<div id="wrap_changeinfo">

		<h1>회원정보 수정페이지</h1>
		<!--container:s-->
		<div class="enroll_info">


			<!--section mypageWrap03:s-->
			<section id="mypageWrap03">
					<form method="post" action="/danaa/chgmeminfo.do" >			
					<input type="hidden" name="id"value="${sessionScope.loginMember.id }">
	
				<div class="tableWrap">
					
			
					<!--join_bottom:s-->
					<div class="join_bottom">
						<div class="tableWrap">
						
								<fieldset>
									<table>
										<colgroup>
											<col width="150">
											<col width="*">
										</colgroup>

										<tbody>

											<tr>
												<th><label for="name">이름</label></th>
												<td>
													<p>${loginMember.name}</p>
												</td>
											</tr>

											<tr>
												<th><label for="id">아이디</label></th>
												<c:if test="${!(fn:contains(loginMember.id, '@'))}">
													<!--일반 회원일 경우 -->
													<td>${loginMember.id}</td>
												</c:if>
												<c:if test="${fn:contains(loginMember.id, '@')}">
													<!--sns 간편 회원 가입 회원일 경우 -->
													<td>sns간편회원가입</td>
												</c:if>

											</tr>
											<tr>
												<th><label for="password">패스워드</label></th>
												<td>
													<!-- <input name="password" id="password" class="inputPass" type="password" maxlength="20" > -->
													<p>******</p> 
											<%-- 		<a href="${pageContext.servletContext.contextPath}/mchgpwdpage.do"><input type='button' 
													value='비밀번호 변경하기' style="opacity: 1; cursor: pointer;"
													onmouseover="this.style.opacity='0.7'"
													onmouseout="this.style.opacity='1'"></a>
													 --%>
													
												</td>
											</tr>
											<tr>
												<th><label for="name">생년월일</label></th>
												<td>
												<input name="birth" id="birth" class="inputPass" type="text" maxlength="20" value="${okMember.birth}" > 
													<font color="red"><div class="check_font" id="birth_check"></div></font>
												</td>
											</tr>
											<tr>
												<th>성별</th>
												<td class="gender"><legend class="blind">성별</legend>
													<c:if test="${okMember.gender eq 'F'}">
													<input type="radio" id="M" name="gender" value="M">남
													<input type="radio" id="F" name="gender" value="F" checked>여
													
													</c:if>
													<c:if test="${okMember.gender eq 'M'}">
													<input type="radio" id="M" name="gender" value="M"checked>남
													<input type="radio" id="F" name="gender" value="F">여
													
													</c:if>
												</td>
											</tr>
											<tr>
												<th>휴대폰</th>
												<td>
												
												<input type="text" name="phone" id="phone"
													value="${okMember.phone}" readonly onclick="window.open('mphonepop.do', 'auth_phone', 'width=625, height=380, toolbars=no, scrollbars=yes'); return false;" > <%-- <p>${loginMember.phone}</p> --%>
												<c:if test="${!empty okMember.phone }"><!-- 휴대폰 번호가 있을 경우(인증이 완료됨) -->
												인증완료
												</c:if>
												
												
												
												
												<!-- 	<input type='button' onclick='#'
													value='인증하기' style="opacity: 1; cursor: pointer;"
													onmouseover="this.style.opacity='0.7'"
													onmouseout="this.style.opacity='1'"> -->
													<!-- <div id="phone_chk_com" class="phone_chk_com">
														<input type="text" name="phonekey" id="phonekey"
															class="phonekey" maxlength="13"> 
															<input
															type='button' onclick='checkKey();' value='인증번호 확인'
															style="opacity: 1; cursor: pointer;"
															onmouseover="this.style.opacity='0.7'"
															onmouseout="this.style.opacity='1'">
													</div> -->
													
													<!-- <input type='button' onclick='return enrollSubmit2();'
													value='인증번호 전송' style="opacity: 1; cursor: pointer;"
													onmouseover="this.style.opacity='0.7'"
													onmouseout="this.style.opacity='1'">
													<div id="phone_chk_com" class="phone_chk_com">
														<input type="text" name="phonekey" id="phonekey"
															class="phonekey" maxlength="13"> <input
															type='button' onclick='checkKey();' value='인증번호 확인'
															style="opacity: 1; cursor: pointer;"
															onmouseover="this.style.opacity='0.7'"
															onmouseout="this.style.opacity='1'">
													</div> -->
													</td>
											</tr>
											<tr>
												<th><label for="email">이메일</label></th>
												<td class="mail_type">
												<input type="text" name="email"
													id="email" value="${okMember.email}" > 
											<!-- 	 onclick="window.open('memailpop.do', 'auth_phone', 'width=700, height=600, toolbars=no, scrollbars=yes'); return false;" -->		
													
												 <input type="button" id="email_dupCheck"
													onclick='dupEmailCheck();' value="중복확인"
													style="opacity: 1; cursor: pointer;"
													onmouseover="this.style.opacity='0.7'"
													onmouseout="this.style.opacity='1'">
								
													</td>
											</tr>
											<tr>
												<th>이메일 수신여부</th>
												<td class="ag_email">

													<fieldset>
														<legend class="blind">이메일 수신여부</legend>
														<c:if test="${ okMember.ag_email eq 'Y'}">
														<input type=radio id="Y" value="Y" name="ag_email" checked /> <label
															for="Y">예</label> <input type=radio id="N" value="N"
															name="ag_email" /> <label for="N">아니오</label>
														</c:if>
														<c:if test="${ okMember.ag_email eq 'N'}">	
															<input type=radio id="Y" value="Y" name="ag_email" /> <label
															for="Y">예</label> <input type=radio id="N" value="N"
															name="ag_email" checked/> <label for="N">아니오</label>
														</c:if>
													</fieldset>
												</td>
												
												
											</tr>
										</tbody>
									</table>
								</fieldset>
							
						</div>
						
					</div>
					
					<!--join_bottom:e-->
				<hr>
				</div>
				
				<div class="pagingwrite_upinfo" align="center">
					<span> <!-- 회원정보 수정/ 탈퇴 모두 각각의 현재 비밀번호 확인 페이지로 넘어감 --> 
					<input type="submit" value="수정하기" class="enroll_button2 btn_common_n1" style="opacity: 1; cursor:pointer;" onmouseover="this.style.opacity='0.7'"
						onmouseout="this.style.opacity='1'">
				
					</span>
					<c:url var="mdelchkinfo" value="mdelchkinfo.do" />
					<span class="first"><a href="${mdelchkinfo}" class="enroll_button2 btn_common_n1" style="opacity: 1; cursor:pointer;" onmouseover="this.style.opacity='0.7'"
						onmouseout="this.style.opacity='1'">탈퇴하기</a></span>
					
					</span>
					<c:url var="mainback" value="mypagefm.do" />
					<span class="first"><a href="${mainback}"  class="enroll_button2 btn_common_n1" style="opacity: 1; cursor:pointer;" onmouseover="this.style.opacity='0.7'"
						onmouseout="this.style.opacity='1'">취소</a></span>
				</div>
				</form>
			</section>
			<!--section mypageWrap03:e-->
		</div>
		<!--container:e-->


	</div>
	<!--wrap:e-->

	<!-- footer -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>