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
<c:import url="/WEB-INF/views/common/meta.jsp" />
<script>
/* function click1() {
	if($(".medical_serch .hashtag_list .name").data("name", "색소레이저") == true){
		$(".medical_serch .hashtag_list li").css("display", "none");
	}
}
 */
//#클릭시 해당되는 리스트

function click1() {
	$(".medical_serch .hashtag_list li").removeClass("on");
	$(".medical_serch .hashtag_list li:nth-child(1), .medical_serch .hashtag_list li:nth-child(2)").addClass("on");
	$(".medical_serch .hashtag_list li").css("display", "none");
	$(".medical_serch .hashtag_list li.on").css("display", "block");
}

function click2() {
	$(".medical_serch .hashtag_list li").removeClass("on");
	$(".medical_serch .hashtag_list li:nth-child(3), .medical_serch .hashtag_list li:nth-child(4)").addClass("on");
	$(".medical_serch .hashtag_list li").css("display", "none");
	$(".medical_serch .hashtag_list li.on").css("display", "block");
}

function click3() {
	$(".medical_serch .hashtag_list li").removeClass("on");
	$(".medical_serch .hashtag_list li:nth-child(5)").addClass("on");
	$(".medical_serch .hashtag_list li").css("display", "none");
	$(".medical_serch .hashtag_list li.on").css("display", "block");
}

function click4() {
	$(".medical_serch .hashtag_list li").removeClass("on");
	$(".medical_serch .hashtag_list li:nth-child(6)").addClass("on");
	$(".medical_serch .hashtag_list li").css("display", "none");
	$(".medical_serch .hashtag_list li.on").css("display", "block");
}

function click5() {
	$(".medical_serch .hashtag_list li").removeClass("on");
	$(".medical_serch .hashtag_list li:nth-child(1), .medical_serch .hashtag_list li:nth-child(7), .medical_serch .hashtag_list li:nth-child(8)").addClass("on");
	$(".medical_serch .hashtag_list li").css("display", "none");
	$(".medical_serch .hashtag_list li.on").css("display", "block");
}

function click6() {
	alert("해당되는 진료과목이 없습니다.");
	$(".medical_serch .hashtag_list li").css("display", "none");
}	

