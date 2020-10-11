<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<br><br><br>

<section id="container" class="jmboard">
		
	<div class="sub_title board_title">
		<h3>미앤란소식</h3>
		<p>미앤란의 새로운소식을 확인해보세요</p>
	</div>
		<div class="jmboard_box">

			<!-- plain_list -->
			<table class="plain_list">
				<!-- head -->
				<tbody>
					<tr class="head">
						<th class="num">번호</th>
						<th class="title">제목</th>
						<th class="name">작성자</th>
						<th class="date">날짜</th>
						<th class="item">조회수</th>
					</tr>
					<!-- //head -->

					<!-- body.s -->
					<c:forEach items="${ requestScope.list }" var="n">
						<tr>
							<c:if test="${ n.notice_no == 16 }">
								<td class="num" style="color:red"><b>공지사항</b></td>
							</c:if>
							<c:if test="${ n.notice_no != 16 }">
								<td class="num">${ n.notice_no }</td>
							</c:if>
							<!-- title.s -->
							<td class="title">
								<c:url var="ndetail" value="ndetail.do">
									<c:param name="notice_no" value="${ n.notice_no }" />
									<c:param name="currentPage" value="${ currentPage }" />
								</c:url>
									<a href="${ ndetail }">${ n.notice_title }</a>
							</td>
							<!-- title.e -->
							<td class="name">${ n.notice_writer }</td>
							<td class="date"><fmt:formatDate value="${ n.notice_date }" /></td>
							<td class="item">${ n.notice_readcount }</td>
						</tr>
					</c:forEach>
					<!-- body.e -->
				</tbody>
			</table>

			<br>
			<!-- 페이징 처리 -->
			<div style="text-align: center;">
				<c:if test="${ currentPage <= 1 }">
         [맨처음]&nbsp;
      </c:if>
				<c:if test="${ currentPage > 1 }">
					<c:url var="ubl" value="nlist.do">
						<c:param name="page" value="1" />
					</c:url>
					<a href="${ ubl }">[맨처음]</a>
				</c:if>

				<!-- 이전 그룹으로 이동 처리 -->
				<c:if
					test="${ (currentPage - 10) < startPage && (currentPage - 10) > 1 }">
					<c:url var="ubl2" value="nlist.do">
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
						<c:url var="ubl3" value="nlist.do">
							<c:param name="page" value="${ p }" />
						</c:url>
						<a href="${ ubl3 }">${ p }</a>
					</c:if>
				</c:forEach>

				<!-- 다음 그룹으로 이동 처리 -->
				<c:if
					test="${ (currentPage + 10) > endPage && (currentPage + 10) < maxPage }">
					<c:url var="ubl4" value="nlist.do">
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
					<c:url var="ubl5" value="nlist.do">
						<c:param name="page" value="${ maxPage }" />
					</c:url>
					<a href="${ ubl5 }">[맨끝]</a>
				</c:if>
			
			<div class="list_util">
				<c:if test="${ !empty loginMember.id }">
					<c:choose>
						<c:when
							test="${ ((loginMember.id == 'admin11') or (loginMember.id == 'admin22')) or (loginMember.id == 'admin33') }">
							<a href="moveNwrite.do" class="qnaw_btn btn_common">글쓰기</a>
						</c:when>
						<c:otherwise>
					&nbsp;
				</c:otherwise>
					</c:choose>
				</c:if>
			</div>
		</div>
		<br>
		
			<!-- search -->
				<div class="write_btn_box" align="center">
			<form action="nsearch.do" class="search">
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