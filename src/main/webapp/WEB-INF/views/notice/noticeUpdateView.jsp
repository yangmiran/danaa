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
				<img src="resources/images/sub_top_04.jpg">
				<div class="title_wrap">
					<p>미앤란소식</p>
					<p>MNR CLINIC NOTICE</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span> Home
					</a></li>
					<li><a href="#" title="병원소식">병원소식</a></li>
					<li><a href="nlist.do?page=1" title="미앤란소식">미앤란소식</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->
<br><br><br>

<section id="container" class="qnaWrite">
		
	<div class="jmboard_box">
	<!-- write_form -->
		<form action="nupdete.do" method="post" enctype="multipart/form-data" class="write_form">
			<input type="hidden" name="notice_no" value="${notice.notice_no}">
			<input type="hidden" name="page" value="${currentPage }">
			<input type="hidden" name="ofile" value="${notice.notice_file}">
			<input type="hidden" name="rfile" value="${notice.notice_refile}">
			<h2 class="red" align="center"><b>*</b>미앤란 소식 수정하기</h2>

			<div class="box">
				<p>이름 <b>*</b></p>
				<div class="input">
					<input type="text" name="notice_writer" id="name" class="input1" maxlength="10" readonly value="미앤란클리닉">
				</div>
			</div>

			<div class="box">
				<p>제목 <b>*</b></p>
				<div class="input">
					<input type="text" name="notice_title" id="title" class="input1" value="${ notice.notice_title }">
				</div>
			</div>

			<div class="box contents">
				<p>내용 <b>*</b></p>
				<div class="input">
				<textarea rows="5" cols="50" id="contents" name="notice_content">${ notice.notice_content }</textarea>
				</div>
			</div>
			
			<div class="box">
				<p>파일선택 </p>
				<div class="input">
				<c:if test="${!empty notice.notice_file }">
               ${notice.notice_file} &nbsp;
               <input type="checkbox" name="delflag" value="yes"> 파일삭제
               <br>
            </c:if>
            
            <input type="file" name="upfile">		
				</div>
			</div>

		<!-- //write_form -->

		<div class="write_btn_box">
			<input type="submit" value="수정완료" id="writeBtn" class="jmboard_btn btn_common">
			<input type="reset" value="수정취소" onclick="javascript:history.go(-1); return false;" id="writeBtn" class="jmboard_btn btn_white">
		</div>
	</form>
</div>
</section>
<c:import url="/WEB-INF/views/common/footer.jsp" />
	<script>
         CKEDITOR.replace("notice_content", { 
            height:"400"
         });
    </script>
</body>
</html>