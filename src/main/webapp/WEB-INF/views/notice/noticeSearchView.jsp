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
	<br>
	<br>
	<br>

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
							<td class="num">${ n.notice_no }</td>

							<!-- title.s -->
							<td class="title"><c:url var="ndetail" value="ndetail.do">
									<c:param name="notice_no" value="${ n.notice_no }" />
									<c:param name="currentPage" value="${ currentPage }" />
								</c:url><a href="${ ndetail }">${ n.notice_title }</a> <!-- title.e -->
							<td class="name">${ n.notice_writer }</td>
							<td class="date"><fmt:formatDate value="${ n.notice_date }" /></td>
							<td class="item">${ n.notice_readcount }</td>
						</tr>
					</c:forEach>
					<!-- body.e -->
				</tbody>
			</table>
			<br> <br>
			
			<!-- search -->
				<div class="write_btn_box" align="center">
			<form action="nsearch.do" class="search">
				<input type="text" name="keyword" placeholder="제목을 입력하세요"	maxlength="20"> 
				<input type="submit" value="검색"	 class="jmboard_btn btn_white">
			</form>
				</div>
			<!-- //search -->
			
			<br>
			<br>
		</div>
	</section>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>