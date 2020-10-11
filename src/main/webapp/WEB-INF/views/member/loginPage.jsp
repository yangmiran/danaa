<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
<script type="text/javascript">
/*아이디 쿠키에 적용하기*/

        $(document).ready(function(){
    var userInputId = getCookie("userInputId");//저장된 쿠기값 가져오기
    $("input[name='id']").val(userInputId); 
     
    if($("input[name='id']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩
                                           // 아이디 저장하기 체크되어있을 시,
        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 발생시
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
            var userInputId = $("input[name='id']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("userInputId");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("input[name='id']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $("input[name='id']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }
    });
});
 
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}

//14세미만 경고창 만들기

/* 
$(function(){
	$('.cp_naver').click(function(){
		alert("만 14세 미만일 경우에는 간편 회원으로 가입하실 수 없습니다/n 일반회원 가입으로 부탁드려요요요요요요요요요요");
		location.href='${nurl}';
	});
}); */

 
</script>

</head>

<body>

	<!-- header -->

	<c:import url="/WEB-INF/views/common/header.jsp" />
	<!-- subPageTop:s 서브페이지 상단 제목 공통-->
	<div class="subPageTop">
		<div class="sub">
			<div class="s_top_gp_wrap">
				<img src="resources/images/sub_top_login.jpg">
				<div class="title_wrap">
					<p>로그인</p>
					<p>MNR CLINIC LOGIN</p>
					<p>회원으로 가입하시면 더욱 다양한 컨텐츠 및 서비스를 받아보실 수 있습니다.</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span> Home
					</a></li>
					<li><a href="${ pageContext.servletContext.contextPath }/loginpage.do"" title="로그인">로그인</a></li>
					
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->

	<!--로그인 페이지  -->

		<!--section loginWrap:s-->
	<section id="loginWrap">
		<!--login-left:s-->
		<div class="login-left" >
			<form action="login.do" name="login" id="login" method="post">
				<fieldset class="login">
					<legend></legend>
					<ul class="loginCon">
						<li class="clearfix">
							<div class="text-form">
								<dl>
									<dt>
										<label for="id"><span class="ti-user"></span></label>
									</dt>
									<dd>
										<input type="text" name="id" id="id" placeholder="ID">
									</dd>
								</dl>
								<dl>
									<dt>
										<label for="password"><span class="ti-unlock"></span></label>
									</dt>
									<dd>
										<input type="password" name="pwd" id="password"
											placeholder="Password">
									</dd>
								</dl>
							</div>
							<!-- text-form --> <span class="loginBtn"><input
								type="submit" value="로그인" style="opacity:1; cursor:pointer;" 
						onmouseover="this.style.opacity='0.7'" 
						onmouseout="this.style.opacity='1'"></span>
							<div class="id_remember">
								<input type="checkbox" id="idSaveCheck"> 아이디 기억하기
							</div>
							<br>
						</li>
						<!--clearfix:e-->
						<li class="last">
							<div class="joinBox clearfix">
								<span>아직 회원이 아니신가요?</span> <a
									href="<c:url value='typepage.do'/>" style="opacity:1; cursor:pointer;" 
						onmouseover="this.style.opacity='0.7'" 
						onmouseout="this.style.opacity='1'">회원가입</a>
							</div>
							<div class="serchBox clearfix">
								<span>아이디/비밀번호를 분실하셨나요?</span> <a href="searchIdMove.do"
									onclick="window.open(this.href, '_blank', 'width=700, height=600, toolbars=no, scrollbars=yes'); return false;" style="opacity:1; cursor:pointer;" 
						onmouseover="this.style.opacity='0.7'" 
						onmouseout="this.style.opacity='1'">아이디
									/ 비밀번호 찾기</a>
								
							</div>
						</li>
						<!-- last:e -->

						<!--outLogWrap:s-->
						<li class="outLogWrap">
							<ul>

								<!-- <p>간편 로그인하기</p> -->

								<li class="outLog n">
									<!-- 네이버 로그인 창으로 이동 -->
									<div id="naver_id_login" class="naver_id_login" style="text-align: center">
										<a href="<c:url value='${nurl}'/>" class="cp_naver" > <span><img
												src="/danaa/resources/images/naver_logo.png" alt="네이버로고"></span>
											네이버로 로그인/회원가입
										</a>
										
									</div>
								</li>
								 <li class="outLog k">
								<!-- 카카오 로그인 창으로 이동 -->
								<div id="kakao_id_login" class="kakao_id_login" style="text-align: center">
								<a href="<c:url value='${kurl}'/>" class="cp"> <span><img
											src="/danaa/resources/images/kakao_logo.png" alt="카카오로고"></span>
										카카오톡 로그인/회원가입
								</a>
								</div>
								</li> 

								
							</ul>
						</li>
						<!--outLogWrap:e-->

					</ul>
					<!-- loginCon:e -->
					
				</fieldset>
			</form>
		</div>
		<!--login-left:e-->
<!-- <!--login-right:s-->
		<div class="login-right">
			<img src="/danaa/resources/images/login.jpg" alt="로그인이미지">
		</div>
		<!--  login-right:e -->
		
	</section>
	<!--section loginWrap:e-->




	<!-- footer -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>