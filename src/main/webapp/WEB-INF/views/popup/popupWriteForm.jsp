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
					<li>팝업관리</li>
					<li class="now" title="현재 위치">팝업 등록</li>
				</ol>
				<h2>팝업 등록</h2>
			</div>
			<!-- 타이틀:e -->
			<form action="pinsert.do" id="mallConfig" method="post" enctype="multipart/form-data">
			<input type="hidden" name="page" value=${ page }>
				<!-- pagecontent:s -->
				<section class="pagecontent">
					<div class="inn">
						<div class="section">
							<div class="mTitle">
								<h2>팝업등록</h2>
							</div>
							<div class="mTable gMedium">
								<table border="1" summary="">
									<caption>팝업등록</caption>
									<tbody>
										<tr>
											<th scope="row">팝업 제목<strong class="icoRequired">(필수)</strong></th>
												<td>
													<input type="text" name="popup_title" class="fText" style="width: 550px;">
												</td>
											<th scope="row">팝업 이미지<strong class="icoRequired">(필수)</strong></th>
												<td>
													<input type="file" name="pfile" placeholder="" class="fText" style="width: 550px;">
												</td>
											<th scope="row">노출여부<strong class="icoRequired">(필수)</strong></th>
											<td>
												<select class="input" name="popup_state" style="width: 265px;">
														<option value="0">노출여부를 선택해 주십시오</option>
														<option value="0">노출</option>
														<option value="1">미노출</option>
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
	       			<input type="submit" value="등록">
	       			<input type="reset" value="취소" onclick="javascript:history.go(-1); return false;">
	     		</div>
     		</form>
		</div> <!-- main-con:e -->
	</main>
</div>
</body>
</html>