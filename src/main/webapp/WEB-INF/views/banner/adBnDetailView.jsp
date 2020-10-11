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
					<li>배너관리</li>
					<li class="now" title="현재 위치">배너 등록</li>
				</ol>
				<h2>배너 등록</h2>
			</div>
			<!-- 타이틀:e -->
			<form action="bnUpdate.do" id="mallConfig" method="post" enctype="multipart/form-data">
			<input type="hidden" name="bn_no" value=${ banner.bn_no }>
			<input type="hidden" name="page" value=${ page }>
			<input type="hidden" name="bn_file" value=${ banner.bn_file }>
			<input type="hidden" name="bn_refile" value=${ banner.bn_refile }>
				<!-- pagecontent:s -->
				<section class="pagecontent">
					<div class="inn">
						<div class="section">
							<div class="mTitle">
								<h2>배너등록</h2>
							</div>
							<div class="mTable gMedium">
								<table border="1" summary="">
									<caption>배너등록</caption>
									<tbody>
										<tr>
											<th scope="row">배너 제목 <strong class="icoRequired">(필수)</strong></th>
											<td>
												<input type="text" value="${ banner.bn_title }" name="bn_title" class="fText" style="width: 550px;">
											</td>
										</tr>
										<tr>
											<th scope="row">배너 이미지 <strong class="icoRequired">(필수) 1920 * 842</strong></th>
											<td>
												
												<input type="file" name="bfile"  class="fText" style="width: 550px;border: 0;" onchange="LoadImg(this);">
												<img src="resources/bupfiles/${ banner.bn_file }" id="file_img" style="display:block;width:200px">
											</td>
										</tr>
										<tr>
											<th scope="row">노출여부 <strong class="icoRequired">(필수)</strong></th>
											<td>
												<select class="input" name="bn_state" style="width: 550px;">
													<c:if test="${ banner.bn_state == 'Y'}">
														<option value="Y">노출여부를 선택해 주십시오</option>
														<option value="Y" selected="selected">노출</option>
														<option value="N">미노출</option>
													</c:if>
													<c:if test="${ banner.bn_state == 'N'}">
														<option value="Y">노출여부를 선택해 주십시오</option>
														<option value="Y">노출</option>
														<option value="N" selected="selected">미노출</option>
													</c:if>
												</select>
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
	       			
	       			<c:url var="bndelete" value="bndelete.do">
	       				<c:param name="bn_no" value="${ banner.bn_no }" />
	       				<c:param name="bn_file" value="${ banner.bn_file }" />
	       				<c:param name="bn_refile" value="${ banner.bn_refile }" />
	       				<c:param name="page" value="${ page }" />
	       			</c:url>
	       			<input type="button" onclick="javascript:location.href='${ bndelete }'" value="삭제">
	     		</div>
     		</form>
		</div> <!-- main-con:e -->
	</main>
</div>
</body>
</html>