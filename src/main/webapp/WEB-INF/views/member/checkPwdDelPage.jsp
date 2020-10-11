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
	//회원탈퇴 alert창
	
	
	function deleteCheck(){ //회원탈퇴 버튼 클릭시 경고창 후,처리
		if ($('#pwd').val() !=='') { //비밀번호가 빈칸이 아니라면
			alert("회원탈퇴는 번복할 수 없습니다 \n 정말 탈퇴하시겠습니까?");
			 frm.action = 'chkinfobd.do';	
			frm.submit(); 
			
		}else{//비밀번호가 빈칸이라면
			alert('비밀번호를 입력해주세요')
			$('#pwd').focus();
			return false;
		}
		
	}
	
	
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
					<li><a href="#" title="회원탈퇴">회원탈퇴</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->
	
	<div id="wrap_chpwd" >
		<h1 class="subtit">
			<span>회원 탈퇴</span>
		</h1>
		<hr>
		<div class="my_pwd_update">
			<form method="post"   action="chkinfobd.do" onsubmit='return deleteCheck(this.form);' >
				<input type="hidden" name=id value="${loginMember.id}" >
				<table id="outer" align="center" width="500" cellspacing="5" cellpadding="0">
					<caption>안전한 탈퇴처리를 위해 비밀번호를 입력해 주세요</caption>
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
				<div class="btn_in">
					<input type="submit" value="탈퇴하기" class="enroll_button3 btn_common_n1"
								onclick='return pwdCheck(this.form);' style="opacity: 1; cursor:pointer;"
								onmouseover="this.style.opacity='0.7'"
								onmouseout="this.style.opacity='1'"> 
					 <a href="${pageContext.servletContext.contextPath}/mypagefm.do"><input type="button" value="취소"  class="enroll_button3 btn_common_n1"
								onclick='return pwdCheck(this.form);' style="opacity: 1; cursor:pointer;"
								onmouseover="this.style.opacity='0.7'"
								onmouseout="this.style.opacity='1'"/>
					</a>
				</div>
			</form>
		</div>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>