</script>
<style>
#footer .footer_in .cont {display:none};
</style>
</head>
<body>
	<!-- wrap:s -->
	<div id="wrap">
		<c:import url="/WEB-INF/views/common/header.jsp" />
		<!--container:s-->
		<div class="container">
			<!-- subPageTop:s 서브페이지 상단 제목 공통-->
			<div class="subPageTop">
				<div class="sub">
                   	<div class="s_top_gp_wrap">
                    	<img src="resources/images/sub_top_02.jpg">
                        <div class="title_wrap">
                           <p>진료과목</p>
                           <p>MNR clinic Medical</p>
						</div>
					</div>
					<nav class="sub_navi">
						<ul>
							<li><a href="${ pageContext.servletContext.contextPath }/main.do" title="홈 바로가기"> <span class="ti-home"></span> Home</a></li>
							<li><a href="/" title="병원 소개">진료과목</a></li>
						</ul>
					</nav>
                </div>
			</div>
			<!-- subPageTop:e 서브페이지 상단 제목 공통-->
			
			<!-- section:medical_serch:s -->
			<section class="medical_serch">
				<!-- serch_tit:s -->
				<div class="serch_tit">
					<h1>
						<span>나에게 <span class="highlighter">딱 맞는</span> </span>
						<span class="line_2">진료과목 찾기</span>
					</h1>
					<p class="serch_txt"> 
						<span>원하시는 #태그를  클릭하시면 관련된 </span><span>진료과목을 찾아보실 수 있습니다.</span>
					</p>
				</div>
				<!-- serch_tit:e -->
				
				<!-- tag_serch:s -->
				<div class="tag_serch">
					<ul class="item">
						<li>
							<a href="${ pageContext.servletContext.contextPath }/serchPage.do" title="전체">
								<span class="item_s_text"># 전체</span>
							</a>
						</li>
						<li>
							<a href="javascript:void(0);" onclick="click1();" title="레이저">
								<span class="item_s_text"># 레이저</span>
							</a>
						</li>
						<li>
							<a href="javascript:void(0);" onclick="click2();" title="보톡스">
								<span class="item_s_text"># 보톡스</span>
							</a>
						</li>
						<li>
							<a href="javascript:void(0);" onclick="click3();" title="필러">
								<span class="item_s_text"># 필러</span>
							</a>
						</li>
						<li>
							<a href="javascript:void(0);" onclick="click4();" title="리프팅">
								<span class="item_s_text"># 리프팅</span>
							</a>
						</li>
						<li>
							<a href="javascript:void(0);" onclick="click5();" title="여드름">
								<span class="item_s_text"># 여드름</span>
							</a>
						</li>
						<li>
							<a href="javascript:void(0);" onclick="click6();" title="남성">
								<span class="item_s_text"># 남성</span>
							</a>
						</li>
					</ul>
				</div>
				<!-- tag_serch:e -->
				
				<!-- form_serch:s -->
				<div class="form_serch">	
					<form action="${ pageContext.servletContext.contextPath }/searchName.do" method="post" id="nameform" class="sform">
						<input type="hidden" name="action" value="name">
						<fieldset>
							<legend>진료과목 검색</legend>
							<input type="search" name="keyword" placeholder="진료과목을 입력하세요.">
							<input type="submit" value="검색">
						</fieldset>
					</form>
				</div>	
				<!-- form_serch:e -->
				
				<!-- hashtag_wrap:s -->
				<div class="hashtag_wrap">
					<ul class="hashtag_list">
						<c:forEach items="${ requestScope.list }" var="md">
							<li>
								<c:url var="mdlist" value="/medicalPage.do">
									<c:param name="mdlist" value="${ md.md_num }"/>
								</c:url>
								<a href="${ mdlist }">
									<!-- <p class="username"># 미앤란클리닉</p> -->
									<p class="username"># ${ md.md_tag } </p>
									<p class="new"></p>
									<p class="name">${ md.md_name }</p>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
				<!-- hashtag_wrap:e -->	
				<div class="advertising_wrap">
					<ul class="adver" style="display: block;">
				        <li>
				            <img src="resources/images/search_img1.jpg" alt="뷰티모델이미지">
				            <h4># 색소레이저</h4>
				            <div>
				                <a href="${ pageContext.servletContext.contextPath }/medicalPage.do?mdlist=11111" title="색소레이저 자세히 보기" class="adver_btn1">자세히 보기</a>
				                <a href="qlist.do?page=1" title="상담하기" class="adver_btn2">상담하기</a>
				                <a href="moveRes.do" title="예약하기" class="adver_btn3">예약하기</a>
				            </div>
				        </li>
				        <li>
				            <img src="resources/images/search_img2.jpg" alt="뷰티모델이미지">
				            <h4># 리프팅</h4>
				            <div>
				                <a href="${ pageContext.servletContext.contextPath }/medicalPage.do?mdlist=22214" title="리프팅 자세히 보기" class="adver_btn1">자세히 보기</a>
				                <a href="qlist.do?page=1" title="상담하기" class="adver_btn2">상담하기</a>
				                <a href="moveRes.do" title="예약하기" class="adver_btn3">예약하기</a>
				            </div>
				        </li>
				        <li>
				            <img src="resources/images/search_img3.jpg" alt="뷰티모델이미지">
				            <h4># 바디보톡스</h4>
				            <div>
				                <a href="${ pageContext.servletContext.contextPath }/medicalPage.do?mdlist=22211" title="바디보톡스 자세히 보기" class="adver_btn1">자세히 보기</a>
				                <a href="qlist.do?page=1" title="상담하기" class="adver_btn2">상담하기</a>
				                <a href="moveRes.do" title="예약하기" class="adver_btn3">예약하기</a>
				            </div>
				        </li>
				    </ul>
			    </div>
			</section>
			<!-- section:medical_serch:e -->
		</div> <!--container:e-->
	</div> <!-- wrap:e -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>