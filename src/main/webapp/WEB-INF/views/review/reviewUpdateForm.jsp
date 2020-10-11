<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
</head>
<body>
	<c:import url="/WEB-INF/views/common/meta.jsp" />
	<c:import url="/WEB-INF/views/common/header.jsp" />

	<!-- subPageTop:s 서브페이지 상단 제목 공통-->
	<div class="subPageTop">
		<div class="sub">
			<div class="s_top_gp_wrap">
				<img src="resources/images/sub_top_05.jpg">
				<div class="title_wrap">
					<p>진료후기</p>
					<p>MNR clinic Introduction</p>
				</div>
			</div>
			<nav class="sub_navi">
				<ul>
					<li><a
						href="${ pageContext.servletContext.contextPath }/main.do"
						title="홈 바로가기"> <span class="ti-home"></span> Home
					</a></li>
					<li><a href="/" title="커뮤니티">커뮤니티</a></li>
					<li><a href="/" title="진료후기">진료후기</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- subPageTop:e 서브페이지 상단 제목 공통-->
	<br><br>

	<h1 align="center">
		<strong>여러분의 소중한 이야기를 들려주세요</strong>
	</h1>
	<br>
	
	
	<section id="container" class="reviewjmboard">
		<form action="rupdate.do" method="post" enctype="multipart/form-data"
			name="write_form" class="reviewwrite_form">
			<input type="hidden" name="review_no" value="${ review.review_no }">
			<input type="hidden" name="page" value="${ currentPage }">
			<input type="hidden" name="ofile" value="${ review.review_original_filename }">
			<input type="hidden" name="rfile" value="${ review.review_rename_filename }">
			
			<div class="reviewjmboard_box"> 
				<h4 >
					<b>*</b> 표시된 항목은 필수 항목입니다. <br> <b>**</b> 첨부파일의 확장자 예시 :
					test1.jpg(O), test1.JPG(X) <b>**</b>
				</h4>
				<br><br><br>
				<div class="reviewbox">
					<h2>
						<strong>제목&nbsp;&nbsp;&nbsp; <b>*</b></strong>
					</h2>
					<div class="reviewinput">
						<input type="text" name="review_title" id="title" class="reviewinput1"
							placeholder="제목" value="${ review.review_title }">
					</div>

					<div class="reviewbox">
						<h2>
							<strong>이름&nbsp;&nbsp;&nbsp; <b>*</b></strong>
						</h2>
						<div class="reviewinput">
							<input type="text" name="review_writer" id="name" class="reviewinput1"
								placeholder="이름" value="${ review.review_writer }">
							<%-- <input type="text" name="review_writer" readonly value="${ sessionScope.loginMember.userid }"  id="name" class="input1" maxlength="10" placeholder="이름" value=""> --%>
						</div>
					</div>

					<div class="reviewbox">
						<h2>
							<strong>내용을 입력해주세요 <b>*</b></strong>
						</h2>
						<div class="reviewinput">
							<input type="text" name="review_content" id="content"
								class="reviewinput2" placeholder="내용을 입력해주세요" value="${ review.review_content }">
							<!-- <td><textarea rows="5" cols="50" name="review_content"></textarea></td> -->
						</div>

						<div class="reviewbox">
							<h2>
								<strong>사진첨부&nbsp;&nbsp;&nbsp; <b>*</b></strong>
							</h2>
							<c:if test="${ !empty review.review_original_filename }">
							${ review.review_original_filename }
							<input type="checkbox" name="delflag" value="yes" class="jmboard_btn reviewbtn_white">파일삭제
							</c:if>
							<br>
							<input type="file" name="upfile" class="reviewinput1" >
							</div>
						
	</section>
	<!-- //write_form -->
	
	<div class="reviewwrite_btn_box ">
		<input type="reset" value="취소" class="jmboard_btn reviewbtn_black">&nbsp;&nbsp;&nbsp;
		<input type="submit" value="등록" class="jmboard_btn reviewbtn_common">&nbsp;&nbsp;&nbsp;
		<input type="button" value="목록" class="jmboard_btn reviewbtn_white"
			onclick="javascript:history.go(-1); return false;">
	</div>
	</form>
</body>
</html>