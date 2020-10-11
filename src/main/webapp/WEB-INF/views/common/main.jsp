<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<c:import url="/WEB-INF/views/common/meta.jsp" />
<c:import url="/WEB-INF/views/popup/popup.jsp" />
</head>
<script>

$(function(){
	//진료과목 리스트 : s
	$.ajax({
		url: "mainMedical.do",
		type: "post",
		dataType : "json",
		success: function(data){
			var jsonStr = JSON.stringify(data);
			var json = JSON.parse(jsonStr);
			
			var values = "";
			for(var i in json.list){
					values += "<article class='main1_con_box'>"
						+ "<div class='main1_con'>"
						+	"<div class='main1_tag'>"
						+	"<p>#" + decodeURIComponent(json.list[i].md_tag).replace(/,/gi, "#").replace(/\+/gi, " ") + "</p></div>"
						+	"<img src=resources/images/" + json.list[i].md_filename + " alt='시술 관련 사진' class='main1_img'>"
						+	"<div class='main1_txt'>"
						+		"<h4>" + decodeURIComponent(json.list[i].md_name).replace(/\+/gi, " ") + "</h4>"
						+		"<p class='txt'>" + decodeURIComponent(json.list[i].md_cont).replace(/\+/gi, " ") + "</p>"
						+	"</div>"
						+	"<div class='main1_btn'>"
						+		"<a href='medicalPage.do?mdlist=" + json.list[i].md_num + "' class=" + "main1_btn1>자세히 보기</a>"
						+		"<a href='qlist.do?page=1' title='상담문의' class='main1_btn2'>상담문의</a>"
						+		"<a href='moveRes.do' title='예약하기' class='main1_btn2'>예약하기</a>"
						+	"</div></div></article>";
			}
			
			$("#mainMedical").html($("#mainMedical").html() + values);
		},
		error: function(jqXHR, textstatus, errorthrown){
			console.log("error : " + jqXHR + ", " + textstatus
					+ ", " + errorthrown);
		}
	}); //진료과목 리스트 : e
	
	//최근 등록한 공지글 5개 출력되게 함
	$.ajax({
		url: "ntop5.do",
		type: "post",
		dataType : "json",
		success: function(data){
			console.log("success : " + data);
			
			//object ==> string 으로 변환
			var jsonStr = JSON.stringify(data);
			//string ==> json 객체로 바꿈
			var json = JSON.parse(jsonStr);
			
			var values = "";
			for(var i in json.list){
				values += "<li class='swiper-slide'>"
					+ "<a href='ndetail.do?notice_no="
					+ json.list[i].notice_no + "'>"
					+ "<span class='title'>" + decodeURIComponent(json.list[i].notice_title).replace(/\+/gi, " ") + "</span>"
					+ "<span class='date'>" + json.list[i].notice_date + "</span></a></li>";
			}
			
			$("#newnotice").html($("#newnotice").html() + values);
			
			var swiper3 = new Swiper('.notice', {
		      direction: 'vertical',
		      loop:true,
		      autoplay : {
					delay : 3000,
					disableOnInteraction : false,
				},
		    });
		},
		error: function(jqXHR, textstatus, errorthrown){
			console.log("error : " + jqXHR + ", " + textstatus
					+ ", " + errorthrown);
		}
	});
	
	
});

</script>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/views/common/header.jsp" />
		<!--container:s-->
		<div class="container">
			<!--section main:s-->
			<section id="main">
				<div class="swiper-container mainbn">
					<ul class="swiper-wrapper">
						<c:forEach items="${ requestScope.bnlist }" var="bn">
							<li class="swiper-slide"><img
							src="resources/bupfiles/${ bn.bn_refile }" alt="메인이미지"></li>
						</c:forEach>
					</ul>
					<!-- Add Arrows -->
					<div class="swiper-button-next miannext"></div>
					<div class="swiper-button-prev mianprev"></div>
				</div>
				<script>
					//메인 슬라이드
					var swiper1 = new Swiper('.mainbn', {
						loop : true,
						effect : 'fade',
						speed : 600,
						navigation : {
							nextEl : '.miannext',
							prevEl : '.mianprev',
						},
						autoplay : {
							delay : 3000,
							disableOnInteraction : false,
						},
					});
				</script>
			</section>
			<!--section main:e-->

			<!-- toplist_medical:s -->
			<section class="toplist_medical">
				<div class="main_con main1">
					<div class="main_title">
						<h3>인기 진료과목</h3>
						<p>Popular medical Subjects</p>
					</div>
					<div id="mainMedical" class="main1_con_wrap">
						<!-- ajax -->
					</div>
				</div>
			</section>
			<!-- toplist_medical:e -->

			<!-- mainevent:s -->
			<section class="mainevent">
				<div class="main_title">
					<h3>미앤란 이벤트</h3>
					<p>mnr clinic event</p>
				</div>
				<div class="swiper-container mainev">
					<ul class="swiper-wrapper">
						<c:forEach items="${requestScope.evlist}" var="ev">
						<li class="swiper-slide">
							<a href="edetail.do?event_no=${ ev.event_no }"> 
								<img src="resources/eupfiles/${ ev.event_file }" alt="이벤트이미지">
								<p>${ ev.event_title }</p>
							</a>
						</li>
						</c:forEach>
					</ul>
					<!-- Add Arrows -->
					<div class="swiper-button-next evnext ti-angle-right"></div>
					<div class="swiper-button-prev evprev ti-angle-left"></div>
				</div>

				<script>
				//이벤트 슬라이드
				
				var swiper2 = new Swiper('.mainev', {
					slidesPerView : 7,
					spaceBetween : 50,
					slidesPerGroup : 1,
					loopFillGroupWithBlank: true,
					loop:true,
					navigation : {
						nextEl : '.evnext',
						prevEl : '.evprev',
					},
					autoplay : {
						delay : 3000,
						disableOnInteraction : false,
					},
					});
				
				</script>
			</section>
			<!-- mainevent:e -->

			<section class="topnotice">
				<div class="topnotice_in">
					<div class="main_notice">
						<div class="inner_main">
							<div class="h_group">
								<h2 class="main_title"><a href="#">공지사항 <span class="ti-plus"></span></a></h2>
							</div>
							<div class="swiper-container notice">
								<ul id="newnotice" class="list swiper-wrapper">
									
								</ul>
							</div>
							
						</div>
					</div>
				</div>
			</section>
		</div>
		<!--container:e-->
		
		<c:import url="/WEB-INF/views/common/footer.jsp" />
		
		<script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
		<df-messenger
			intent="WELCOME"
			chat-title="DANAA"
			agent-id="551876d1-c6d1-4dbe-bd99-39a20eca72ae"
			language-code="ko"
			chat-icon="https://cdn.glitch.com/f6c828b6-98fe-49dd-b777-da4cb7a2d036%2F20200918170604.png?v=1600603359370">
		</df-messenger>
		
	</div>
</body>
</html>