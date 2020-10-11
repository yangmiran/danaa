<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentPage" value="${currentPage}" />
<c:set var="qna" value="${qna}" />
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
<script src="resources/ckeditor/ckeditor.js"></script>
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


<section id="container" class="qnaWrite">


		
	<div class="jmboard_box">
	<!-- write_form -->
		<form action="qUpdate.do" method="post" enctype="multipart/form-data" class="write_form">
<input type="hidden" name="qna_no" value="${qna.qna_no}">
<input type="hidden" name="page" value="${currentPage }">
<input type="hidden" name="ofile" value="${qna.qna_file}">
<input type="hidden" name="rfile" value="${qna.qna_refile}">
			<h2 class="red" align="center"><b>*</b>문의글 수정하기</h2>

			<div class="box">
				<p>이름 <b>*</b></p>
				<div class="input">
					<input type="text" name="qna_name" id="name" class="input1" maxlength="10" readonly value="${ qna.qna_name }">
				</div>
			</div>

			<div class="box pw">
				<p>비밀번호 <b>*</b></p>
				<div class="input">
					<input type="password" name="qna_pwd" id="pw" class="input1" maxlength="4" value="${ qna.qna_pwd }">
					<span class="red" style="display:block">※ 내용 확인 및 글 수정/삭제 시 필요합니다.</span>
				</div>	
			</div>

			
			<div class="box">
				<p>연락처 <b>*</b></p>
				<div class="input">
					<input type="text" name="qna_phone" class="input1" maxlength="13" value="${ qna.qna_phone }">
					
				</div>
			</div>
			
			<div class="box">
				<p>문의종류 <b>*</b></p>
				<div class="input">
					<select name="qna_kinds" class="input1" id="item" style="display: inline-block;">
						<option value="상담예약">문의종류를 선택해 주십시오</option>
													<option value="상담예약">상담예약</option>
													<option value="레이저문의">레이저문의</option>
													<option value="보톡스문의">보톡스문의</option>
													<option value="필러문의">필러문의</option>
													<option value="리프팅문의">리프팅문의</option>
													<option value="피부케어">피부케어</option>
											</select>
					<div class="item_box" style="display: none;">
						
					</div>
				</div>
			</div>

			<div class="box">
				<p>제목 <b>*</b></p>
				<div class="input">
					<input type="text" name="qna_title" id="title" class="input1" value="${ qna.qna_title }">
				</div>
			</div>
			

			<div class="box contents">
				<p>내용 <b>*</b></p>
				<div class="input">
				<textarea rows="5" cols="50" id="contents" name="qna_content">${ qna.qna_content }</textarea>
				</div>
			</div>
			
			<div class="box">
				<p>파일선택 </p>
				<div class="input">
				<c:if test="${!empty qna.qna_file }">
               ${qna.qna_file} &nbsp;
               <input type="checkbox" name="delflag" value="yes"> 파일삭제
               <br>
            </c:if>
            
            <input type="file" name="upfile">		
				</div>
			</div>

			
		<!-- //write_form -->

		<div class="write_btn_box">
			<input type="submit" value="수정완료" id="writeBtn" class="jmboard_btn btn_common">
			<input type="button" value="수정취소" onclick="javascript:history.go(-1); return false;" id="writeBtn" class="jmboard_btn btn_white">
		</div>
	</form>
	
</div>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</section>
	<script>
         CKEDITOR.replace("qna_content", { 
            height:"400"
         });
    </script>
</body>
</html>