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
				<img src="resources/images/sub_top_05.jpg">
				<div class="title_wrap">
					<p>문의하기</p>
					<p>MNR CLINIC QUESTION</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span> Home
					</a></li>
					<li><a href="#" title="커뮤니티">커뮤니티</a></li>
					<li><a href="qlist.do?page=1" title="문의하기">문의하기</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->
<br><br><br>
<section id="container" class="jmboard">
		
	<div class="sub_title board_title">
		<h3>문의하기</h3>
		<p>분야별 의료진이 직접 확인하여 답변해드립니다.</p>
	</div>	
	
	<br><br><br>
	<div class="write_btn_box">
		<!-- plain_list -->
		<table class="plain_list">
			<!-- head -->
			<tbody><tr class="head">
				<th class="num">번호</th>
				<th class="item">문의종류</th>
				<th class="title">제목</th>
				<th class="name">작성자</th>
				<th class="date">날짜</th>
			</tr>
			<!-- //head -->
			
	<!-- body.s -->
			 <c:forEach items="${ requestScope.list }" var="q">
					<tr>
				<td class="num">${ q.qna_no }</td>
				<td class="item">${ q.qna_kinds }</td>
				
				<!-- title.s -->		
	<td class="title">
	<!-- 원글일때 s -->			
	<c:if test="${ q.qna_level eq 0 }">
					<c:choose>
						<c:when	test="${ ((loginMember.id == 'admin11') or (loginMember.id == 'admin22')) or (loginMember.id == 'admin33') }">
							<c:url var="qdetail" value="qdetail.do">
                     			<c:param name="qna_no" value="${ q.qna_no }" />
                     			<c:param name="currentPage" value="${ currentPage }" />
            				</c:url><a href="${ qdetail }">${ q.qna_title }<img src="resources/images/key.png"></a>
						</c:when>
							<c:when	test="${ ((loginMember.id != 'admin11') or (loginMember.id != 'admin22')) or (loginMember.id != 'admin33') }">
								<c:url var="pwdCheck" value="movePwdCheck.do">
                     				<c:param name="qna_no" value="${ q.qna_no }" />
                     				<c:param name="currentPage" value="${ currentPage }" />
           						</c:url><a href="${ pwdCheck }">${ q.qna_title }<img src="resources/images/key.png"></a>
           					</c:when>
						<c:otherwise>
								<c:url var="pwdCheck" value="movePwdCheck.do">
                     				<c:param name="qna_no" value="${ q.qna_no }" />
                     				<c:param name="currentPage" value="${ currentPage }" />
           						</c:url><a href="${ pwdCheck }">${ q.qna_title }<img src="resources/images/key.png"></a>
						</c:otherwise>
					</c:choose>
				</c:if>			
		<!-- 원글일때 e -->	
		<!-- 댓글일때 s -->			
	<c:if test="${ q.qna_level eq 1 }">
					<c:choose>
						<c:when	test="${ ((loginMember.id == 'admin11') or (loginMember.id == 'admin22')) or (loginMember.id == 'admin33') }">
							<c:url var="qrdetail" value="qrdetail.do">
                    		 	<c:param name="qna_no" value="${ q.qna_no }" />
                    		 	<c:param name="currentPage" value="${ currentPage }" />
           					 </c:url><a href="${ qrdetail }">&nbsp; &nbsp; ▶${ q.qna_title }<img src="resources/images/key.png"></a>
						</c:when>
							<c:when	test="${ ((loginMember.id != 'admin11') or (loginMember.id != 'admin22')) or (loginMember.id != 'admin33') }">
								<c:url var="rpwdCheck" value="moveReplyPwd.do">
                     				<c:param name="qna_no" value="${ q.qna_no }" />
                     				<c:param name="currentPage" value="${ currentPage }" />
            					</c:url><a href="${ rpwdCheck }">&nbsp; &nbsp; ▶${ q.qna_title }<img src="resources/images/key.png"></a>
           					</c:when>
						<c:otherwise>
							<c:url var="rpwdCheck" value="moveReplyPwd.do">
                     			<c:param name="qna_no" value="${ q.qna_no }" />
                     			<c:param name="currentPage" value="${ currentPage }" />
            				</c:url><a href="${ rpwdCheck }">&nbsp; &nbsp; ▶${ q.qna_title }<img src="resources/images/key.png"></a>
						</c:otherwise>
					</c:choose>
				</c:if>			
		<!-- 댓글일때 e -->	
			
			<!-- title.e -->
							<td class="name">${ q.qna_name }</td>
				<td class="date"><fmt:formatDate value="${ q.qna_date }"/></td>
			</tr>
			</c:forEach>
	<!-- body.e -->	
		</tbody>
		</table>
	</div>
</section>
<!-- search -->
<br>

	<div class="write_btn_box" align="center">
			<form action="qsearch.do" class="search">
				<input type="text" name="keyword" placeholder="  제목을 입력하세요"	maxlength="20"> 
				<input type="submit" value="검색"	 class="jmboard_btn btn_white">
			</form>
	</div>

<br><br>
	<!-- //search -->
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>