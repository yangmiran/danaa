<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="listCount" value="${ requestScope.listCount }" />
<c:set var="startPage" value="${ requestScope.startPage }" />
<c:set var="endPage" value="${ requestScope.endPage }" />
<c:set var="maxPage" value="${ requestScope.maxPage }" />
<c:set var="page" value="${ requestScope.page }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<c:import url="/WEB-INF/views/common/meta.jsp" />
<script type="text/javascript">
	//전체 선택 checkbox 클릭
	function allCk(objCheck){
		var checks = document.getElementsByName('bn_no');
		for( var i = 0; i < checks.length; i++ ){
			checks[i].checked = objCheck;
		}
	}
	//검색 종류선택
	$(function(){
		$("#searchType").on("change", function(){
			var searchType =  $('#searchType').val();
			//alert(searchType);
			if(searchType == 'title'){
				$("#srchForm2").css("display", "none");
				$("#srchForm1").css("display", "block");
			}else if(searchType == 'state'){
				$("#srchForm2").css("display", "block");
				$("#srchForm1").css("display", "none");
			}
		});
	});
</script>
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
					<li>배너관리</li>
					<li class="now" title="현재 위치">배너리스트</li>
				</ol>
				<h2>배너관리</h2>
			</div>
			<!-- 타이틀:e -->
			<!-- pagecontent:s -->
			<section class="pagecontent">
				<!-- inn:s -->
				<div class="inn">
					<div class="bbs_srch">
						<form action="adbnSerch.do" name="srchForm" id="srchForm1" method="post">
							<input type="hidden" name="action" value="bn_title">
							<fieldset>
							<!-- 셀렉트박스 -->
							<select id="searchType" name="searchType" title="검색옵션">
								<option value="title" selected="selected">배너명</option>
								<option value="state">노출여부</option>
							</select>
							<input name="keyword" type="text" value="" class="inpTxt" placeholder="검색어를 입력하세요" title="검색 단어 입력">
							<button title="검색" type="submit" class="btnSearch">검색</button>
							<button title="전체보기" type="button" class="btnSearch2" onclick="location.href='adBnList.do?page=1';">전체보기</button>
							</fieldset>
						</form>
						<form action="adbnSerch.do" name="srchForm" id="srchForm2" method="post">
							<input type="hidden" name="action" value="bn_state">
							<fieldset>
							<!-- 셀렉트박스 -->
							<select id="searchType" name="searchType" title="검색옵션">
								<option value="title">배너명</option>
								<option value="state" selected="selected">노출여부</option>
							</select>
							<select class="bnState" name="keyword" title="노출여부">
								<option value="Y">노출</option>
								<option value="N">미노출</option>
							</select>
							<button title="검색" type="submit" class="btnSearch">검색</button>
							<button title="전체보기" type="button" class="btnSearch2" onclick="location.href='adBnList.do?page=1';">전체보기</button>
							</fieldset>
						</form>
					</div>
				</div> <!-- inn:e -->
			</section>
			<!-- pagecontent:e -->
			
			<!-- pagecontent:s -->
			<form action="bndelete2.do" method="get">
			<section class="pagecontent">
				<!-- inn:s -->
				<div class="inn">
				
					<div class="listTable">
						<table>
							<colgroup>
								<col style="width:5%">
								<col style="width:10%">
								<col style="width:15%">
								<col style="*">
								<col style="width:20%">
								<col style="width:20%">
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="allck" name="allck" onclick="allCk(this.checked);"></th>
									<th>No</th>
									<th>이미지</th>
									<th>배너명</th>
									<th>기간</th>
									<th>노출여부</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${ requestScope.list }" var="bn">
								<tr>
									<td><input type="checkbox" name="bn_no" value=${ bn.bn_no }></td>
									<td>${ bn.bn_no }</td>
									<td><img src="/danaa/resources/images/${ bn.bn_file }"></td>
									
									<td>
										<c:url var="bninfo" value="bnInfo.do">
											<c:param name="bn_no" value="${ bn.bn_no }" />
											<c:param name="page" value="${ page }"/>
										</c:url>
										<a href="${ bninfo }">${ bn.bn_title }</a>
									</td>
									<td>${ bn.bn_date }</td>
									<td>
										<c:if test="${ bn.bn_state == 'Y'}">
										노출
										</c:if>
										<c:if test="${ bn.bn_state == 'N'}">
										미노출
										</c:if>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
    			</div> <!-- inn:e -->
    		</section> <!-- pagecontent:e -->
    		
    		<!-- 페이징공통:s -->
	    	<div class="adpage">
	    		<!-- 맨처음으로가기 -->
	    		<c:if test="${ page <= 1 }">
	    			<a href="#" class="ti-angle-double-left"></a>
	    		</c:if>
	    		<c:if test="${ page > 1 }">
	    			<c:url var="bnp" value="adBnList.do">
	    				<c:param name="page" value="1" />
	    			</c:url>
	    			<a href="${ bnp }" class="ti-angle-double-left"></a>
	    		</c:if>
	    		<!-- 이전 그룹으로 이동 처리 -->
	    		<c:if test="${ (page - 10) < startPage && (page - 10) > 1 }">
	    			<c:url var="bnp2" value="adBnList.do">
	    				<c:param name="page" value="${ startPage - 10 }" />
	    			</c:url>
	    			<a href="${ bnp2 }" class="ti-angle-left"></a>
	    		</c:if>
				<c:if test="${ !((page - 10) < startPage && (page - 10) > 1) }">
	    			<a href="#" class="ti-angle-left"></a>
	    		</c:if>
	    		<!-- 현재 페이지가 속한 페이지그룹의 숫자 출력 처리 -->
	    		<c:forEach var="bb" begin="${ startPage }" end="${ endPage }" step="1">
	    			<c:if test="${ bb eq page }">
	    				<a href="#" class="on">${ bb }</a>
	    			</c:if>
	    			<c:if test="${ bb ne page }">
	    				<c:url var="bnp3" value="adBnList.do">
	    					<c:param name="page" value="${ bb }" />
	    				</c:url>
	    				<a href="${ bnp3 }">${ bb }</a>
	    			</c:if>
	    		</c:forEach>
	    		<!-- 다음 그룹으로 이동 처리 -->
	    		<c:if test="${ (page + 10) > endPage && (page + 10) < maxPage }">
	    			<c:url var="bnp4" value="adBnList.do">
	    				<c:param name="page" value="${ endPage + 10}"/>
	    			</c:url>
	    			<a href="${ bnp4 }" class="ti-angle-right"></a>
	    		</c:if>
	    		<c:if test="${ !((page + 10) > endPage && (page + 10) < maxPage) }">
	    			<a href="#" class="ti-angle-right"></a>
	    		</c:if>
	    		<!-- 맨끝으로가기 -->
	    		<c:if test="${ page >= maxPage }">
	    			<a href="#" class="ti-angle-double-right"></a>
	    		</c:if>
	    		<c:if test="${ page < maxPage }">
	    			<c:url var="bnp5" value="adBnList.do">
	    				<c:param name="page" value="${ maxPage }" />
	    			</c:url>
	    			<a href="${ bnp5 }" class="ti-angle-double-right"></a>
	    		</c:if>
	    	</div>
	    	<!-- 페이징공통:e -->
	    	
    	
	    	<!-- 버튼 -->
			<div class="input-btn">
				<input type="button" onclick="javascript:location.href='bnWrite.do'" value="등록">
				<c:url var="bnInfo" value="bnInfo.do">
               		<c:param name="page" value="${ page }"/>
            	</c:url>
				<input type="submit" value="삭제">
			</div>
			<!-- 버튼 -->
		</form>
		</div>
	</main>
</div>
</body>
</html>
