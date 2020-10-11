<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<form action="replyUpdate.do" method="post" class="write_form">
		<input type="hidden" name="qna_phone" value="${ qna.qna_phone }">
		<input type="hidden" name="currentPage" value="${ currentPage }">
		<input type="hidden" name="qna_no" value="${ qna.qna_no }">
		<input type="hidden" name="qna_kinds" value="답변">
			
			<h2 class="red" align="center" ><b>*</b>답변 수정하기</h2>
			
			<div class="box">
				<p>작성자 <b>*</b></p>
				<div class="input">
					<input type="text" name="qna_name" id="name" class="input1" maxlength="10" value="미앤란">
				</div>
			</div>

			<div class="box pw">
				<p>비밀번호 <b>*</b></p>
				<div class="input">
					<input type="password" name="qna_pwd" id="pw" class="input1" maxlength="4" readonly value="${ qna.qna_pwd }">
					<span class="red" style="display:block">※ 문의사항 작성시의 비밀번호와 동일합니다.(수정불가)</span>
				</div>	
			</div>


			<div class="box">
				<p>제목 <b>*</b></p>
				<div class="input">
					<input type="text" name="qna_title" id="title" class="input1" readonly value="문의 주신 내용에 답변 드립니다." >
				</div>
			</div>

			<div class="box contents">
				<p>내용 <b>*</b></p>
				<div class="input">
				<textarea rows="5" cols="50" id="contents" name="qna_content" >${ qna.qna_content }</textarea>
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