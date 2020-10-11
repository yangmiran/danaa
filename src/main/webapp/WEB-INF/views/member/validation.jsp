<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<script type="text/javascript" src="/danaa/resources/js/jquery-3.5.1.min.js">
</script>
<script type="text/javascript">

/*홈페이지에서 사용자에게 보여주기 위한 JQuery를 사용한 유효성 검사*/

//아이디 정규식
var idJ = /^[a-zA-Z0-9]{4,12}$/; // 대소문자, 숫자 4~12
//비밀번호 정규식 
var pwdJ = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,}$/ //영문자 +숫자 +특수 문자 포함, 최소 6자리
//이름 정규식
var nameJ = /^[가-힣]{2,6}$/; //이름은 한글 2~6자
//생년월일 정규식
var birthJ = RegExp(/^(19|20)[0-9]{2}(0[1-9]|1[1-2])(0[1-9]|[1-2][0-9]|3[0-1])$/);
//이메일 검사 정규식
var emailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
// 휴대폰 번호 정규식
 var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/; 

//이름 유효성 검사:s	
	
	



$(function(){
		
	
	
	//패스워드 확인:s  (***음... 실시간으로 좀 바꿀까 이거 고민중)
	var pwdck = $('#pwdck');
	pwdck.blur(function() {
		
		if (pwdJ.test($('#pwd').val())) {//유효성 검사를 pwd가 통과했을시
			if ($('#pwd').val() !== $('#pwdck').val()) {
				$('#pwd_check').text('패스워드가 일치하지 않습니다');//패스워드 확인과 불일치시
				$('#pwd_check').css('color', 'red');
				$('#pwd').focus(function() { 
					$('#pwd_check').text('');
				});
				$('#pwdck').focus(function() { 
					$('#pwd_check').text('');
				});
				
			} else {
				$('#pwd_check').text('');//패스워드 확인 일치시
				$("#name").focus();
				$('#name').focus(function() { //포커스가 name으로 처음가면 멘트 리셋
					$('#name_check').text('');
				});
			}
		} else {//유효성 검사 통과 못했을시
			$('#pwd_check').text('패스워드가 형식이 맞지 않습니다');
			$('#pwd_check').css('color', 'red');
			$('#pwdck').focus(function() { 
				$('#pwd_check').text('');
			});
		}

	});//패스워드 확인:e 
		


	 //이름 유효성 검사:s	
		var name = $('#name');

		name.blur(function() {
			if (nameJ.test($('#name').val()) || $('#name').val()=='' ) {
				$('#name_check').text(''); //이름 유효성 일치시

			} else {
				$('#name_check').text('이름 형식이 맞지 않습니다');//이름 유효성 불일치시
				$('#name_check').css('color', 'red');
				$('#name').focus(function() { //포커스가 name으로 가면 멘트 리셋
					$('#name_check').text('');
				});
			}
		}); //이름 유효성 검사 :e 
		

	//생년월일 유효성 검사:s (+추가적으로 1900년이후 출생자, 현재년도 내 출생자만 등록가능설정)
	//birth를 String으로 바꿔서 01 과 1을 비교 하기 복잡해짐 ~어떻게든 나눠서 하긴함... 이게 최선인지...
		var birth = $('#birth')	
		var today = new Date();// 날짜 변수 선언
		var yearNow = today.getFullYear(); // 현재 년도
		var monthNow = today.getMonth()+1; // 현재 월 
		var dayNow = today.getDate(); // 현재 일
		<%-- var birthdatechk ='<%=(String)session.getAttribute("child")%>';
		console.log(birthdatechk);
		console.log('<%=(String)session.getAttribute("child")%>');
		console.log('<%=session.getAttribute("child")%>');
		console.log(yearNow-$('#birth').val().substr(0, 4)); --%>
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
				$('#birth_check').text('');
								
			}else{//유효성 검사 통과 못함
				
				$('#birth_check').text('생년월일 형식이 맞지 않습니다');
				$('#birth_check').css('color', 'red');
				$('#birth').focus(function() { 
					$('#birth_check').text('');
				});
			}		
	
		});//생년월일 유효성 검사:e

		
		//엔터키 submit 방지
		document.addEventListener('keydown', function(event) {
			if (event.keyCode === 13) {
			    event.preventDefault();
			};
		}, true);
		
		/*컨트롤러 유효성 체크 후 포커스 시 에러 reset*/
		 $('#id').focus(function() { 
				$('#id_check2').text('');
						});
		 $('#pwd').focus(function() { 
				$('#pwd_check2').text('');
						});
		 $('#pwdck').focus(function() { 
				$('#pwd_check2').text('');
						});
		 $('#name').focus(function() { 
				$('#name_check2').text('');
						});
		 $('#birth').focus(function() { 
				$('#birth_check2').text('');
						});		 	 
		 $('#email').focus(function() { 
				$('#email_check2').text('');	
			});
		 $('#email').focus(function() { 
				$('#email_check').text('');	
			});
		 $('#phone').focus(function() { 
				$('#phone_check2').text('');
						});	
		//라디오버튼 checked 되있을시
		/* $("form:radiobutton[name='gender']").click(function(){
			$('#gender_check2').text('');
		});  */
		/*  if($("form:radiobutton[name='gender']").is(':checked')){
			$('#gender_check2').text('');
		}  */
		/* if($("#gender").is(":checked")) {
			$('#gender_check2').text('');
		} */

	/* 	$('#gender').val()=='F' || $('#gender').val()=='M' */
		 
		 
			
	});


</script>


</head>
<body>

</body>
</html>