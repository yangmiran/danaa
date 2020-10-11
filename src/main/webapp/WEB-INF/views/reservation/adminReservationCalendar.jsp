<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
	<c:import url="/WEB-INF/views/common/meta.jsp" />
	<link href='resources/css/calendar1.css' rel='stylesheet' />
	<link href='resources/css/calendar2.css' rel='stylesheet' />
	<script src='resources/js/calendar1.js'></script>
	<script src='resources/js/calendar2.js'></script>
	<script src='resources/js/calendar3.js'></script>	
	<script>		
		document.addEventListener('DOMContentLoaded', function() {			
			var calendarEl = document.getElementById('calendar');	
			var calendar = new FullCalendar.Calendar(calendarEl, {				
				plugins: [ 'interaction', 'dayGrid', 'timeGrid', 'list'],
				header: {
					left: 'prevYear,prev,next,nextYear today',
					center: 'title',
					right: 'dayGridMonth,dayGridWeek,dayGridDay'
				},
				locale : "ko",
				navLinks: true, // can click day/week names to navigate views
				eventLimit: true, // allow "more" link when too many events
				events:[
					<c:forEach var="r" items="${ list }">
						{
							url:'addetailRes.do?rno=${ r.res_no }',
					        title:'${ r.res_time } ${ r.res_name }  (${ r.res_doctor })',
					        start: '${ r.res_date }'
						},
					</c:forEach>
				]
			});	
			calendar.render();	    
		});		
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
					<li>예약관리</li>
					<li class="now" title="현재 위치">예약확인</li>
				</ol>
				<h2>예약확인</h2>
			</div>
			
			<div class="input-btn0">      
	       			<input type="button" value="리스트로 보기" onclick="location.href='adcheckRes.do';">
	     	</div>
			
			<section class="pagecontent">
				<div class="inn">
					<div id='calendar'>	</div>
				</div>
			</section>
		</div> <!-- main-con:e -->		
	</main>
</div>  
</body>
</html>