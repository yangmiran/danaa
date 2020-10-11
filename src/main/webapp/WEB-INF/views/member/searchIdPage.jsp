<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>

<!-- 아이디 찾기 페이지 -->


<c:import url="/WEB-INF/views/common/meta.jsp" />
<script type="text/javascript"
	src="/danaa/resources/js/jquery-3.5.1.min.js">
	
</script>
<script type="text/javascript">

//이메일로찾기, 휴대폰으로 찾기 창 변화
function search_check(num) {
	if (num == '1') {
		document.getElementById("findid_email").style.display = "none";
		document.getElementById("findid_phone").style.display = "";	
	} else {
		document.getElementById("findid_phone").style.display = "none";
		document.getElementById("findid_email").style.display = "";
	}
}

	//팝업창 닫기
	function close_popup() {
		window.close();
	}
</script>
</head>
<body>

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


	
<!-- 이메일로 찾기:s -->
<div id="findid_email" >
	<ul class="tab_find">
			<li class="on" class="custom-control-input" id="find_cell" onclick="search_check(2);" checked><a
				href="#" class="link_find" >이메일로 찾기</a></li>
			<li class="off" class="custom-control-input" id="find_cell" onclick="search_check(1);"><a
				href="#" class="link_find">휴대폰번호로 찾기</a></li>

		</ul>
		<div class="cont_find">
			<form action="chkidinfo.do" method="post" id="find_form">
				<fieldset class="find_idfd">
					<p class="desc_find">회원정보에 등록된 정보로 아이디를 찾을 수 있습니다.</p>
					<ul class="list_find">
						<li>
							<div class="wrap_lab">
								<label for="name" class="lab_find">이름</label>
							</div>
							<div class="wrap_input">
								<span class="box_input"> <input type="text" name="name"
									id="name" class="inp_find">
								</span>
							</div>
						</li>

						<li id="li_cell">
							<div class="wrap_lab">
								<label for="cell" class="lab_find">이메일</label>
							</div>
							 <div class="wrap_input">
								<span class="box_input"> <input type="text" name="email"
									id="cell" class="inp_find" placeholder="‘@’뒤까지 모두 입력">
								</span>
							
							</div>
						</li>
						
						
					</ul>


					<div class="wrap_link">
						<button type="submit" class="btn_biggest_type01"
							id="btn_cert_complete" style="opacity: 1;"
							onmouseover="this.style.opacity='0.7'"
							onmouseout="this.style.opacity='1'" value="아이디 찾기">아이디 찾기</button>
						<button type="button" class="btn_biggest_type01"
							id="btn_cert_complete" style="opacity: 1;"
							onmouseover="this.style.opacity='0.7'"
							onmouseout="this.style.opacity='1'" onclick="close_popup()">닫기</button>

					</div>

				</fieldset>
			</form>
		</div>
	</div>
<!-- 이메일로 찾기:e -->

<!-- 휴대폰번호로 찾기 :s-->
<div id="findid_phone" style="display: none">
		<ul class="tab_find">
			<li class="off" class="custom-control-input" id="find_cell" onclick="search_check(2);" ><a
				href="#" class="link_find" >이메일로 찾기</a></li>
			<li class="on" class="custom-control-input" id="find_cell" onclick="search_check(1);" checked><a
				href="#" class="link_find">휴대폰번호로 찾기</a></li>

		</ul>
		<div class="cont_find">
			<form action="chkidphinfo.do" method="post" id="find_form">
				<fieldset class="find_idfd">
					<p class="desc_find">회원정보에 등록된 정보로 아이디를 찾을 수 있습니다.</p>
					<ul class="list_find">
						<li>
							<div class="wrap_lab">
								<label for="name" class="lab_find">이름</label>
							</div>
							<div class="wrap_input">
								<span class="box_input"> <input type="text" name="name"
									id="name" class="inp_find">
								</span>
							</div>
						</li>

						<li id="li_cell">
							<div class="wrap_lab">
								<label for="cell" class="lab_find">휴대폰 번호</label>
							</div>
							 <div class="wrap_input">
								<span class="box_input"> <input type="text" name="phone"
									id="phone" class="inp_find" placeholder="'-'없이 입력해주세요">
								</span>
							
							</div>
						</li>
						
						
					</ul>


					<div class="wrap_link">
						<button type="submit" class="btn_biggest_type01"
							id="btn_cert_complete" style="opacity: 1;"
							onmouseover="this.style.opacity='0.7'"
							onmouseout="this.style.opacity='1'" value="아이디 찾기">아이디 찾기</button>
						<button type="button" class="btn_biggest_type01"
							id="btn_cert_complete" style="opacity: 1;"
							onmouseover="this.style.opacity='0.7'"
							onmouseout="this.style.opacity='1'" onclick="close_popup()">닫기</button>

					</div>

				</fieldset>
			</form>
		</div>
	</div>
<!-- 휴대폰번호로 찾기 :e-->
	</div>

</body>
</html>