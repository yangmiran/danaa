<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<c:import url="/WEB-INF/views/common/meta.jsp" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<script>
$(function(){
	todayIs();
	 
    function todayIs() {
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; // Jan is 0
        var hours = today.getHours();
        var minutes = today.getMinutes();
        var seconds = today.getSeconds();
        
        if(dd<10){
            dd = '0'+dd
        }
        if(mm<10){
            mm = '0'+mm
        }
 
        today = '( ' + mm + '월 ' + dd + '일 ' + hours + '시  ' + minutes + '분 ' + seconds + '초기준 )';

        document.getElementById("date").innerHTML = today;
    } 
});

//탭 게시판
$( function() {
    $( "#adToptab" ).tabs();
});
</script>

  
<body>
	<div id="adwrap">
		<c:import url="/WEB-INF/views/common/adheader.jsp" />
		<main>
			<!-- main-con:s -->
			<div class="main-con">
				<!-- 타이틀:s -->
				<div class="adtit2">
					<h2>예약 현황</h2>
					<span id="date"></span>
				</div>
				<!-- 타이틀:e -->
				
				<!-- admainSet:s -->
				<div class="admainSet">
                    <div class="admain_boxlist order">
                        <a href="resByDoc.do?res_doctor=1" class="item">
                            <strong class="title">이익준</strong>
                            <span class="count">${ resLeeCount }</span>
                        </a>
                    </div>
                    <div class="admain_boxlist order">
                        <a href="resByDoc.do?res_doctor=2" class="item">
                            <strong class="title">채송화</strong>
                            <span class="count">${ resChaeCount }</span>
                        </a>
                    </div>
                    <div class="admain_boxlist order">
                        <a href="resByDoc.do?res_doctor=3" class="item">
                            <strong class="title">안정원</strong>
                            <span class="count">${ resAhnCount }</span>
                        </a>
                    </div>
                    <div class="admain_boxlist order">
                        <a href="resByStatus.do?res_status=1" class="item">
                            <strong class="title">예약 미확정</strong>
                            <span class="count">${ notYetRes }</span>
                        </a>
                    </div>
                </div>
                <!-- admainSet:e -->
                
                <!-- 타이틀:s -->
				<div class="adtit2">
					<h2>오늘 현황</h2>
				</div>
				<!-- 타이틀:e -->
				
                <!-- admainSet:s -->
				<div class="admainSet">
                    <div class="admain_boxlist2 order">
                        <a href="adpagemove.do" class="item">
                            <strong class="title">회원수</strong>
                            <span class="count">${memberCount}</span>
                        </a>
                    </div>
                    <div class="admain_boxlist2 order">
                        <a href="proEvent.do?page=1" class="item">
                            <strong class="title">진행중 이벤트</strong>
                            <span class="count">${ proEventCount }</span>
                        </a>
                    </div>
                    <div class="admain_boxlist2 order">
                        <a href="rlist.do" class="item">
                            <strong class="title">새 리뷰</strong>
                            <span class="count">${ reviewCount }</span>
                        </a>
                    </div>
                </div>
                <!-- admainSet:e -->
                
                <!-- pagecontent:s -->
				<section class="pagecontent" style="padding: 40px 80px;">
					<!-- inn:s -->
					<div class="inn">
		                <div id="adToptab">
						  <ul class="tab">
						  	<li><a href="#tabs-1">답변 미처리 문의글</a></li>
						  	<li><a href="#tabs-2">후기 조회수 TOP 3</a></li>
						  </ul>
						  
						  <!-- 문의하기 미처리 리스트:s -->
						  <div id="tabs-1">
						  	<div class="admain_listTable">
						  		<a href="qlist.do?page=1" class="btnMore">더보기</a>
								<table>
									<colgroup>
										<col style="*">
										<col style="width:10%">
									</colgroup>
									<tbody>
									<c:forEach items="${ qnalist }" var="q">
										<tr>
											<c:url var="qdetail" value="qdetail.do">
												<c:param name="qna_no" value="${ q.qna_no }" />
											</c:url>
											<td><a href="${ qdetail }">${ q.qna_title }</a></td>
											<td>${ q.qna_date }</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
						  </div>
						  <!-- 문의하기 미처리 리스트:e -->
						  
						  <!-- 후기 미처리댓글 리스트:s -->
						  <div id="tabs-2">
						  	<div class="admain_listTable">
						  	<a href="rlist.do" class="btnMore">더보기</a>
								<table>
									<colgroup>
										<col style="*">
										<col style="width:10%">
									</colgroup>
									<tbody>
										<c:forEach items="${ list }" var="review">
										<tr>
											<td><a href="rdetail.do?review_no=${ review.review_no }&page=${ currentPage }">${ review.review_title }</a></td>
											<td>${ review.review_date }</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
						  </div>
						  <!-- 후기 미처리댓글 리스트:e -->
						</div>
					</div>
				</section>

			</div>
		</main>
	</div>
</body>
</html>