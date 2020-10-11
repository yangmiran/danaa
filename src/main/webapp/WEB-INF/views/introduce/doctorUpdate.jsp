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
<script>
	function LoadImg(value){
		if(value.files && value.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				$('#file_img').attr("src", e.target.result);
			}
			reader.readAsDataURL(value.files[0]);
		}
	}
</script>
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
			<form action="doctorUpdate.do" id="mallConfig" method="post" enctype="multipart/form-data">
				<input type="hidden" name="doc_no" value="${ doctor.doc_no }">
				<input type="hidden" name="doc_pic" value="${ doctor.doc_pic }">
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
											<td><input type="text" value="${ doctor.doc_name }" name="doc_name" class="fText" style="width: 550px;"></td>
										</tr>
										<tr>
											<th scope="row">의사 사진 <strong class="icoRequired">(필수)</strong></th>
											<td>
												<input type="file" name="upfile" class="fText" value="${ doctor.doc_pic }" style="width: 550px;border: 0;" onchange="LoadImg(this);">
												<img src="resources/images/${ doctor.doc_pic }" id="file_img" style="display:block;width:200px">
											</td>
										</tr>
										<tr>
											<th scope="row">진료 요일 <strong class="icoRequired">(필수)</strong></th>
											<td>
												<c:forTokens items="${ requestScope.doctor.doc_day }" delims=","  var="day">
													<c:if test="${ day eq '월' }">
														<c:set var="checked0" value="checked" />
													</c:if>
													<c:if test="${ day eq '화' }">
														<c:set var="checked1" value="checked" />
													</c:if>
													<c:if test="${ day eq '수' }">
														<c:set var="checked2" value="checked" />
													</c:if>
													<c:if test="${ day eq '목' }">
														<c:set var="checked3" value="checked" />
													</c:if>
													<c:if test="${ day eq '금' }">
														<c:set var="checked4" value="checked" />
													</c:if>
												</c:forTokens>
												
												<table width="350">
													<tr>
														<td><label><input type="checkbox" name="doc_day" value="월" ${ checked0 }> 월요일</label></td>
														<td><label><input type="checkbox" name="doc_day" value="화" ${ checked1 }> 화요일</label></td>
														<td><label><input type="checkbox" name="doc_day" value="수" ${ checked2 }> 수요일</label></td>
														<td><label><input type="checkbox" name="doc_day" value="목" ${ checked3 }> 목요일</label></td>
														<td><label><input type="checkbox" name="doc_day" value="금" ${ checked4 }> 금요일</label></td>
													</tr>
												</table>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</section> <!-- pagecontent:e -->
				
				<!-- 버튼 공통 -->
				<div class="input-btn">      
	       			<input type="submit" value="수정">
	       			<input type="button" onclick="javascript:location.href='${ bndelete }'" value="취소">
	     		</div>
     		</form>
		</div> <!-- main-con:e -->
	</main>
</div>
</body>
</html>