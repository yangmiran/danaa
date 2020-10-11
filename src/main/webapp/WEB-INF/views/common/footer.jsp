<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function(){
	$.ajax({
		//AdminController.java위치에 작성
		url: "footer.do",
		type: "post",
		dataType : "json",
		success: function(data){
			//json 객체 한 개를 받았을 때는 바로 출력 처리할 수 있음
			//console.log("data : " + data);
			
			//object ==> string 으로 변환
			var jsonStr = JSON.stringify(data);
			//string ==> json 객체로 바꿈
			var json = JSON.parse(jsonStr);
			 $("#adminName1").html(decodeURIComponent(json.admin_name.replace(/\+/gi, " ")));
			 $("#adminName2").html(decodeURIComponent(json.admin_name.replace(/\+/gi, " ")));
			 $("#adminPerson").html(decodeURIComponent(json.admin_person.replace(/\+/gi, " ")));
			 $("#adminNo").html(decodeURIComponent(json.admin_no.replace(/\+/gi, " ")));
			 $("#adminTel").html(decodeURIComponent(json.admin_tel.replace(/\+/gi, " ")));
			 $("#adminFax").html(decodeURIComponent(json.admin_fax.replace(/\+/gi, " ")));
			 $("#adminAdd1").html(decodeURIComponent(json.admin_add).replace(/\+/gi, " ").replace(/,/gi, " "));
			 $("#adminAdd2").html(decodeURIComponent(json.admin_add).replace(/\+/gi, " ").replace(/,/gi, " "));
			 $("#adminTime").html(decodeURIComponent(json.admin_time.replace(/\+/gi, " ")));
		},
		error: function(request, status, errorData){
			console.log("error code : " + request.status
					+ "\nMessage : " + request.responseText
					+ "\nError : " + errorData);
		}
	});
	
});
</script>
<div id="d1"></div>

<footer id="footer">
	<div class="footer_in">
		<div class="cont">
			<div class="footer_info">
				<div class="footer_map">
					<!-- * 카카오맵 - 지도퍼가기 -->
					<!-- 1. 지도 노드 -->
					<div id="daumRoughmapContainer1599715578408" class="root_daum_roughmap root_daum_roughmap_landing"></div>
					
					<!--
						2. 설치 스크립트
						* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
					-->
					<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
					
					<!-- 3. 실행 스크립트 -->
					<script charset="UTF-8">
						new daum.roughmap.Lander({
							"timestamp" : "1599715578408",
							"key" : "2zyek",
							"mapWidth" : "652",
							"mapHeight" : "370"
						}).render();
					</script>
				</div>

				<!-- 시간및링크 -->
				<div class="footerlist">
					<!-- 주소 -->
					<div class="Add">
						<b>· 을지로본점</b>
						<p id="adminAdd1"></p>
					</div>
					<!-- //주소 -->
					<section>
						<!-- 진료시간 -->
						<div class="Time">
							<b>· 진료시간 안내</b>
							<ul>
								<li id="adminTime"></li>
								<li>평일 점심시간: pm13:00~pm14:00</li>
								<li>일요일/공휴일 휴무</li>
							</ul>
						</div>
						<!-- 진료시간 -->
					</section>

					<!-- 주차정보 -->
					<div class="Parking">
						<b>· 주차안내</b>
						<ul>
							<li>병원 건물 주차장 주차 가능</li>
							<li>신한은행 주차장 주차 가능 (서울특별시 중구 남대문로 120 대일빌딩)</li>
							<li>강남 주차장 주차 가능 (서울특별시 중구 남대문로 120 대일빌딩)</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!-- footer_bottom:s -->
		<div class="footer_bottom">
			<div class="InnerContainer">
				<dl>
					<dt>
						<a href="${ pageContext.servletContext.contextPath }/main.do" class=" BranchFor "><img src="resources/images/logo_w.png" alt="미앤란로고"></a>
					</dt>
					<dd>
						주소 : <span id="adminAdd2"></span> / 대표 : <span id="adminPerson"></span><br>
						사업자등록번호 : <span id="adminNo"></span> / 사업자명 : <span id="adminName1"></span> / 
						사이트명 : <span id="adminName2"></span> / 대표전화 : <span id="adminTel"></span> / 
						팩스번호 : <span id="adminFax"></span><br>
						Copyright(c) 2003~2020 danaa.co.kr All rights reserved.
					</dd>
				</dl>
			</div>
		</div>
		<!-- footer_bottom:e -->
	</div>
</footer>