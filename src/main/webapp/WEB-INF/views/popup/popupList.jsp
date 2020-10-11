<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<c:import url="/WEB-INF/views/common/meta.jsp" />

<script type="text/javascript">
//전체 선택 checkbox 클릭
   function allCk(objCheck){ 
     var checks = document.getElementsByName('popup_no');
     for( var i = 0; i < checks.length; i++ ){
      checks[i].checked = objCheck;
      // name이 'popup_no' 인 checkbox는  id가 allck인 checkbox의 checked 상태와 같게 된다. 
     }
    }
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
					<li>팝업관리</li>
					<li class="now" title="현재 위치">팝업목록</li>
				</ol>
				<h2>팝업관리</h2>
			</div>
			<!-- 타이틀:e -->
			<!-- pagecontent:s -->
			<section class="pagecontent">
				<!-- inn:s -->
				<div class="inn">
					<div class="bbs_srch">
						<form action ="psearch.do" name="srchForm" id="srchForm">
							<fieldset>
							<!-- 셀렉트박스 -->
							<select name="searchType" title="검색옵션">
								<option value="sj">팝업명</option>
								<option value="cn">노출여부</option>
							</select>
							<input name="keyword" type="text" value="" class="inpTxt" placeholder="검색어를 입력하세요" title="검색 단어 입력">
							<button title="검색" type="submit" class="btnSearch" onclick="javascript:searchEvent()">검색</button>
							</fieldset>
						</form>
					</div>
				</div> <!-- inn:e -->
			</section>
			<!-- pagecontent:e -->
			
			<!-- pagecontent:s -->
		<form action = "">
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
									<th>팝업명</th>
									<th>등록날짜</th>
									<th>노출여부</th>
								</tr>
							</thead>
							
							<tbody>
							<c:forEach items="${ requestScope.list }" var="p">
								<tr>
									<td><input type="checkbox" value="${ p.popup_no }" name="popup_no"></td>
									<td>${ p.popup_no }</td>
									<td><img src="resources/pupfiles/${ p.popup_refile }"></td>
									<td>${ p.popup_title }</td>
									<td>${ p.popup_date }</td>
									
									<td>
								<select name="popup_state" title="노출여부">
									<c:if test="${ p.popup_state == 0}">
										<option value="0">노출</option>
										<option value="1">미노출</option>
									</c:if>
									<c:if test="${ p.popup_state == 1}">
										<option value="1">미노출</option>
										<option value="0">노출</option>
									</c:if>
								</select>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
					
					<!-- 버튼 -->
					<div class="input-btn3">
						<c:url var="moveWrite" value="moveWrite.do">
                     		<c:param name="page" value="${ page }"/>
                  		</c:url>
							<input type="button" onclick="javascript:location.href='${ moveWrite }'" value="등록">					
							<input type="submit" onclick="javascript:this.form.action='pupdate.do'" value="수정">
							<input type="submit" onclick="javascript:this.form.action='pdelete.do'" value="삭제">
					</div>
					<!-- 버튼 -->
					
    			</div> <!-- inn:e -->

    		</section> <!-- pagecontent:e -->
    </form>
    
				<!-- 페이징 처리 -->
				<div style="text-align: center;">
					<c:if test="${ page <= 1 }">[맨처음]&nbsp;</c:if>
					<c:if test="${ page > 1 }">
						<c:url var="ubl" value="plist.do">
							<c:param name="page" value="1" />
						</c:url>
							<a href="${ ubl }">[맨처음]</a>
					</c:if>

					<!-- 이전 그룹으로 이동 처리 -->
					<c:if test="${ (page - 10) < startPage && (page - 10) > 1 }">
						<c:url var="ubl2" value="plist.do">
							<c:param name="page" value="${ startPage - 10 }" />
						</c:url>
						<a href="${ ubl2 }">[이전그룹]</a>
					</c:if>
					<c:if test="${ !((page - 10) < startPage && (page - 10) > 1) }">[이전그룹]&nbsp;
      				</c:if>

					<!-- 현재 페이지가 속한 페이지그룹의 숫자 출력 처리 -->
					<c:forEach var="pp" begin="${ startPage }" end="${ endPage }" step="1">
						<c:if test="${ pp eq page }">
							<font color="red" size="4"><b>[${ pp }]</b></font>
						</c:if>
						<c:if test="${ pp ne page }">
							<c:url var="ubl3" value="plist.do">
								<c:param name="page" value="${ pp }" />
							</c:url>
							<a href="${ ubl3 }">${ pp }</a>
						</c:if>
					</c:forEach>

					<!-- 다음 그룹으로 이동 처리 -->
					<c:if
						test="${ (page + 10) > endPage && (page + 10) < maxPage }">
						<c:url var="ubl4" value="plist.do">
							<c:param name="page" value="${ endPage + 10 }" />
						</c:url>
						<a href="${ ubl4 }">[다음그룹]</a>
					</c:if>
					<c:if test="${ !((page + 10) > endPage && (page + 10) < maxPage) }">[다음그룹]&nbsp;</c:if>
					<c:if test="${ page >= maxPage }">[맨끝]&nbsp;</c:if>
					<c:if test="${ page < maxPage }">
						<c:url var="ubl5" value="plist.do">
							<c:param name="page" value="${ maxPage }" />
						</c:url>
						<a href="${ ubl5 }">[맨끝]</a>
					</c:if>
				</div>
				
				<!-- //페이징  -->
		</div>
	</main>
</div>
</body>
</html>
