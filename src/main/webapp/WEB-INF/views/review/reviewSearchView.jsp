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
<script type="text/javascript">
	function showWriteForm() {
		location.href = "moveReviewWriteForm.do";
	}
</script>

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

	<section id="container" class="jmreview">
		<div class="reviewList">
			<div class="thumb_list">
				<ul class="thumb_list_con">
					<c:forEach items="${ list }" var="review">
						<li><a
							href="rdetail.do?review_no=${ review.review_no }&page=1"
							varStatus="status">
								<div class="thumb_list_img">
									<img src="resources/images/${ review.review_rename_filename }"
										alt="">
								</div>
								<div class="thumb_list_txt">
									<p class="thumb_list_title">${ review.review_title }</p>
								</div>
						</a></li>
					</c:forEach>
				</ul>
			</div>

			<div class="reviewlist_util">
				<a href="rlist.do?page=1"
					class="jmboard_btn btn_write reviewbtn_common">목록</a>
			</div>

			<!-- 제목으로 검색 -->
			<div class="reviewsearch1">
				<form
					action="${ pageContext.servletContext.contextPath }/rsearch.do"
					method="post" id="title" class="reviewsearch">
					<input type="hidden" name="action" value="title"
						maxlength="20"> <input
						type="search" name="keyword" placeholder="제목을 입력하세요" > <input type="submit"
						style="width: 100px; height: 50px" value="검색"
						class="jmboard_btn reviewbtn_black" >
				</form>
			</div>
</body>
</html>