<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<c:set var="id" value="${id}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>

<!-- 찾은 아이디 출력 페이지임  -->

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
				<li class="on"><a
					href="${ pageContext.servletContext.contextPath }/searchIdMove.do"
					title="아이디 찾기" style="opacity: 1;"
					onmouseover="this.style.opacity='0.7'"
					onmouseout="this.style.opacity='1'">아이디 찾기</a></li>
				<li class="off"><a
					href="${ pageContext.servletContext.contextPath }/searchPwdMove.do"
					title="비밀번호 찾기" style="opacity: 1;"
					onmouseover="this.style.opacity='0.7'"
					onmouseout="this.style.opacity='1'">비밀번호 찾기</a></li>

			</ul>
		</div> 
		<!-- menu_box:e -->

		<!-- <ul class="tab_find">
			<li class="on" class="custom-control-input" id="find_cell" onclick="search_check(2);" checked><a
				href="#" class="link_find">이메일로 찾기</a></li>
			<li class="on" class="custom-control-input" id="find_cell" onclick="search_check(1);"><a
				href="#" class="link_find">휴대폰번호로 찾기</a></li>
		</ul> -->


<div id="findid_email" >
		<div class="cont_find">
			
				<fieldset class="find_idfd">
				<h1>찾으시는 아이디는 ${id} 입니다</h1>
				
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