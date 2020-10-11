<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>

<!-- 임시 비밀번호 전송 완료 페이지임 -->

<c:import url="/WEB-INF/views/common/meta.jsp" />
<script type="text/javascript"
	src="/danaa/resources/js/jquery-3.5.1.min.js">
	
</script>
<script type="text/javascript">

	//팝업창 닫기
	function close_popup() {
		window.close();
	}
	
</script>
</head>
<body>
<div id="find_id_allwrap">
	
	<div class="help_find" id="person_find">
		<div class="menu_box">
			<ul class="clear">
				<li class="off"><a
					href="${ pageContext.servletContext.contextPath }/searchIdMove.do"
					title="아이디 찾기" style="opacity: 1;"
					onmouseover="this.style.opacity='0.7'"
					onmouseout="this.style.opacity='1'">아이디 찾기</a></li>
				<li class="on"><a
					href="${ pageContext.servletContext.contextPath }/searchPwdMove.do"
					title="비밀번호 찾기" style="opacity: 1;"
					onmouseover="this.style.opacity='0.7'"
					onmouseout="this.style.opacity='1'">비밀번호 찾기</a></li>

			</ul>
		</div>
		<!-- menu_box:e -->


<div id="findpwd_email" >
		<div class="cont_find">		
				<fieldset class="find_idfd">
				<h1>임시 비밀번호가 발송 되었습니다<br>임시 비밀번호로 로그인해 주시기 바랍니다</h1><%--  ${email}로 <br> --%>
				
					<div class="wrap_link">
						<button type="button" class="btn_biggest_type01"
							id="btn_cert_complete" style="opacity: 1;"
							onmouseover="this.style.opacity='0.7'"
							onmouseout="this.style.opacity='1'" onclick="close_popup()">닫기</button>

					</div>
				</fieldset>		
		</div>

	</div>
	
	</div>
</div><!-- all wrap -->
</body>
</html>