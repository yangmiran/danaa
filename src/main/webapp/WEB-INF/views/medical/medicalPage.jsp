<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${requestScope['javax.servlet.forward.query_string']}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<c:import url="/WEB-INF/views/common/meta.jsp" />
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
                    	<img src="resources/images/sub_top_02.jpg">
                        <div class="title_wrap">
                           <p>진료과목</p>
                           <p>MNR clinic Medical</p>
						</div>
					</div>
					<nav class="sub_navi">
						<ul>
							<li><a href="${ pageContext.servletContext.contextPath }/main.do" title="홈 바로가기"> <span class="ti-home"></span> Home</a></li>
							<li><a href="${ pageContext.servletContext.contextPath }/serchPage.do" title="병원 소개">진료과목</a></li>
							<%-- <li>${ medical.md_name }</li> --%>
							<c:if test="${ path eq 'mdlist=11111' }">
								<li><a href="#"><c:out value="색소레이저" /></a></li>
							</c:if>
							<c:if test="${ path eq 'mdlist=11112' }">
								<li><a href="#"><c:out value="기미레이저" /></a></li>
							</c:if>
							<c:if test="${ path eq 'mdlist=22211' }">
								<li><a href="#"><c:out value="바디보톡스" /></a></li>
							</c:if>
							<c:if test="${ path eq 'mdlist=22212' }">
								<li><a href="#"><c:out value="특수부위보톡스" /></a></li>
							</c:if>
							<c:if test="${ path eq 'mdlist=22213' }">
								<li><a href="#"><c:out value="필러" /></a></li>
							</c:if>
							<c:if test="${ path eq 'mdlist=22214' }">
								<li><a href="#"><c:out value="리프팅" /></a></li>
							</c:if>
							<c:if test="${ path eq 'mdlist=33311' }">
								<li><a href="#"><c:out value="여드름케어" /></a></li>
							</c:if>
							<c:if test="${ path eq 'mdlist=33312' }">
								<li><a href="#"><c:out value="모공케어" /></a></li>
							</c:if>
							<c:if test="${ path eq 'mdlist=33313' }">
								<li><a href="#"><c:out value="탄력 주름 케어" /></a></li>
							</c:if>
						</ul>
					</nav>
                  </div>
			</div>
			<!-- subPageTop:e 서브페이지 상단 제목 공통-->
			
			<img src="resources/images/skin_02.jpg">

		</div>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>