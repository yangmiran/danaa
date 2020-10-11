<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<!-- main-con:s -->
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
				<div class="inn">
					<div class="section">
						<div class="mTitle">
							<h2>의사관리</h2>
						</div>
						<div class="mTable gMedium">
							<table border="1" summary="">
								<caption>의사관리</caption>
								<tbody>
									<tr>
										<th scope="row">의사 이름</th>
										<td>${ doctor.doc_name }</td>
									</tr>
									<tr>
										<th scope="row">의사 사진</th>
										<td>
											<img src="resources/images/${ doctor.doc_pic }" style="display:block;width:200px">
										</td>
									</tr>
									<tr>
										<th scope="row">진료 요일</th>
										<td>${ doctor.doc_day }</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</section> <!-- pagecontent:e -->
				
			<!-- 버튼 공통 -->
			<div class="input-btn">      
       			<input type="button" onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/doctorUpview.do?doc_no=${ doctor.doc_no }'" value="수정하기">
       			<input type="button" onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/doctor.do'" value="목록">
     		</div>
		</div> <!-- main-con:e -->
	</main>
</div>
</body>
</html>