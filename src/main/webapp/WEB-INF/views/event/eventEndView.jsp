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
			<p>현재 마감된 이벤트를 안내해드립니다.</p>
		</div>


		<div class="jmboard_box">


			<div class="thumb_list">
				<ul class="thumb_tab thumb_tab3">
					<li class="on"><a href="elist.do?page=1">모든 이벤트</a></li>
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
									<c:if test="${ e.event_state == 'N' }">
										<div class="thumb_list_cover">
											<p>
												이벤트가<br>종료 되었습니다.
											</p>
										</div>
									</c:if>
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
			<!-- 페이징 처리 -->
			<div style="text-align: center;">
				<c:if test="${ currentPage <= 1 }">
         [맨처음]&nbsp;
      </c:if>
				<c:if test="${ currentPage > 1 }">
					<c:url var="ubl" value="endEvent.do">
						<c:param name="page" value="1" />
					</c:url>
					<a href="${ ubl }">[맨처음]</a>
				</c:if>

				<!-- 이전 그룹으로 이동 처리 -->
				<c:if
					test="${ (currentPage - 10) < startPage && (currentPage - 10) > 1 }">
					<c:url var="ubl2" value="endEvent.do">
						<c:param name="page" value="${ startPage - 10 }" />
					</c:url>
					<a href="${ ubl2 }">[이전그룹]</a>
				</c:if>
				<c:if
					test="${ !((currentPage - 10) < startPage && (currentPage - 10) > 1) }">
         [이전그룹]&nbsp;
      </c:if>

				<!-- 현재 페이지가 속한 페이지그룹의 숫자 출력 처리 -->
				<c:forEach var="p" begin="${ startPage }" end="${ endPage }"
					step="1">
					<c:if test="${ p eq currentPage }">
						<font color="red" size="4"><b>[${ p }]</b></font>
					</c:if>
					<c:if test="${ p ne currentPage }">
						<c:url var="ubl3" value="endEvent.do">
							<c:param name="page" value="${ p }" />
						</c:url>
						<a href="${ ubl3 }">${ p }</a>
					</c:if>
				</c:forEach>

				<!-- 다음 그룹으로 이동 처리 -->
				<c:if
					test="${ (currentPage + 10) > endPage && (currentPage + 10) < maxPage }">
					<c:url var="ubl4" value="endEvent.do">
						<c:param name="page" value="${ endPage + 10 }" />
					</c:url>
					<a href="${ ubl4 }">[다음그룹]</a>
				</c:if>
				<c:if
					test="${ !((currentPage + 10) > endPage && (currentPage + 10) < maxPage) }">
         [다음그룹]&nbsp;
      </c:if>

				<c:if test="${ currentPage >= maxPage }">
         [맨끝]&nbsp;
      </c:if>
				<c:if test="${ currentPage < maxPage }">
					<c:url var="ubl5" value="endEvent.do">
						<c:param name="page" value="${ maxPage }" />
					</c:url>
					<a href="${ ubl5 }">[맨끝]</a>
				</c:if>
			</div>
			<br>
			<!-- 페이징 끝 -->
			
			<!-- 관리자계정 글쓰기 활성화 -->
			<div class="write_btn_box" align="center">
				<c:if test="${ !empty loginMember.id }">
					<c:choose>
						<c:when
							test="${ ((loginMember.id == 'admin11') or (loginMember.id == 'admin22')) or (loginMember.id == 'admin33') }">
							<a href="moveEwrite.do" class="qnaw_btn btn_common">글쓰기</a>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</c:if>
			</div>
			<!-- 관리자계정 글쓰기 활성화 끝 -->
			
			<!-- search -->
				<div class="write_btn_box" align="center">
			<form action="esearch.do" class="search">
				<input type="text" name="keyword" placeholder="제목을 입력하세요"	maxlength="20"> 
				<input type="submit" value="검색"	 class="jmboard_btn btn_white">
			</form>
				</div>
			<!-- //search -->
			
			<br>
		</div>
	</section>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>