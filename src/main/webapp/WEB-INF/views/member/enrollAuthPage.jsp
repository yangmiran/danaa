<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <c:set var="child" value="${child}"/> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<!-- 회원가입STEP02 약관동의 페이지 -->

<!--맨 밑 footer만 보이게 설정-->
<style type="text/css">
#footer .footer_in .cont {
	display: none;
}
</style>
<script type="text/javascript">

	//전체 동의 checkbox 클릭시 자동으로 밑에 체크 박스 선택됨
	function allagree(objCheck) { 
		var checks = document.getElementsByName('jagree');
		for (var i = 0; i < checks.length; i++) {
			checks[i].checked = objCheck;
	// name이 'jagree' 인 checkbox는  id가 allagree인 checkbox의 checked 상태와 같게 된다. 
		}
	}
	
	///약관을 각각 체크하면 모두 동의에 체크됨
	function eachagree(){ 
		
		if(($("#jagree1").is(":checked")==true) && ($("#jagree2").is(":checked")==true)){			
			$("#allagree").prop('checked', true);	
			
		}else{			
			$("#allagree").prop('checked', false);			
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
				url : "/danaa/test7.do",
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
					} else {
						alert("인증번호 전송이 완료되었습니다");
						
						clearInterval(x);
						
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
	
	
	//다음단계로 이동하기 전에 약관 체크 다 되있는지 확인
	function checkNext(){
		if(($("#allagree").is(":checked")==false) || ($("#jagree1").is(":checked")==false) ||($("#jagree2").is(":checked")==false)){
			
			alert("모든 약관에 동의 하셔야 다음 단계로 이동하실 수 있습니다 ");	
			return false;
		}else{
			//휴대폰 유효성 검사 
			var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;  
			
			var test = '<%=(String)session.getAttribute("child")%>';
			var id = '<%=(String)session.getAttribute("id")%>';
				//일반 회원/14세 미만일때,휴대폰 유효성 검사 통과시
			 if (phoneJ.test($('#phone').val()) &&($('#phone_check').text('인증 완료')) && test=='Y') { 
			
				 return true;
			 }else if(test=='N'){//14세 이상일 때
				
				 return true;
			 }else if($('#phone').val()==''){//휴대폰 번호가 없을 때
				 alert('휴대폰 번호를 입력해주세요');
					
				 return false;
			 }else{// 그밖에
				 alert('보호자 인증을 해주세요');
				
				 return false;
			 }
						
		}
	}

	
	
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
					<li><a href="${ pageContext.servletContext.contextPath }/enrollfp.do" title="회원가입">회원가입</a></li>
					<li><a href="${ pageContext.servletContext.contextPath }/tospage.do" title="약관동의">약관동의</a></li>
				</ul>
			</nav>
		</div>
	</div><!-- subPageTop:e 서브페이지 상단 제목 공통-->
<div id="enrollA_allwrap"><!-- 전체 :s -->	
	<div id="wrap">
		<div class="enroll_bar">
			<div class="sub-title">
				<h3>약관동의</h3>
				<br>
				<p>약관 동의를 해주셔야 서비스 이용이 가능합니다</p>
				<hr>
			</div>
		</div>

	</div>
	<!-- wrap 끝 -->
	<!-- 여기까지 bar -->
			
			<!--section joinWrap:s-->
			<section id="authWrap">
			<c:if test="${child eq 'Y'}"><!--  14세 미만 회원일 경우&sns간편회원가입 아닌 경우만 보여짐 -->
			<!-- 14세미만 보호자 확인 -->
			<div class="under_f_check">	
		
				<form action="test3.do" method="post">
					
					<h2>보호자 인증 휴대폰 번호</h2><span class="id_txt">(-없이 숫자만 입력하세요)</span>
					<input type="text" id="phone" name="phone" class="inputPhone"
						maxlength="20" style="width:120px;">					
					
						
						<input type='button' onclick='return enrollSubmit2();'
							value='인증번호 전송' style="opacity: 1; background-color:#ded9d9; width:120px;cursor:pointer;" onmouseover="this.style.opacity='0.7'"
						onmouseout="this.style.opacity='1'">
						<input type="text" name="phonekey" id="phonekey" maxlength="13" style="width:120px;">
						<input type='button' onclick='checkKey();' value='번호 확인' style="opacity: 1; width:100px;background-color:#ded9d9;cursor:pointer;" onmouseover="this.style.opacity='0.7'"
						onmouseout="this.style.opacity='1'">
						<div id="demo" class="demo"></div>
						<div class="check_font" id="phone_check"></div>
						<br>
						
					<br>
					
					


			
				</form>
			</div>
			<hr>
					</c:if>
				
				<div class="allcheck">
				
					<input type="checkbox" id="allagree" name="allagree" onclick="allagree(this.checked);" 
						title="아래 내용에 모두 동의합니다 ."> <label for="allagree">
						아래 내용에 모두 동의합니다 .</label>
				</div>
				<!--join_top:s-->
				<div class="auth_top">
					<div class="authBoxWrap">
						<h3>
							서비스 이용약관 <span class="colorPoint requiredTxt">(*필수사항)</span>
						</h3>
						<div class="authBox">
							<p class="jtxt">
								제1조(목적)<br> 이 약관은 미앤란 클리닉(이하 “회사”라 한다)이 운영하는 인터넷 웹사이트에서
								제공하는 서비스를 이용함에 있어 이용자의 권리,의무 및 책임사항을 규정함을 목적으로 합니다.<br>
								※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다」<br>
								<br> 제2조(정의)<br> ① “회사”란 재화 또는 용역(이하 “재화등”이라 함)을 이용자에게
								제공하기 위하여 컴퓨터등 정보통신설비를 이용하여 재화등을 거래할 수 있도록 설정한 가상의 영업장을 말합니다.<br>
								② “이용자”란 “사이트”에 접속하여 이 약관에 따라 “회사”가 제공하는 “서비스”를 받는 회원 및 비회원을
								말합니다.<br> ③ “미앤란 클리닉 회원”(이하 "회원"이라 한다)이란 “회사”에 개인정보를 제공하여
								회원등록을 하고 회원ID를 부여받은 자 또는 그 회원전체를 의미하며, 부여받은 회원ID로 “회사”의 정보를
								지속적으로 제공받으며, “회사”가 제공하는 “서비스”를 계속적으로 이용할 수 있는 자를 말합니다.<br>
								④ “비회원”란 회원에 가입하지 않고 “회사”가 제공하는 “서비스”를 이용하는 자를 말합니다.<br> ⑤
								"미앤란 클리닉 사이트"(이하 "사이트"라 한다)란 "회사"에 회원등록한 이용자가 다양한 정보와 서비스를 제공받을
								수 있도록 "회사" 또는 "회원사"가 제작, 운영하는 인터넷 웹사이트를 의미합니다.<br> <br>
								제3조 (약관등의 명시와 설명 및 개정)<br> ① “회사”는 이 약관의 내용과 상호 및 대표자 성명,
								영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호.모사전송번호.전자우편주소,
								사업자등록번호, 통신판매업신고번호, 개인정보관리책임자등을 이용자가 쉽게 알 수 있도록 미앤란 클리닉 사이트의 초기
								서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.<br>
								② “회사”는 전자상거래등에서의 소비자보호에관한법률, 약관의규제에관한법률, 전자거래기본법, 전자서명법,
								정보통신망이용촉진등에관한법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.<br>
								③ “회사”가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자
								7일이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일
								이상의 사전 유예기간을 두고 공지합니다. 이 경우 "회사“는 개정전 내용과 개정후 내용을 명확하게 비교하여 이용자가
								알기 쉽도록 표시합니다.<br> ④ “회사”가 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에
								체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정전의 약관조항이 그대로 적용됩니다. 다만 이미
								계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간내에 ‘회사“에
								송신하여 ”회사“의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.<br> ⑤ 이 약관에서 정하지 아니한
								사항과 이 약관의 해석에 관하여는 전자상거래등에서의 소비자보호에관한법률, 약관의규제등에관한법률, 공정거래위원회가
								정하는 전자상거래등에서의소비자보호지침 및 관계법령 또는 상관례에 따릅니다.<br> <br>
								제4조(서비스의 제공 및 변경)<br> ① “회사”는 다음과 같은 업무를 수행합니다.<br> 상품
								또는 용역의 판매 다양한 정보의 제공 광고, 이벤트 행사 등 상품 또는 용역과 관련한 다양한 판촉 행위 기타
								이용자에게 유용한 부가 서비스 ② “회사”는 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차
								체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의
								내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.<br> ③
								“회사”가 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화등의 품절 또는 기술적 사양의 변경 등의 사유로
								변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.<br> ④ 전항의 경우
								“회사”는 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, “회사”가 고의 또는 과실이 없음을 입증하는
								경우에는 그러하지 아니합니다.<br> <br> 제5조(서비스의 중단)<br> ①
								“회사”는 컴퓨터 등 정보통신설비의 보수점검.교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의
								제공을 일시적으로 중단할 수 있습니다.<br> ② “회사”는 제1항의 사유로 서비스의 제공이 일시적으로
								중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, “회사”가 고의 또는 과실이 없음을
								입증하는 경우에는 그러하지 아니합니다.<br> ③ 사업종목의 전환, 사업의 포기, 업체간의 통합 등의
								이유로 서비스를 제공할 수 없게 되는 경우에는 “회사”는 제8조에 정한 방법으로 이용자에게 통지하고 당초
								“회사”에서 제시한 조건에 따라 소비자에게 보상합니다. 다만, “회사”가 보상기준 등을 고지하지 아니한 경우에는
								이용자들의 마일리지 또는 적립금 등을 “회사”에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 이용자에게
								지급합니다.<br> <br> 제6조(회원가입)<br> ① 이용자는 “회사”가 정한 가입
								양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.<br>
								② “회사”는 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각호에 해당하지 않는 한 회원으로
								등록합니다.<br> 1. 가입신청자가 이 약관 제7조제3항에 의하여 이전에 회원자격을 상실한 적이 있는
								경우, 다만 제7조제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 “회사”의 회원재가입 승낙을 얻은 경우에는
								예외로 한다.<br> 2. 등록 내용에 허위, 기재누락, 오기가 있는 경우<br> 3. 기타
								회원으로 등록하는 것이 “회사”의 기술상 현저히 지장이 있다고 판단되는 경우<br> ③ 회원가입계약의
								성립시기는 “회사”의 승낙이 회원에게 도달한 시점으로 합니다.<br> ④ 회원은 제15조제1항에 의한
								등록사항에 변경이 있는 경우, 즉시 전자우편 기타 방법으로 “회사”에 대하여 그 변경사항을 알려야 합니다.<br>
								<br> 제7조(회원 탈퇴 및 자격 상실 등)<br> ① 회원은 “회사”에 언제든지 탈퇴를 요청할
								수 있으며 “회사”는 즉시 회원탈퇴를 처리합니다.<br> ② 회원이 다음 각호의 사유에 해당하는 경우,
								“회사”는 회원자격을 제한 및 정지시킬 수 있습니다.<br> 1. 가입 신청시에 허위 내용을 등록한 경우<br>
								2. “회사”을 이용하여 구입한 재화등의 대금, 기타 “회사”가용에 관련하여 회원이 부담하는 채무를 기일에 지급하지
								않는 경우<br> 3. 다른 사람의 “회사” 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를
								위협하는 경우<br> 4. “회사”을 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를
								하는 경우<br> ③ “회사”가 회원 자격을 제한.정지 시킨후, 동일한 행위가 2회이상 반복되거나
								30일이내에 그 사유가 시정되지 아니하는 경우 “회사”는 회원자격을 상실시킬 수 있습니다.<br> ④
								“회사”가 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소전에
								최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.<br> <br> 제8조(회원에 대한
								통지)<br> ① “회사”가 회원에 대한 통지를 하는 경우, 회원이 “회사”와 미리 약정하여 지정한
								전자우편 주소로 할 수 있습니다.<br> ② “회사”는 불특정다수 회원에 대한 통지의 경우 1주일이상
								“회사” 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을
								미치는 사항에 대하여는 개별통지를 합니다.<br> <br> 제9조(회사의 의무)<br>
								① “회사”는 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라
								지속적이고, 안정적으로 재화․용역을 제공하는데 최선을 다하여야 합니다.<br> ② “회사”는 이용자가
								안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야
								합니다.<br> ③ “회사”가 상품이나 용역에 대하여 「표시.광고의공정화에관한법률」 제3조 소정의 부당한
								표시․광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.<br> ④ “회사”는
								이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.<br> <br>
								제10조(회원의 ID 및 비밀번호에 대한 의무)<br> ① 제9조의 경우를 제외한 ID와 비밀번호에 관한
								관리책임은 회원에게 있습니다.<br> ② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는
								안됩니다.<br> ③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한
								경우에는 바로 “회사”에 통보하고 “회사”의 안내가 있는 경우에는 그에 따라야 합니다.<br> <br>
								제11조(이용자의 의무)<br> 이용자는 다음 행위를 하여서는 안됩니다.<br> 1. 신청 또는
								변경시 허위 내용의 등록<br> 2. 타인의 정보 도용<br> 3. “회사”에 게시된 정보의 변경<br>
								4. “회사”가 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시<br> 5. “회사”
								기타 제3자의 저작권 등 지적재산권에 대한 침해<br> 6. “회사” 기타 제3자의 명예를 손상시키거나
								업무를 방해하는 행위<br> 7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를
								몰에 공개 또는 게시하는 행위<br> <br> 제12조(사이트 연결)<br> ① 상위
								“회사”와 하위 “회사”가 하이퍼 링크(예: 하이퍼 링크의 대상에는 문자, 그림 및 동화상 등이 포함됨)방식 등으로
								연결된 경우, 전자를 연결 “회사”(웹 사이트)이라고 하고 후자를 피연결 “회사”(웹사이트)이라고 합니다.<br>
								② 연결“회사”는 피연결“회사”가 독자적으로 제공하는 재화등에 의하여 이용자와 행하는 거래에 대해서 보증책임을 지지
								않는다는 뜻을 연결“회사”의 초기화면 또는 연결되는 시점의 팝업화면으로 명시한 경우에는 그 거래에 대한 보증책임을
								지지 않습니다.<br> <br> 제13조(저작권의 귀속 및 이용제한)<br> ①
								“회사“가 작성한 저작물에 대한 저작권 기타 지적재산권은 ”회사“에 귀속합니다.<br> ② 이용자는
								“회사”을 이용함으로써 얻은 정보 중 “회사”에게 지적재산권이 귀속된 정보를 “회사”의 사전 승낙없이 복제, 송신,
								출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.<br>
								③ “회사”는 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.<br>
								<br> 제14조(분쟁해결)<br> ① “회사”는 이용자가 제기하는 정당한 의견이나 불만을
								반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치.운영합니다.<br> ② “회사”는
								이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는
								이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다.<br> ③ “회사”와 이용자간에 발생한 전자상거래
								분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시•도지사가 의뢰하는 분쟁조정기관의 조정에
								따를 수 있습니다.<br> <br> 제15조(재판권 및 준거법)<br> ① “회사”와
								이용자간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를
								관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의
								경우에는 민사소송법상의 관할법원에 제기합니다.<br> ② “회사”와 이용자간에 제기된 전자상거래 소송에는
								국내법을 적용합니다.<br> <br> 부칙<br> 이 약관은 2013년 8월 12일부터
								시행합니다.<br> &lt; 참 고 자 료 &gt;<br> 1. 표준약관 현행<br>
								2. 한국소비자원의 심사청구 공문<br> 3. 관련 사업자단체 의견<br>
							</p>
							<div class="jcheck">
						
								<input type="checkbox" id="jagree1" name="jagree"  value=""
									title="회원가입약관에 동의합니다 체크해주세요." onclick="eachagree();"> <label for="jagree1">
									회원가입약관에 동의합니다.</label>
							</div>
						</div>
					</div>
					<div class="authBoxWrap">
						<h3>
							개인정보수집이용에 대한 안내<span class="colorPoint requiredTxt">(*필수사항)</span>
						</h3>
						<div class="authBox">
							<p class="jtxt">
								1. 수집하는 개인정보의 항목<br> &lt;가. 개인정보 수집항목&gt;<br> 첫째, 회사는
								회원가입, 원활한 고객상담, 각종 서비스의 제공을 위해 최초 회원가입 당시 아래와 같은 최소한의 개인정보를
								필수항목으로 수집하고 있습니다.<br> &lt;일반 회원가입&gt;<br> - 성명, 아이디,
								비밀번호, 연락처(메일주소, 휴대폰 번호)<br> &lt;방문상담예약 등록시&gt;<br> -
								성명, 아이디, 비밀번호, 연락처(메일주소, 휴대폰 번호)<br> &lt;전화상담예약 등록시&gt;<br>
								성명, 전화번호, 서비스 이용과정이나 사업처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.<br>
								- IP Address, 쿠키, 방문 일시, 서비스 이용 기록<br> &lt;나. 개인정보 수집방법&gt;<br>
								회사는 다음과 같은 방법으로 개인정보를 수집합니다.<br> - 홈페이지, 방문상담예약, 전화상담예약<br>
								<br> 2. 개인정보의 수집 및 이용목적<br> &lt;가. 회원관리&gt;<br> -
								회원제 서비스 이용 및 제한적 본인 확인제에 따른 본인확인, 개인식별, 가입의사 확인, 가입 및 가입횟수 제한,
								만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인, 추후 법정 대리인 본인확인, 분쟁 조정을 위한
								기록보존, 불만처리 등 민원처리, 고지사항 전달<br> &lt;나. 신규 서비스 개발 및 마케팅•광고에의
								활용&gt;<br> - 신규 서비스 개발 및 맞춤 서비스 제공, 통계학적 특성에 따른 서비스 제공 및 광고
								게재, 서비스의 유효성 확인, 이벤트 및 광고성 정보 제공 및 참여기회 제공, 접속빈도 파악, 회원의 서비스이용에
								대한 통계<br> <br> 3. 개인정보의 보유 및 이용기간<br> 이용자의 개인정보는
								원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로
								명시한 기간 동안 보존합니다.<br> &lt;가. 회사 내부 방침에 의한 정보보유 사유&gt;<br>
								• 부정이용기록<br> - 보존 이유 : 부정 이용 방지<br> - 보존 기간 : 1년
							</p>
							<div class="jcheck">
								<input type="checkbox" id="jagree2" name="jagree"  onclick="eachagree();" value=""
									title="개인정보취급방침에 동의합니다 체크해주세요."> <label for="jagree2">
									개인정보취급방침에 동의합니다.</label>
							</div>
						</div>
					</div>
			


			<div class="jpage_move">
					<span><a href="<c:url value='typepage.do'/>" class="jbefore_move" style="opacity:1" 
						onmouseover="this.style.opacity='0.7'" 
						onmouseout="this.style.opacity='1'">이전단계</a></span>
				
					<c:if test="${empty id}"><!--일반 회원 가입시 -->
					<span>
						<c:url var="enrollch" value="enrollpage.do">
							<c:param name="child" value="${child}"/> 
						
						</c:url>
						 
					<a href="${enrollch}" class="jafter_move"style="opacity:1" 
						onmouseover="this.style.opacity='0.7'" 
						onmouseout="this.style.opacity='1'" onclick='return checkNext(); '>다음단계</a>
					</span>
					</c:if>
					<c:if test="${!empty id}"><!--SNS 회원 가입시 -->
					<span>
						<c:url var="enrollsnsch" value="enrollsnspage.do">
							<c:param name="child" value="${child}"/> 
							
						</c:url>
					<a href="${enrollsnsch}" class="jafter_move"style="opacity:1" 
						onmouseover="this.style.opacity='0.7'" 
						onmouseout="this.style.opacity='1'" onclick='return checkNext();'>다음단계</a>
					</span>
					</c:if>
				
					</div>	
					

				</div>
				<!--joinWrap:e-->
</section>

</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>