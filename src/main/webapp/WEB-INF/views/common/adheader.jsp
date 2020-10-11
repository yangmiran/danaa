<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<header id="adheader">
	<div class="header-con clear">
		<h1><a class="logo" href="${ pageContext.servletContext.contextPath }/moveAdmain.do">MNR CLINIC</a></h1>
		<ul>
			<li><a href="logout.do">로그아웃</a></li>
			<li><a href="${ pageContext.servletContext.contextPath }/main.do">홈으로가기</a></li>
			<li><span class="ti-user"></span> 대표운영자님</li>
		</ul>
	</div>
</header>

<div class="admenu">
	<ul class="admenu-con">
		<li class="adsub"><span>병원정보관리</span>
			<ul class="adsub-menu">
				<li><a href="${ pageContext.servletContext.contextPath }/moveAdinfo.do">병원정보관리</a></li>
				<li><a href="${ pageContext.servletContext.contextPath }/doctor.do">의사관리</a></li>
			</ul>
		</li>
		<li><a href="${ pageContext.servletContext.contextPath }/mlist.do?page=1">고객관리</a></li>
		<li class="adsub"><span>예약관리</span>
			<ul class="adsub-menu">
				<li><a href="adcheckRes.do">예약확인</a></li>
				<li><a href="disableRes.do">예약비활성화</a></li>
			</ul>
		</li>
		<li><a href="${ pageContext.servletContext.contextPath }/adBnList.do?page=1">배너관리</a></li>
		<li><a href="${ pageContext.servletContext.contextPath }/plist.do?page=1">팝업관리</a></li>
	</ul>
</div>

<script>
$(document).ready(function() {
	
	var itemli = $('.admenu-con > li.adsub');
	
	itemli.click(function () {
		$(this).addClass('adon');
		$(this).find('.adsub-menu').slideDown();
		
		itemli.not($(this)).removeClass('adon');
		itemli.not($(this)).find('.adsub-menu').slideUp();
	});

})
</script>