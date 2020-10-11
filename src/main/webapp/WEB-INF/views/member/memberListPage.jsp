<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<c:set var="listCount" value="${requestScope.listCount}"/>
<c:set var="startPage" value="${requestScope.startPage}"/>
<c:set var="endPage" value="${requestScope.endPage}"/>
<c:set var="maxPage" value="${requestScope.maxPage}"/>
<c:set var="currentPage" value="${requestScope.currentPage}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<style type="text/css">
form.sform {
	display: none;
	
}
</style>
<c:import url="/WEB-INF/views/common/meta.jsp" />
<script type="text/javascript"
	src="/danaa/resources/js/jquery-3.5.1.min.js">
	
</script>
<script type="text/javascript">
//jquery 로 이벤트 처리 : form 을 보이게 안보이게 처리함
$(function(){
	//작성된 이벤트 처리 코드는 실행 대기 상태가 됨
	$("input[name=item]").on("change", function(){ //5개의 input 태그에 on으로 이벤트 연결함
		    //5개 전부다 바뀌면 다음 function이 구동되라의 의미임 ~callback 함수라고함
		   //이벤트가 발생한 radio와 연결된 폼만 보이게 하고, 나머지 폼은 아보이게 처리함
		   $("input[name=item]").each(function(index){ // each() 루프 돌리기 ~(index)사용가능
			   //radio 하나씩 checked인지 확인하고
			   //해당 인덱스 순번의 radio가 체크상태인지 확인
			   //배열 0부터 checked 됬는지 확인  //라디오버튼 순서와 폼 순서를 맞춰 index로 연결
			   if($(this).is(":checked")){  
				   $("form.sform").eq(index).css("display","block");
			   }else{
				   $("form.sform").eq(index).css("display","none");
				  
			   }   
			   
		   }); 
	});   
	                    
});


function allCk(objCheck) { //전체 선택 checkbox 클릭
	var checks = document.getElementsByName('mid');
	for (var i = 0; i < checks.length; i++) {
		checks[i].checked = objCheck;
		// name이 'id' 인 checkbox는  id가 allck인 checkbox의 checked 상태와 같게 된다. 
	}
}
	
</script>


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
				
					<li class="now" title="현재 위치">고객관리</li>
				</ol>
				<h2>고객관리</h2>
			</div>
		

<!-- 드롭다운 -->
<div id="ad_listview"> <!-- 전체 묶은 div : start -->	
	
<!-- pagecontent:s -->
				<section class="pagecontent">
					<!-- inn:s -->
					<div class="inn">
					<div class="bbs_srch">
								
<form action="" class="ad_serch_in" name="srchForm" id="srchForm" method="post">
<!-- 2. 항목별 검색 기능 추가 -->
<fieldset id = "ss" class="ad_serch clear"> <!-- 항목들의 영역을 묶어주기 위해서 사용 -->
 <legend>검색 분류</legend>
<span class="topserch">
	<input type="radio" name="item" id="uid"><label> 아이디</label>
	<input type="radio" name="item" id="uname"><label>이름</label>
	<input type="radio" name="item" id="ugender"><label>성별</label>
	<input type="radio" name="item" id="uage"><label>연령대</label>
	<%-- &nbsp;&nbsp;<a href="<c:url value='mlist.do?page=1'/>">전체조회</a> --%>
	<%-- &nbsp;&nbsp;<a href="<c:url value='mdeletead.do'/>">회원탈퇴</a> --%>
	
</span>
</fieldset>
</form>
<!-- 검색 기능 영역 끝 -->
<!-- 버튼 공통 -->
				

<!-- 회원 아이디로 검색 폼 -->
<form action="msearch.do" method="post" id="idform" class="sform ad_serch_in">
<input type="hidden" name="action" value="id"> 
<fieldset class="ad_serch_form" >
<!-- 아이디 검색 폼 -->
<legend>아이디 </legend>

<span class="topserch">
	
	<input type="search" name="keyword" class="inpTxt_list" placeholder="검색어를 입력하세요">    
	<input type="submit" value="검색" class="btnSearch_list">

</span>

</fieldset>
</form>
<!-- 이름 검색 폼 -->
<form action="msearch.do" method="post" id="nnameform" class="sform ad_serch_in">
<input type="hidden" name="action" value="name">
<fieldset class="ad_serch_form">
<legend>이름 </legend>

