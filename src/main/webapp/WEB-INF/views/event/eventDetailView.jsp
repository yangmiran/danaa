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

	<section id="container" class="qnaDetail">

		<div class="qnaDetail_box">
		
			<!-- plain_view -->
			<div class="plain_view">
				<div class="plain_view_title">
					<ul class="plain_view_title1">
						<li><h4>${event.event_title}</h4></li>
						<li>${ event.event_period }</li>
					</ul>
				</div>
					<!-- 내용부분 s -->
					<div class="plain_view_con" align="center">
						<p align="center" style="text-align: center;">
							<img src="resources/eupfiles/${ event.event_file }"> <br><br> 
							<!-- 텍스트 내용 있을경우 -->
							<c:if test ="${ event.event_content != null }">
								${ event.event_content }
							</c:if>
							<!-- 텍스트 내용 없을경우 -->
							<c:if test="${ event.event_content == null }" />
						</p>
					</div>
					<!-- 내용부분 e -->

					<!-- 이전글 -->
				<div class="prevnext">
					<div class="prevlist">
						<c:url var="eprevlist" value="edetail.do">
							<c:param name="event_no" value="${ prevEvent.event_no }" />
						</c:url>
						<a href="${ eprevlist }" id=link2><p>이전 글</p>
							<p>
								<c:if test="${ !empty prevEvent }">
								${ prevEvent.event_title }
							</c:if>
								<c:if test="${ empty prevEvent }">
								이전글이 존재하지 않습니다
									<script>
								document.querySelector('#link2').addEventListener('click', function(e){
									e.preventDefault();
								});
									</script>
							</c:if>
							</p> </a>
					</div>

					<!-- 다음글 -->
					<div class="nextlist">
						<c:url var="enextlist" value="edetail.do">
							<c:param name="event_no" value="${ nextEvent.event_no }" />
						</c:url>
						<a href="${ enextlist }" id="link"><p>다음글</p>
							<p>
								<c:if test="${ !empty nextEvent }">
								${ nextEvent.event_title }
							</c:if>
								<c:if test="${ empty nextEvent }">다음글이 존재하지 않습니다
									<script>
								document.querySelector('#link').addEventListener('click', function(e){
									e.preventDefault();
								});
									</script>
								</c:if>

							</p></a>
					</div>
				</div>

			</div>
			<!-- //plain_view -->


			<div class="detailbtn">
				<!-- 관리자 로그인시 -->
				<c:if test="${ !empty loginMember.id }">
					<c:choose>
						<c:when
							test="${ ((loginMember.id == 'admin11') or (loginMember.id == 'admin22')) or (loginMember.id == 'admin33') }">
							<a href="elist.do?page=1" class="qna_btn btn_black">목록</a>
							<!-- 수정하기 s -->
							<c:url var="eUpView" value="eUpView.do">
								<c:param name="event_no" value="${ event.event_no }" />
								<c:param name="currentPage" value="${ currentPage }" />
							</c:url>
							<a href="${ eUpView }" class="qna_btn btn_common">수정하기</a>
							<!-- 수정하기 e -->
							<!-- 삭제하기 s -->
							<c:url var="edelete" value="edelete.do">
								<c:param name="event_no" value="${ event.event_no }" />
								<c:param name="event_file" value="${ event.event_file }" />
								<c:param name="event_thumb" value="${ event.event_thumb }" />
								<c:param name="currentPage" value="${ currentPage }" />
							</c:url>
							<a href="${ edelete }" class="qna_btn btn_white">글삭제</a>
							<!-- 삭제하기 e -->
						</c:when>
						<c:otherwise>
							<a href="elist.do?page=1" class="qna_btn btn_common">목록</a>
						</c:otherwise>
					</c:choose>
				</c:if>
				<!-- 관리자 end -->

				<!-- 일반회원 및 비회원일때 -->
				<c:if test="${ empty loginMember.id }">
					<a href="elist.do?page=1" class="qna_btn btn_common">목록</a>
				</c:if>
				<!-- 일반회원 및 비회원일때 end -->
			</div>
		</div>
		<br><br><br>
	</section>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>