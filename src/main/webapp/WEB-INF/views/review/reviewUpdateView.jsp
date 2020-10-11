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
</head>
<body>
<c:import url="/WEB-INF/views/common/meta.jsp" />
	<c:import url="/WEB-INF/views/common/header.jsp" />

	<!-- subPageTop:s 서브페이지 상단 제목 공통-->
	<div class="subPageTop">
		<div class="sub">
			<div class="s_top_gp_wrap">
				<img src="resources/images/sub_top_05.jpg">
				<div class="title_wrap">
					<p>진료후기</p>
					<p>MNR clinic Introduction</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span>Home
					</a></li>
					<li><a href="/" title="커뮤니티">커뮤니티</a></li>
					<li><a href="/" title="진료후기">진료후기</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->

</body>
</html>