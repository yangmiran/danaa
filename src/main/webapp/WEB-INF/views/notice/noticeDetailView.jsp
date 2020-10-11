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
					<p>미앤란소식</p>
					<p>MNR CLINIC NOTICE</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span> Home
					</a></li>
					<li><a href="#" title="병원소식">병원소식</a></li>
					<li><a href="nlist.do?page=1" title="미앤란소식">미앤란소식</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->

	<section id="container" class="qnaDetail">
		
		<div class="qnaDetail_box">
			<!-- plain_view -->
			<div class="plain_view">
				<div class="plain_view_title">
					<ul class="plain_view_title1">
						<li><h4>${notice.notice_title}</h4></li>
						<li>${ notice.notice_date }</li>
					</ul>
				</div>

				<!-- 첨부파일 있을때 -->
				
				<c:if test="${ notice.notice_file != null }">
				<div class="plain_view_con" align="center">
					<p align="center" style="text-align: center;">
						<img src="resources/nupfiles/${ notice.notice_refile }" >
						<br><br>
						${ notice.notice_content }
						</p>
				</div>
				</c:if>
				<!-- 첨부파일 없을때 (이미지아이콘이 나옴..) -->
				<c:if test="${ notice.notice_file == null }">
				<div class="plain_view_con" align="center">
					<p align="center" style="text-align: center;">
						${ notice.notice_content }
						</p>
				</div>
				</c:if>
				
				
				<div class="prevnext">
					<div class="prevlist">
						<c:url var="prevlist" value="ndetail.do">
							<c:param name="notice_no" value="${ prevNotice.notice_no }" />
						</c:url>
							<a href="${ prevlist }" id=link2 ><p>이전 글</p>
							<p>
								<c:if test="${ !empty prevNotice }">
								${ prevNotice.notice_title }
								</c:if>
								<c:if test="${ empty prevNotice }">
								이전글이 존재하지 않습니다
								<script>
								document.querySelector('#link2').addEventListener('click', function(e){
									e.preventDefault();
								});
									</script>
								</c:if>
							</p>
						</a>
					</div>
					
					
					<div class="nextlist">
							<c:url var="nextlist" value="ndetail.do">
								<c:param name="notice_no" value="${ nextNotice.notice_no }" />
							</c:url>
								<a href="${ nextlist }" id="link" ><p>다음글</p>
							<p>
								<c:if test="${ !empty nextNotice}">
									${ nextNotice.notice_title }
								</c:if>
								<c:if test="${ empty nextNotice}">
									다음글이 존재하지 않습니다
								<script>
									document.querySelector('#link').addEventListener('click', function(e){
										e.preventDefault();
									});
									</script>
								
								</c:if>
							
							</p></a>
						</a>
					</div>
				</div>

			</div>
			<!-- //plain_view -->


			<div class="detailbtn">
				<!-- 관리자 로그인시 -->
				<c:if test="${ !empty loginMember.id }">
					<c:choose>
						<c:when test="${ ((loginMember.id == 'admin11') or (loginMember.id == 'admin22')) or (loginMember.id == 'admin33') }">
							<a href="nlist.do?page=1" class="qna_btn btn_black">목록</a>
							<!-- 수정하기 s -->
							<c:url var="nUpView" value="nUpView.do">
								<c:param name="notice_no" value="${ notice.notice_no }" />
								<c:param name="currentPage" value="${ currentPage }" />
							</c:url>
							<a href="${ nUpView }" class="qna_btn btn_common">수정하기</a>
							<!-- 수정하기 e -->
							<!-- 삭제하기 s -->
							<c:url var="ndelete" value="ndelete.do">
								<c:param name="notice_no" value="${ notice.notice_no }" />
								<c:param name="notice_refile" value="${ notice.notice_refile }" />
								<c:param name="currentPage" value="${ currentPage }" />
							</c:url>
							<a href="${ ndelete }" class="qna_btn btn_white">글삭제</a>
							<!-- 삭제하기 e -->
						</c:when>
						<c:otherwise>
							<a href="nlist.do?page=1" class="qna_btn btn_black">목록</a>
						</c:otherwise>
					</c:choose>
				</c:if>
				<!-- 관리자 end -->
				
				<!-- 일반회원 및 비회원일때 -->
				<c:if test="${ empty loginMember.id }">
					<a href="nlist.do?page=1" class="qna_btn btn_common">목록</a>
				</c:if>
				<!-- 일반회원 및 비회원일때 end -->
			</div>
		</div>
		<br><br><br>
	</section>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>