<span class="topserch">
	<input type="text" name="keyword" class="inpTxt_list" placeholder="검색어를 입력하세요">
	<input type="submit" value="검색" class="btnSearch_list">
</span>

</fieldset>
</form>

<!-- 성별 검색 폼 -->
<form action="msearch.do" method="post" id="genderform" class="sform ad_serch_in">
<input type="hidden" name="action" value="gender">
<fieldset class="ad_serch clear">
<legend>검색할 성별을 선택하세요.</legend>

<span class="topserch">
	<input type="radio" name="keyword" value="M"> 남자 &nbsp; 
	<input type="radio" name="keyword" value="F"> 여자 &nbsp;
	<input type="submit" value="검색" class="btnSearch_list">
</span>

</fieldset>
</form>

<!-- 연령대 검색 폼 -->
<form action="msearch.do" method="post" id="ageform" class="sform ad_serch_in">
<input type="hidden" name="action" value="age">
<fieldset class="ad_serch clear">
<legend>검색할 연령대를 선택하세요.</legend>

<span class="topserch">
	<input type="radio" name="keyword" value="10"> 10대 &nbsp; 	
	<input type="radio" name="keyword" value="20"> 20대 &nbsp; 
	<input type="radio" name="keyword" value="30"> 30대 &nbsp;
	<input type="radio" name="keyword" value="40"> 40대 &nbsp;
	<input type="radio" name="keyword" value="50"> 50대 &nbsp;
	<input type="radio" name="keyword" value="60"> 60대이상 &nbsp;
	<input type="submit" value="검색" class="btnSearch_list">
</span>

</fieldset>
</form>
</div>
	</div> <!-- inn:e -->
				</section> <!-- pagecontent:e -->
				

<form action="mdeletead.do">
<!-- <input type="submit"  value="회원 탈퇴"> -->
 
			<!-- pagecontent:s -->
			<section class="pagecontent">
				<!-- inn:s -->
				<div class="inn">
					<div class="listTable">
						<table>
							<colgroup>
							<col width="5%" />
							<col width="6%" />
                           <col width="8%" />
                           <col width="8%" />
                           <col width="8%" />
                           <col width="7%" />
                           <col width="7%" />
                           <col width="10%" />
                            <col width="7%" />
                            <col width="7%" />
                             <col width="9%" />
                             <col width="12%" />
                             
                             <col width="6%" />
                             <col width="*" />
                           
							</colgroup>
							<thead>
		<tr>
		<th><input type="checkbox" id="allck" name="allck" onclick="allCk(this.checked);"></th>
			<th>회원번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>핸드폰번호</th>
			<th>생년월일</th>
			<th>성별</th>
			<th>이메일</th>
			<th>이메일수신동의여부</th>
			<th>가입날짜</th>
			<th>마지막수정일</th>
			<th>14세미만여부</th>
			<th>회원상태</th>

		</tr>
</thead>
							<tbody>

		 <c:forEach items="${ requestScope.list }" var="m">
		<tr>
		<td  align="center"><input type="checkbox" name="mid" value="${ m.id }"></td>
			<td>${ m.member_no }</td>
			<td>${ m.id }</td>
			<td>${m.name }</td>
			<td>${m.phone }</td>
			<td>${m.birth }</td>
			<td>${(m.gender eq "M")? "남성" : "여성" }</td>
			<td>${m.email }</td>
			<td>${(m.ag_email eq "Y")? "동의" : "미동의"}</td>
			<td><fmt:formatDate value="${ m.enroll_date }" type="date" dateStyle="medium" /> </td>
			<td><fmt:formatDate value="${ m.last_modified }" type="date" dateStyle="medium" /></td>
			<td>${(m.child eq "N")? "": m.child }</td>		
			<td>${(m.status eq 1)? "일반회원" : "관리자"}</td>
			
		</tr>
		</c:forEach>
	</tbody>
		</table>
					</div>
    			</div> <!-- inn:e -->
    		</section> <!-- pagecontent:e -->


				<!-- 버튼 공통 -->
				<div class="input-btn">      
	       			<input type="submit" value="회원탈퇴" onclick="javascript:this.form.action='mdeletead.do';">
	       			 <input type="submit" value="전체조회" onclick="javascript:this.form.action='mlist.do?page=1';"/>
	     		</div>
	</form>
