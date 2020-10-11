<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<c:import url="/WEB-INF/views/common/meta.jsp" />
<style>
#footer {background-color: #f2f2f8;}
#footer .footer_in .cont {margin: 0px auto;padding: 50px 0;}
</style>
</head>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/views/common/header.jsp" />
		<!--container:s-->
		<div class="container">
			<!-- subPageTop:s 서브페이지 상단 제목 공통-->
			<div class="subPageTop">
				<div class="sub">
                   	<div class="s_top_gp_wrap">
                    	<img src="resources/images/sub_top_01.jpg">
                        <div class="title_wrap">
                           <p>병원소개</p>
                           <p>MNR clinic Introduction</p>
						</div>
					</div>
					<nav class="sub_navi">
						<ul>
							<li><a href="${ pageContext.servletContext.contextPath }/main.do" title="홈 바로가기"> <span class="ti-home"></span> Home</a></li>
							<li><a href="/" title="병원 소개">병원 소개</a></li>
						</ul>
					</nav>
                  </div>
			</div>
			<!-- subPageTop:e 서브페이지 상단 제목 공통-->
			
			<section id="introimg">
				<ul>
					<li><img src="resources/images/intro.jpg"></li>
					<li><img src="resources/images/intro3.png"></li>
					<li><img src="resources/images/intro2.jpg"></li>
				</ul>
			</section>
			<section id="staff">
				<article class="staff_wrap">
					
					<!--staff_list-->
					<ul class="staff_list">
						<li>
							<div class="item clear">
								<div class="img_box">
								<img src="/danaa/resources/images/${ d1.doc_pic }" alt="">
								</div>
								<div class="txt_box">
									<span class="branch">원장</span>
									<p class="name">${ d1.doc_name }</p>
								</div>
							</div>
							
							<!-- 예약하기 버튼-->
							<div class="more">
								<span><a href="moveRes.do">예약하기</a></span>
							</div>
							
							<!--staff_pop-->
							<div class="staff_pop">
								<div class="info_box">
									<!-- staff_time -->
									<div class="staff_time">									
										<table class="staff_time_table">
											<thead>
												<tr>
													<th>월요일</th>
													<th>화요일</th>
													<th>수요일</th>
													<th>목요일</th>
													<th>금요일</th>
												</tr>
											</thead>
											<tbody>		
												<c:forTokens items="${ d1.doc_day }" delims="," var="day">
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
												<tr>
													<td><label class="checkbox-wrap"><input type="checkbox" value="월" ${ checked0 }></label></td>
													<td><label class="checkbox-wrap"><input type="checkbox" value="화" ${ checked1 }></label></td>
													<td><label class="checkbox-wrap"><input type="checkbox" value="수" ${ checked2 }></label></td>
													<td><label class="checkbox-wrap"><input type="checkbox" value="목" ${ checked3 }></label></td>
													<td><label class="checkbox-wrap"><input type="checkbox" value="금" ${ checked4 }></label></td>
												</tr>
											
											</tbody>
										</table>
									</div>
									<!-- //staff_time -->
								</div>
							</div>
							<!--//staff_pop-->
						</li>
						
						<li>
							<div class="item clear">
								<div class="img_box">
								<img src="/danaa/resources/images/${ d2.doc_pic }" alt="">
								</div>
								<div class="txt_box">
									<span class="branch">원장</span>
									<p class="name">${ d2.doc_name }</p>
								</div>
							</div>
							
							<!-- 예약하기 버튼-->
							<div class="more">
								<span><a href="moveRes.do">예약하기</a></span>
							</div>
							
							<!--staff_pop-->
							<div class="staff_pop">
								<div class="info_box">
									<!-- staff_time -->
									<div class="staff_time">									
										<table class="staff_time_table">
											<thead>
												<tr>
													<th>월요일</th>
													<th>화요일</th>
													<th>수요일</th>
													<th>목요일</th>
													<th>금요일</th>
												</tr>
											</thead>
											<tbody>		
												<c:forTokens items="${ d2.doc_day }" delims="," var="day">
													<c:if test="${ day eq '월' }">
														<c:set var="checked04" value="checked" />
													</c:if>
													<c:if test="${ day eq '화' }">
														<c:set var="checked14" value="checked" />
													</c:if>
													<c:if test="${ day eq '수' }">
														<c:set var="checked24" value="checked" />
													</c:if>
													<c:if test="${ day eq '목' }">
														<c:set var="checked34" value="checked" />
													</c:if>
													<c:if test="${ day eq '금' }">
														<c:set var="checked44" value="checked" />
													</c:if>
												</c:forTokens>										
												<tr>
													<td><label><input type="checkbox" value="월" ${ checked04 }></label></td>
													<td><label><input type="checkbox" value="화" ${ checked14 }></label></td>
													<td><label><input type="checkbox" value="수" ${ checked24 }></label></td>
													<td><label><input type="checkbox" value="목" ${ checked34 }></label></td>
													<td><label><input type="checkbox" value="금" ${ checked44 }></label></td>
												</tr>
											</tbody>
										</table>
									</div>
									<!-- //staff_time -->
								</div>
							</div>
							<!--//staff_pop-->
						</li>
						
						<li>
							<div class="item clear">
								<div class="img_box">
								<img src="/danaa/resources/images/${ d3.doc_pic }" alt="">
								</div>
								<div class="txt_box">
									<span class="branch">원장</span>
									<p class="name">${ d3.doc_name }</p>
								</div>
							</div>
							
							<!-- 예약하기 버튼-->
							<div class="more">
								<span><a href="moveRes.do">예약하기</a></span>
							</div>
							
							<!--staff_pop-->
							<div class="staff_pop">
								<div class="info_box">
									<!-- staff_time -->
									<div class="staff_time">									
										<table class="staff_time_table">
											<thead>
												<tr>
													<th>월요일</th>
													<th>화요일</th>
													<th>수요일</th>
													<th>목요일</th>
													<th>금요일</th>
												</tr>
											</thead>
											<tbody>		
												<c:forTokens items="${ d3.doc_day }" delims="," var="day">
													<c:if test="${ day eq '월' }">
														<c:set var="checked05" value="checked" />
													</c:if>
													<c:if test="${ day eq '화' }">
														<c:set var="checked15" value="checked" />
													</c:if>
													<c:if test="${ day eq '수' }">
														<c:set var="checked25" value="checked" />
													</c:if>
													<c:if test="${ day eq '목' }">
														<c:set var="checked35" value="checked" />
													</c:if>
													<c:if test="${ day eq '금' }">
														<c:set var="checked45" value="checked" />
													</c:if>
												</c:forTokens>										
												<tr>
													<td><label><input type="checkbox" value="월" ${ checked05 }></label></td>
													<td><label><input type="checkbox" value="화" ${ checked15 }></label></td>
													<td><label><input type="checkbox" value="수" ${ checked25 }></label></td>
													<td><label><input type="checkbox" value="목" ${ checked35 }></label></td>
													<td><label><input type="checkbox" value="금" ${ checked45 }></label></td>
												</tr>
											</tbody>
										</table>
									</div>
									<!-- //staff_time -->
								</div>
							</div>
							<!--//staff_pop-->
						</li>
						
					</ul>
					<!--//staff_list-->
			
				</article>
			</section>
		</div>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>