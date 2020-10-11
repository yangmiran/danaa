<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<!-- 마이페이지에서 비밀번호 변경 페이지 -->
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



	//지금 변경하기 버튼 클릭시 검사		

	function chkPwdbc(frm) {
		//비밀번호 정규식 
		var pwdJ = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,}$/ //영문자 +숫자 +특수 문자 포함, 최소 6자리 

		if ($('#pwd').val() !== '') {//현재 비밀번호 입력 칸이 빈칸이 아니라면

			if (pwdJ.test($('#pwd2').val())) {//유효성 검사를 pwd가 통과했을시
				if ($('#pwd2').val() !== $('#pwdck').val()) {
					$('#pwd_check').text('새로운 비밀번호가 일치하지 않습니다');//패스워드 확인과 불일치시
					$('#pwd_check').css('color', 'red');
					$('#pwd2').focus(function() {
						$('#pwd_check').text('');
					});
					$('#pwdck').focus(function() {
						$('#pwd_check').text('');
					});

				} else {//새로운 비밀번호와 비밀번호 확인 값이 일치
					if ($('#pwd').val() == $('#pwd2').val()) {//기존 패스워드와 새로운 패스워드가 같으면 안됨
						$('#pwd_check').text('기존 비밀번호와 같은 값으로 변경할 수 없습니다');
						$('#pwd_check').css('color', 'red');
						$('#pwd2').focus(function() {
							$('#pwd_check').text('');
						});
						$('#pwdck').focus(function() {
							$('#pwd_check').text('');
						});

					} else {//기존패스워드와 다르고, 확인 값이 일치할 경우
						/* $('#pwd_check').text('비밀번호 확인완료');
						$('#pwd_check').css('color', 'blue'); */
						frm.action = 'pwdchk2.do';
						frm.submit();
						return true;
					}
				}
			} else {//유효성 검사 통과 못했을시
				$('#pwd_check').text('새로운 비밀번호가 형식이 맞지 않습니다');
				$('#pwd_check').css('color', 'red');
				$('#pwdck').focus(function() {
					$('#pwd_check').text('');
				});
				$('#pwd2').focus(function() {
					$('#pwd_check').text('');
				});
			}
		} else {//현재 비밀번호 입력칸이 빈칸이라면
			$('#pwd_check').text('현재 비밀번호를 입력해 주세요');
			$('#pwd_check').css('color', 'red');
			$('#pwd').focus(function() {
				$('#pwd_check').text('');
			});

		}
	}
</script>

</head>
<body>

<!-- header -->
<c:import url="/WEB-INF/views/common/header.jsp" />
<!-- subPageTop:s 서브페이지 상단 제목 공통-->
	<div class="subPageTop">
		<div class="sub">
			<div class="s_top_gp_wrap">
				<img src="resources/images/mypage_01.png">
				<div class="title_wrap">
					<p>마이페이지</p>
					<p>MNR CLINIC </p>
					<p>회원으로 가입하시면 더욱 다양한 컨텐츠 및 서비스를 받아보실 수 있습니다.</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span> Home
					</a></li>
					<!-- <li><a href="#" title="마이페이지">마이페이지</a></li>
					<li><a href="#" title="내 정보 보기">내 정보 보기</a></li> -->
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->

	<div id="wrap_chpwd" >
		 <h1 class="subtit_pwd"> 
			비밀번호 변경 
		</h1> 
		<br>
		
		<div class="my_pwd_update">
		<hr> 
			<form method="post"   action="pwdchk.do" onsubmit="return" >
				<input type="hidden" name=id value="${loginMember.id}" >
				<table id="outer" >
					<%-- <caption>비밀번호 변경하기</caption>
					
					<hr>--%>
					<br> 
					<tbody>
				
					<tr>
						<th>현재 비밀번호</th>
						<td><input style="border: 1px solid #d1d1d1; width:400px;" type="password" name="pwd" id="pwd"></td>
					</tr>
					<tr>
						<th>새로운 비밀번호</th>
						<td><input style="border: 1px solid #d1d1d1; width:400px;" type="password" placeholder="영문자,숫자,특수문자 조합. 최소 6자이상 입력하세요." name="pwd2" id="pwd2">			
							
						</td>
					</tr>
					<tr >
						<th>새로운 비밀번호 확인</th>
						<td><input style="border: 1px solid #d1d1d1; width:400px;" type="password" placeholder="영문자,숫자,특수문자 조합. 최소 6자이상 입력하세요." name="pwdck" id="pwdck">
							
							
						</td>
					</tr>
					
					<tr class="pwdchangend_check">
						<th></th>
						<td>
							
							<div class="check_font" id="pwd_check"></div> 
						</td>
					</tr>
					</tbody>
				</table>
				
				<hr>
				<div class="enroll_btn_box">					
					<input type='button' class="enroll_button2 btn_common_n1" onclick='return chkPwdbc(this.form);'value="변경하기" style="opacity:1; cursor:pointer;" 
						onmouseover="this.style.opacity='0.7'" 
						onmouseout="this.style.opacity='1'">			
					 <input type="submit" class="enroll_button2 btn_common_n2" value="취소" onclick="javascript: form.action='/danaa/mypagefm.do';" style="opacity:1; cursor:pointer;" 
						onmouseover="this.style.opacity='0.7'" 
						onmouseout="this.style.opacity='1'"/>
				</div>
			</form>
		</div>

	</div>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>