</div><!-- main:e -->
 <!-- 빈칸 -->
      <div class="blank"></div>
	     		<!-- 페이징공통:s -->
	    	<div class="adpage">
	    		<!-- 맨 처음 그룹 -->
	    		<c:if test="${currentPage <= 1 }"> 
					<a href="#" class="ti-angle-double-left"></a>
				</c:if>
				<c:if test="${currentPage > 1 }"> 
					<c:url var="mfir" value="mlist.do">
						<c:param name="page" value="1"/>
					</c:url>
					<a href="${mfir}" class="ti-angle-double-left"></a>
				</c:if>
	    		<!-- 이전그룹 -->
	    		<c:if test="${(currentPage - 10) < startPage && (currentPage - 10) > 1}">
					<c:url var="mbgr" value="mlist.do">
						<c:param name="page" value="${startPage - 10}"/>
					</c:url>
						<a href="${mbgr}" class="ti-angle-left"></a>
				</c:if>
				<c:if test="${!((currentPage - 10) < startPage && (currentPage - 10) > 1)}">
					<a href="#" class="ti-angle-left"></a>
				</c:if>
	    		
	    		<!-- 현재 페이지가 속한 그룹 -->
	    		<c:forEach var="p" begin="${startPage }" end="${endPage}" step="1" >
					<c:if test="${p eq currentPage}">
						<a href="#" class="on">${p}</a>
					</c:if>	
					<c:if test="${p ne currentPage}">
						<c:url var="mcup" value="mlist.do">
							<c:param name="page" value="${p}"/>
						</c:url>
							<a href="${mcup}">${p}</a>
					</c:if>	
				</c:forEach>
				<!-- <a href="#">2</a> -->
	    		<!-- 다음 그룹 -->
	    		<c:if test="${(currentPage + 10) > endPage && (currentPage + 10) < maxPage}">
					<c:url var="mngr" value="mlist.do">
						<c:param name="page" value="${endPage + 10}"/>
					</c:url>
						<a href="${mngr}" class="ti-angle-right"></a>
				</c:if>
				<c:if test="${!((currentPage + 10) > endPage && (currentPage + 10) < maxPage)}">
					<a href="#" class="ti-angle-right"></a>
				</c:if>
	    		<!-- 맨 끝 그룹 -->
	    		<c:if test="${currentPage >= maxPage}">
						<a href="#" class="ti-angle-double-right"></a>
				</c:if>
				<c:if test="${currentPage < maxPage}">
					<c:url var="mend" value="mlist.do">
						<c:param name="page" value="${maxPage}"/>
					</c:url>
						<a href="${mend}" class="ti-angle-double-right"></a>
				</c:if>
 		
	    	</div>
	    	<!-- 페이징공통:e -->
		</div> <!-- main-con:e -->
	</main>
</div>
<!-- 페이징 처리 -->

 <%-- <div id="mlist_page" style="text-align:center;">
		
		<c:if test="${currentPage<=1}">
			<span class="ti-angle-double-left"></span>
		</c:if>
		<c:if test="${currentPage>1}">
			<c:url var="mfir" value="mlist.do">
				<c:param name="page" value="1"/> 			
			</c:url>
			<span><a href="${mfir}" class="ti-angle-double-left"></a></span>
		</c:if>
	
		<!-- 현재 페이지가 속한 페이지그룹의 숫자 출력 처리 -->
		<c:forEach var="p" begin="${startPage }" end="${endPage}" step="1">	
			
			<c:if test="${p eq currentPage}">
				<span><font color="steelblue" size="4"><b>${p}</b></font></span>
			</c:if>
			<c:if test="${p ne currentPage}">
				<c:url var="mcup" value="mlist.do">
					<c:param name="page" value="${p}"/>				
				</c:url>
				<span><a href="${mcup}">${p}</a></span>
			</c:if>
		</c:forEach>

		<c:if test="${currentPage >= maxPage}">
			<span class="ti-angle-double-right"></span>
		</c:if>		
		<c:if test="${currentPage < maxPage}">
			<c:url var="mend" value="mlist.do">
				<c:param name="page" value="${maxPage}"/>
			</c:url>
			<span><a href="${mend}" class="ti-angle-double-right"></a></span>
		</c:if>
	</div> 
 
</div> --%><!-- 전체 묶은 div : end -->	
</body>
</html>