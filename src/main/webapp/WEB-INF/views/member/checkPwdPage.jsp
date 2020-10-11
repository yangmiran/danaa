<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

 <c:set var="userid" value="${loginMember.id}"/>         
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<!-- 내 정보 수정하기 전 패스워드 확인 -->

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


function pwdCheck(){ /// 비밀번호가 빈칸이지 여부에 따라
	if ($('#pwd').val() !=='') { //비밀번호가 빈칸이 아니라면
		frm.action = 'chkinfobc.do';	
		frm.submit(); 
		
	}else{//비밀번호가 빈칸이라면
		alert('비밀번호를 입력해주세요')
		$('#pwd').focus();
		return false;
	}
	
}


//비밀번호 확인
	/*  function pwdCheck() {
		if ($('#pwd').val() !=='') { //비밀번호가 빈칸이 아니라면
			$.ajax({
				url : "/danaa/chkinfobc.do",
				type : "post",
				data : {
					id : $("#id").val(),
					pwd : $("#pwd").val()
				},
				success : function(result) {
					if (result > 0) { //회원정보 수정페이지로 이동
						frm='mupmpage.do';
						frm.submit();
						 onclick="javascript: form.action='/danaa/mypagefm.do';" 
						return true
						
					} else {//비밀번호 잘못됨
						alert("비밀번호가 일치하지 않습니다.\n다시 입력하세요.");
						$("#pwd").val(''); //비밀번호 지움
					}
				},
				error : function(jqXHP, textstatus, errorthrown) {
					console.log("error : " + jqXHR + ", " + textstatus + ", "
							+ errorthrown);
				}
			});

			return false;
			
		}else {//비밀번호가 빈칸이라면 
			alert('비밀번호를 입력해주세요')
			$('#pwd').focus();
			return false;
		}

	}  */
	</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/header.jsp" />
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
	<div id="wrap_chpwd" >
		<h1 class="subtit">
			<span>회원정보 변경을 위한 비밀번호 확인</span>
		</h1>
		<br>
		<div class="my_pwd_update">
			<hr>
			<form method="post"   action="chkinfobc.do"  ><!-- onsubmit="return" -->
				<input type="hidden" name=id id=id value="${loginMember.id}" >
				<table id="outer" align="center" width="500" cellspacing="5" cellpadding="0">
					<caption >안전한 회원정보 변경을 위해서 현재 비밀번호를 다시한번 입력해주세요</caption>
					<br>
					<tr>
						<th width="220">아이디</th>
						<c:if test = "${!(fn:contains(userid, '@'))}"><!--일반 회원일 경우 -->
						<td>${loginMember.id}</td>
						</c:if>
						<c:if test = "${fn:contains(userid, '@')}"><!--sns 간편 회원 가입 회원일 경우 -->
						<td>sns간편회원가입</td>
						</c:if>

					</tr>

					<tr>
						<th>현재 비밀번호</th>
						<td><input style="border: 1px solid #d1d1d1" type="password" name="pwd" id="pwd"></td>
					</tr>
				</table>
				
				<hr>
				<div class="btn_in">
					<!-- <input type="submit" value="지금 변경하기" >  -->
					<input type="submit" class="enroll_button3 btn_common_n1"
								onclick='return pwdCheck(this.form);' style="opacity: 1; cursor:pointer;"
								onmouseover="this.style.opacity='0.7'"
								onmouseout="this.style.opacity='1'" value="변경하기"> 
					 
				
			</form>
			 <a href="${pageContext.servletContext.contextPath}/mypagefm.do">
			 <input type="button" value="취소" class="enroll_button4 btn_common_n2" style="opacity: 1; cursor:pointer;"
								onmouseover="this.style.opacity='0.7'"
								onmouseout="this.style.opacity='1'"/></a>
								</div>
		</div>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>