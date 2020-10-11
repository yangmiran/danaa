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
					<p>이벤트</p>
					<p>MNR CLINIC EVENT</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span> Home
					</a></li>
					<li><a href="#" title="병원소식">병원소식</a></li>
					<li><a href="elist.do?page=1" title="이벤트">EVENT</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->
<br><br><br>


<section id="container" class="qnaWrite">

		
	<div class="jmboard_box">
	<!-- write_form -->
		<form action="eupdate.do" method="post" enctype="multipart/form-data" class="write_form">
		<input type="hidden" name="event_no" value="${ event.event_no }">
		<input type="hidden" name="currentPage" value="${ currentPage }">
		<input type="hidden" name="event_thumb" value="${ event.event_thumb }">
		<input type="hidden" name="event_file" value="${event.event_file }">
			<h2 class="red" align="center"><b>*</b>이벤트 수정하기</h2>

			<div class="box">
				<p>제목 <b>*</b></p>
				<div class="input">
					<input type="text" name="event_title" id="title" class="input1" value ="${ event.event_title }" >
				</div>
			</div>
			
			<div class="box">
				<p>이벤트기간 <b>*</b></p>
				<div class="input">
					<input type="text" name="event_period" id="title" class="input1" value ="${ event.event_period }" >
				</div>
			</div>

			<div class="box contents">
				<p>내용 <b>*</b></p>
				<div class="input">
				<textarea rows="5" cols="50" id="contents" name="event_content">${ event.event_content }</textarea>
				</div>
			</div>

				<div class="box">
					<p>진행여부 <b>*</b>
					</p>
					<div class="input">
						<select name="event_state" class="input1" id="item" style="display: inline-block;">
							<option value="Y">진행여부를 선택해 주십시오</option>
							<option value="Y">진행중</option>
							<option value="N">종료</option>
						</select>
						<div class="item_box" style="display: none;"></div>
					</div>
				</div>

				<div class="box">
					<p>썸네일 <b>*</b></p>
					<div class="input">${ event.event_thumb } &nbsp;
							<br>
						<input type="file" name="tupfile">
					</div>
				</div>
				
				<div class="box">
					<p>내용이미지 <b>*</b></p>
					<div class="input">${ event.event_file } &nbsp;
							<br>
						<input type="file" name="cupfile">
					</div>
				</div>

				<!-- //write_form -->

		<div class="write_btn_box">
			<input type="reset" value="수정취소" onclick="javascript:history.go(-1); return false;" id="writeBtn" class="jmboard_btn btn_common">
			<input type="submit" value="수정완료" id="writeBtn" class="jmboard_btn btn_white">
		</div>
	</form>
</div>
</section>
<c:import url="/WEB-INF/views/common/footer.jsp" />
	<script>
         CKEDITOR.replace("event_content", { 
            height:"400"
         });
    </script>
</body>
</html>