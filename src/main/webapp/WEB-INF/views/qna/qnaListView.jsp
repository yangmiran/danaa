<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="listCount" value="${ requestScope.listCount }" />
<c:set var="startPage" value="${ requestScope.startPage }" />
<c:set var="endPage" value="${ requestScope.endPage }" />
<c:set var="maxPage" value="${ requestScope.maxPage }" />
<c:set var="currentPage" value="${ requestScope.currentPage }" />
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
		<div class="list_util">
		
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
	
		<br>
   <!-- 페이징 처리 -->
   <div style="text-align:center;">
      <c:if test="${ currentPage <= 1 }">
         [맨처음]&nbsp;
      </c:if>
      <c:if test="${ currentPage > 1 }">
         <c:url var="ubl" value="qlist.do">
            <c:param name="page" value="1" />
         </c:url>
         <a href="${ ubl }">[맨처음]</a>
      </c:if>
      
      <!-- 이전 그룹으로 이동 처리 -->
      <c:if test="${ (currentPage - 10) < startPage && (currentPage - 10) > 1 }">
         <c:url var="ubl2" value="qlist.do">
            <c:param name="page" value="${ startPage - 10 }"/>
         </c:url>
         <a href="${ ubl2 }">[이전그룹]</a>
      </c:if><c:if test="${ !((currentPage - 10) < startPage && (currentPage - 10) > 1) }">
         [이전그룹]&nbsp;
      </c:if>
      
      <!-- 현재 페이지가 속한 페이지그룹의 숫자 출력 처리 -->
      <c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
         <c:if test="${ p eq currentPage }">
            <font color="red" size="4"><b>[${ p }]</b></font>
         </c:if><c:if test="${ p ne currentPage }">
            <c:url var="ubl3" value="qlist.do">
               <c:param name="page" value="${ p }" />
            </c:url>
            <a href="${ ubl3 }">${ p }</a>
         </c:if>
      </c:forEach>
      
      <!-- 다음 그룹으로 이동 처리 -->
      <c:if test="${ (currentPage + 10) > endPage && (currentPage + 10) < maxPage }">
         <c:url var="ubl4" value="qlist.do">
            <c:param name="page" value="${ endPage + 10 }" />
         </c:url>
         <a href="${ ubl4 }">[다음그룹]</a>
      </c:if><c:if test="${ !((currentPage + 10) > endPage && (currentPage + 10) < maxPage) }">
         [다음그룹]&nbsp;
      </c:if>
      
      <c:if test="${ currentPage >= maxPage }">
         [맨끝]&nbsp;
      </c:if><c:if test="${ currentPage < maxPage }">
         <c:url var="ubl5" value="qlist.do">
            <c:param name="page" value="${ maxPage }"/>
         </c:url> 
         <a href="${ ubl5 }">[맨끝]</a>
      </c:if>
      <!-- 글쓰기s -->
      <div class="write_btn_box">
			<a href="moveQwrite.do" class="qnaw_btn btn_common">글쓰기</a>
		</div>
       <!-- 글쓰기e -->
   </div>
	</div>
</section>

<!-- search -->
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