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

<!--맨 밑 footer만 보이게 설정-->
<style type="text/css">
#footer .footer_in .cont {
	display: none;
}

#reviewsearch1 {
	padding: 20px;
	margin: 20px;
}
</style>

<!-- 페이지 이동 -->
<script type="text/javascript">
	function showWriteForm() {
		location.href = "moveReviewWriteForm.do";
	}
</script>


</head>
<body>
	<!-- 헤더 -->
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


	<!-- 리스트 -->
	<section id="container" class="jmreview">
		<div class="reviewList">
			<div class="thumb_list">
				<ul class="thumb_list_con clear">
					<c:forEach items="${ list }" var="review">
						<li><a
							href="rdetail.do?review_no=${ review.review_no }&page=${ currentPage }"
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
		</div>
	</section>

	<!-- 페이징 -->
	<!-- 맨처음 -->
	<div class="reviewlist_util">
		<div class="paging">

			<c:if test="${ currentPage <= 1 }">
				<a href="" id="first" class="first paging_arrow">《</a>
			</c:if>
			<c:if test="${ currentPage > 1 }">
				<c:url var="rbl" value="rlist.do">
					<c:param name="page" value="1" />
				</c:url>
				<a href="${ rbl }" id="first">《</a>
			</c:if>

			<!-- 이전그룹 -->
			<c:if
				test="${ (currentPage -10) < startPage && (currentPage -10) > 1}">
				<c:url var="rbl2" value="rlist.do">
					<c:param name="page" value="${ startPage -10 }" />
				</c:url>
				<a href="${ rbl2 }">〈</a>
			</c:if>
			<c:if
				test="${ !((currentPage -10) < startPage && (currentPage -10) > 1) }">
	〈
	</c:if>

			<!-- 현재페이지가 속한 페이지그룹의 숫자 출력 처리 -->
			<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
				<c:if test="${ p eq currentPage }">
					<font color="red" size="4"><b>[${ p }]</b></font>
				</c:if>
				<c:if test="${ p ne currentPage }">
					<c:url var="rbl3" value="rlist.do">
						<c:param name="page" value="${ p }" />
					</c:url>
					<a href="${ rbl3 }">${ p }</a>
				</c:if>
			</c:forEach>

			<!-- 다음 그룹 -->
			<c:if
				test="${ (currentPage +10) > endPage && (currentPage +10) < maxPage }">
				<c:url var="rbl4" value="rlist.do">
					<c:param name="page" value="${ endPage +10 }" />
				</c:url>
				<a href="${ rbl4 }">></a>
			</c:if>
			<c:if
				test="${ !((currentPage +10) > endPage && (currentPage +10) < maxPage) }">
	>
	</c:if>

			<!-- 맨끝 -->
			<c:if test="${ currentPage >= maxPage }">
				<a href=" " id="last">》</a>
			</c:if>
			<c:if test="${ currentPage < maxPage }">
				<c:url var="rbl5" value="rlist.do">
					<c:param name="page" value="${ maxPage }" />
				</c:url>
				<a href=" ${ rbl5 }" id="last">》</a>
			</c:if>

			<!-- 글쓰기 -->
			<a href="reviewWriteForm.do"
				class="jmboard_btn btn_write reviewbtn_common" style="width: 100px;">글쓰기</a>
		</div>
	</div>

	<script>
		$(function() {
			$('#first').click(function() {
				if (alert("첫번째페이지입니다")) {
				}
			});
		});
		$(function() {
			$('#last').click(function() {
				if (alert("마지막페이지입니다")) {
				}
			});
		});
	</script>
	<br>

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
	<br>
	<br>
	<c:import url="/WEB-INF/views/common/footer.jsp" />




</body>

</html>