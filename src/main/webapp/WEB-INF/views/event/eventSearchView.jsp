<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<c:import url="/WEB-INF/views/common/meta.jsp" />
</head>
<body>
		<c:import url="/WEB-INF/views/common/header.jsp" />

	<!-- subPageTop:s 서브페이지 상단 제목 공통-->
	<div class="subPageTop">
		<div class="sub">
			<div class="s_top_gp_wrap">
				<img src="resources/images/sub_top_04.jpg">
				<div class="title_wrap">
					<p>이벤트</p>
					<p>MNR CLINIC EVENT</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span> Home
					</a></li>
					<li><a href="#" title="병원소식">병원소식</a></li>
					<li><a href="elist.do?page=1" title="이벤트">EVENT</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->
<br><br><br>
	<section id="container" class="jmboard">
		
		<div class="sub_title board_title">
			<h3>미앤란EVENT</h3>
			<p>현재 진행중인 이벤트를 안내해드립니다.</p>
		</div>
		
		
		<div class="jmboard_box">
		
			<<div class="thumb_list">
				<ul class="thumb_tab thumb_tab3">
					<li class="on";=""><a href="elist.do?page=1">모든 이벤트</a></li>
					<li><a href="proEvent.do?page=1">진행중인 이벤트</a></li>
					<li><a href="endEvent.do?page=1">지난 이벤트</a></li>
				</ul>


				<ul class="thumb_list_con">
					<c:forEach items="${ requestScope.list }" var="e">
						<li><c:url var="edetail" value="edetail.do">
								<c:param name="event_no" value="${ e.event_no }" />
								<c:param name="currentPage" value="${ currentPage }" />
							</c:url> <a href="${ edetail }">
								<div class="thumb_list_img">
									<img src="resources/eupfiles/${ e.event_thumb }" alt="">
								</div>
								<div class="thumb_list_txt">
									<p class="thumb_list_title">${ e.event_title }</p>
									<p class="thumb_list_date">${ e.event_period }</p>
								</div>
						</a></li>
					</c:forEach>
				</ul>
			</div>
			<br>
			
		<!-- search -->
				<div class="write_btn_box" align="center">
			<form action="esearch.do" class="search">
				<input type="text" name="keyword" placeholder="제목을 입력하세요"	maxlength="20"> 
				<input type="submit" value="검색"	 class="jmboard_btn btn_white">
			</form>
				</div>
			<!-- //search -->
			
			<br><br>
		</div>
	</section>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>