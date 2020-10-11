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
<!-- 다음주소 api -->
<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	function openAddress() {
		//id값 변경
		$('#admin_addr:nth-child(1)').attr('id','zonecode');
		$('#admin_addr:nth-child(2)').attr('id','address');
		$('#admin_addr:nth-child(3)').attr('id','address_etc');
		new daum.Postcode({
			oncomplete:function(data) {
				jQuery("#zonecode").val(data.zonecode);
				jQuery("#address").val(data.address);
				jQuery("#address_etc").focus();
				console.log(data);
			}
		}).open();
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
					<li class="now" title="현재 위치">병원정보관리</li>
				</ol>
				<h2>관리자 정보관리</h2>
			</div>
			<!-- 타이틀:e -->
			<form action="adupdate.do" id="mallConfig" method="post">
				<!-- pagecontent:s -->
				<section class="pagecontent">
					<!-- inn:s -->
					<div class="inn">
						<div class="section">
							<div class="mTitle">
								<h2>기본정보</h2>
							</div>
							<div class="mTable gMedium">
								<table border="1" summary="">
									<caption>기본정보</caption>
									<tbody>
										<tr>
											<th scope="row">사이트명 <strong class="icoRequired">(필수)</strong></th>
											<td>
												<span class="mFormRequired">
												<input type="text" name="admin_name" value="${ admin.admin_name }"
														required="required" placeholder="" class="fText"
														style="width: 233px;" data-wrapped="true">
												</span>
											</td>
											<th scope="row">관리자명 <strong class="icoRequired">(필수)</strong></th>
											<td>
												<span class="mFormRequired">
												<input type="text" name="admin_person" value="${ admin.admin_person }"
													required="required" placeholder="" class="fText"
													style="width: 233px;" data-wrapped="true"></span>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div> <!-- inn:e -->
				</section> <!-- pagecontent:e -->
				
				<!-- pagecontent:s -->
				<section class="pagecontent">
					<div class="inn">
						<div class="section">
							<div class="mTitle">
								<h2>사업자정보</h2>
							</div>
							<div class="mTable gMedium">
								<table border="1" summary="">
									<caption>사업자정보</caption>
									<tbody>
										<tr>
											<th scope="row">대표전화 <strong class="icoRequired">(필수)</strong></th>
											<td>
												<span class="mFormRequired">
													<input
													type="text" name="admin_tel" value="${ admin.admin_tel }"
													required="required" class="fText" style="width: 198px;"
													data-wrapped="true">
												</span>
											</td>
											<th scope="row">팩스번호 <strong class="icoRequired">(필수)</strong></th>
											<td><span class="mFormRequired"><input
													type="text" name="admin_fax"
													value="${ admin.admin_fax }" required="required"
													class="fText" style="width: 198px;" data-wrapped="true"></span></td>
										</tr>
										<tr>
											<th scope="row">사업장주소 <strong class="icoRequired">(필수)</strong></th>
											<td colspan="3">
												<div class="gSingle" id="ec-smartmode-setting-store-addr1">
													<span class="mFormRequired">
														<c:forTokens var="add" items="${ admin.admin_add }" delims=",">
															<input type="text" name="admin_add" id="admin_addr" value="${ add }" class="fText">
														</c:forTokens>
													</span>
													<a href="#none" onClick="openAddress();" id="addSerch" class="btnNormal">
														<span>주소검색<em class="icoLink"></em></span>
													</a>
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row">사업자등록번호</th>
											<td><input type="text" name="admin_no"
												value="${ admin.admin_no }" class="fText" style="width: 198px;"></td>
											<th scope="row">진료시간</th>
											<td><input type="text" name="admin_time"
												value="${ admin.admin_time }" class="fText" style="width: 303px;">
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
	       			<input type="reset" value="취소">
	     		</div>
     		</form>
		</div> <!-- main-con:e -->
	</main>
</div>
</body>
</html>