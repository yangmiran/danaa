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
	<section id="container" class="qnaDetail2">
		
		<div class="qnaDetail_box">
			<!-- plain_view -->
			<div class="plain_view">
				<div class="plain_view_title clear">
					<ul class="plain_view_title1">
						<li><h4>${qna.qna_title}</h4></li>
						<li style="font-size:21px">*이름: ${ qna.qna_name }</li>
						<li style="font-size:21px">*연락처: ${ qna.qna_phone }</li>
						<li style="font-size:21px">*문의종류: ${ qna.qna_kinds }</li>
					</ul>
					<p class="day">${ qna.qna_date }</p>
				</div>
				
				<!-- 첨부파일 있을때 -->
				<c:if test="${ qna.qna_file != null }">
				<div class="plain_view_con" align="center">
					<p align="center" style="text-align: center;">
						<img src="resources/qupfiles/${ qna.qna_refile }" >
						<br><br>
						${ qna.qna_content }
						</p>
				</div>
				</c:if>
				<!-- 첨부파일 없을때 (이미지아이콘이 나옴..) -->
				<c:if test="${ qna.qna_file == null }">
				<div class="plain_view_con" align="center">
					<p align="center" style="text-align: center;">
						${ qna.qna_content }
						</p>
				</div>
				</c:if>
				
			</div>
			
			<div class="detailbtn">
				<a href="qlist.do?page=1" class="qna_btn btn_black">목록</a>
				
				<!-- 관리자 로그인시 -->
				<!-- 로그인 됐을때 -->
				<c:if test="${ !empty loginMember }">
					<c:choose>
					
						<c:when	test="${ ((loginMember.id == 'admin11') or (loginMember.id == 'admin22')) or (loginMember.id == 'admin33') }">				
							
							<c:if test="${ refcount == 1 }">
							<c:url var="moveReply" value="moveReply.do">
               					<c:param name="qna_no" value="${ qna.qna_no }"/>
               					<c:param name="currentPage" value="${ currentPage }"/>
               					<c:param name="qna_pwd" value="${ qna.qna_pwd }" />
            				</c:url>
             					<a href="${ moveReply }" class="qna_btn btn_white">답글달기</a>
							</c:if>
							<c:if test="${ refcount != 1 }">
								&nbsp;
							</c:if>
						</c:when>
					
						<c:when	test="${ ((loginMember.id != 'admin11') or (loginMember.id != 'admin22')) or (loginMember.id != 'admin33') }" >
							<c:url var="qUpView" value="qUpView.do">
               					<c:param name="qna_no" value="${ qna.qna_no }"/>
               					<c:param name="currentPage" value="${ currentPage }"/>
            				</c:url>
             					<a href="${ qUpView }" class="qna_btn btn_common">수정하기</a>
						</c:when>
					</c:choose>
				</c:if>
				
				<!-- 로그인 안됐을때 -->
				<c:url var="qdel" value="qdelete.do">
              			<c:param name="qna_no" value="${ qna.qna_no }"/>
               			<c:param name="qna_refile" value="${ qna.qna_refile }"/>
               			<c:param name="currentPage" value="${ currentPage }"/>
            		</c:url>
            			<a href="${ qdel }" class="qna_btn btn_common">글삭제</a>
            			
				<c:if test="${ empty loginMember }" >
					<c:url var="qUpView" value="qUpView.do">
               			<c:param name="qna_no" value="${ qna.qna_no }"/>
               			<c:param name="currentPage" value="${ currentPage }"/>
            		</c:url>
             			<a href="${ qUpView }" class="qna_btn btn_white">수정하기</a>
				</c:if>
				<!-- 관리자 end -->
			
			</div>
		</div>
		<br><br><br>
	</section>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>