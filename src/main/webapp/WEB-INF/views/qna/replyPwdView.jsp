<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<style type="text/css">
#footer .footer_in .cont {
	display: none;
}
</style>
<script type="text/javascript">
function checkz() {
	var pw= RegExp(/^[0-9]{4,8}$/);
	
//비밀번호
	if(!pw.test($("#pw").val())) {
	alert("형식에 맞춰서 비밀번호를 입력해 주세요");
	$("#pw").val("");
	$("#pw").focus();
	return false;
	}
}
</script>
<c:import url="/WEB-INF/views/common/meta.jsp" />
</head>
<body>
<c:import url="/WEB-INF/views/common/header.jsp" />
	<!-- subPageTop:s 서브페이지 상단 제목 공통-->
	<div class="subPageTop">
		<div class="sub">
			<div class="s_top_gp_wrap">
				<img src="resources/images/sub_top_05.jpg">
				<div class="title_wrap">
					<p>문의하기</p>
					<p>MNR CLINIC QUESTION</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span> Home
					</a></li>
					<li><a href="#" title="커뮤니티">커뮤니티</a></li>
					<li><a href="qlist.do?page=1" title="문의하기">문의하기</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->
<div id="rrwrap" align="center" style="padding: 50px 0;">
<section id="ssWrap">
		<!-- auth_form -->
		<form class="auth_form" method="post" action="rPwdCheck.do" onsubmit="return checkz();">
			<input type="hidden" name ="qna_no" value="${ requestScope.qna_no }">
			<input type="hidden" name ="currentPage" value="${ requestScope.currentPage }">
			<div class="auth_title">
				<h4>PASSWORD CHECK</h4>
				<p style="color:red">글 작성시 사용하신 비밀번호를 입력해주세요.</p>
			</div>
	<br><br>

<div class="write_btn_box" align="center">
<input type="password" name ="checkpwd" class="search" maxlength="8" id="pw" placeholder="  비밀번호 숫자 4~8자리">
<input type ="submit" value="확인" class="jmboard_btn btn_common">
<br><br><br><br>
</div>
</form>
<!-- //auth_form -->
</section>
</div>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>