<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<c:import url="/WEB-INF/views/common/meta.jsp" />

</head>
<body>
<div id="adwrap">
	<c:import url="/WEB-INF/views/common/adheader.jsp" />

	<main>
		<div class="main-con">
			<!-- 타이틀:s -->
			<div class="adtit">
				<ol>
					<li class="home">홈</li>
					<li>병원정보관리</li>
					<li class="now" title="현재 위치">의사관리</li>
				</ol>
				<h2>의사관리</h2>
			</div>
			<!-- 타이틀:e -->

			<!-- pagecontent:s -->
			<section class="pagecontent">
				<!-- inn:s -->
				<div class="inn">
				
					<div class="listTable">
						<table>
							<colgroup>
								<col style="width:10%">
								<col style="width:15%">
								<col style="width:30%">
								<col style="width:35%">
								<col style="*">
							</colgroup>
							<thead>
								<tr>
									<th>순서</th>
									<th></th>
									<th>의사 이름</th>
									<th>진료 요일</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${ requestScope.list }" var="doc">
								<tr>
									<td>${ doc.doc_no }</td>
									<td><img src="/danaa/resources/images/${ doc.doc_pic }"></td>
									<td>${ doc.doc_name }</td>
									<td>${ doc.doc_day }</td>
									<td class="mod">
										<c:url var="dp" value="/doctorDetail.do">
											<c:param name="doc_no" value="${ doc.doc_no }" />
										</c:url>
										<a href="${ dp }">수정하기</a>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
    			</div> <!-- inn:e -->
    		</section> <!-- pagecontent:e -->

		</div>
	</main>
</div>
</body>
</html>
