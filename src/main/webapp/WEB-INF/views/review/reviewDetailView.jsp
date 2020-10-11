<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="currentPage" value="${ requestScope.currentPage }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLININC</title>

<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<!--맨 밑 footer만 보이게 설정-->
<style type="text/css">
#footer .footer_in .cont {
	display: none;
}
</style>
<script>

	function selectRecommnetList() {
		$
				.ajax({
					url : "relist.do",
					type : "post",
					dataType : "json",
					data : {
						recomment_ref : '${review.review_no}'
					},
					success : function(data) {

						console.log("success : " + data);

						var jsonStr = JSON.stringify(data);
						var json = JSON.parse(jsonStr);
						var values = "";
						
						for ( var i in json.list) {   

							/* alert("json.list[i]" +json.list[i].recomment_no); */
								values += '<tr><td><textarea id="txtupdate_'
									+ i + '" rows="50">'
										+ decodeURIComponent(
												json.list[i].recomment_content)
												.replace(/\+/gi, " ")
										+ "</textarea></td><td>"
										+ decodeURIComponent(
												json.list[i].recomment_writer)
												.replace(/\+/gi, " ")
										+ "</td><td>"

										+ json.list[i].recomment_date
										+ "</td><td>"
										+ '<input type="button" id="btnupdate_'
										+ i
										+ '" class="jmboard_btn reviewbtn_common" value="댓글수정" onclick="recommentupdate('
										+ i
										+ ', '
										+ json.list[i].recomment_no
										+ '); return false;"> &nbsp'
										+ '<input type="button"  id="btndelete_"'
										+ i
										+ ' class="jmboard_btn reviewbtn_common"  value="댓글삭제" onclick="recommentdelete('
										+ json.list[i].recomment_no + ', '
										+ '${review.review_no}'+ '); return false;">'
										+ "</td></tr>";
						

						} //for in문 종료
						console.log("list" + values);
						 if(values==""){
					    	 /* console.log('먹히나'); */
					    	 document.all.rlistheader.style.display="none";

					    	
					     }
							$("#relist").html($("#relist").html() + values);
						
						
					},
					error : function(jqXHR, textstatus, errorthrown) {
						console.log("error : " + jqXHR + ", " + textstatus
								+ ", " + errorthrown);
					}
				});// ajax

	} //selectRecommnetList

	$(function() {
		//selectRecommnetList();

		$("#btncomment").click(function() {
			/* console.log("나온다"); */
			var recomment_content = $("#recomment_content").val();
			var recomment_writer = "${ loginMember.id }";
			var recommnet_ref = "${ review.review_no }";
			var param = {
				"recomment_content" : recomment_content,
				"recomment_writer" : recomment_writer,
				"review_no" : "${ review.review_no }",
				"page" : "${ currentPage }"
				
			};
			location.href="reinsert.do?recomment_content=" + recomment_content + "&recomment_writer=" + recomment_writer
					+ "&review_no=${ review.review_no }&page=${ currentPage }";

			/* $.ajax({
				type : "post",
				url : "reinsert.do",
				data : param,
				success : function(data) {
					alert("댓글이 등록되었습니다.");
					selectRecommnetList();
					location.reload();
				}
			}); // ajax */
		}); // click
		
    
		
		
	}); //document ready
</script>
</head>
<body>

	<c:import url="/WEB-INF/views/common/meta.jsp" />
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<hr>

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

	<section id="container" class="reviewjmboard">
		<div class="reviewjmboard_box">
			<!-- plain_view -->
			<div class="reviewplain_view">
				<div class="reviewplain_view_title">
					<ul class="reviewplain_view_title1">
						<li><h4>${ review.review_title }</h4></li>
						<li><fmt:formatDate value="${ review.review_date }"
								type="date" pattern="yyyy/MM/dd" /></li>
					</ul>
					<ul class="reviewplain_view_title2">
						<li>${ review.review_writer }</li>
					</ul>
				</div>

				<div class="reviewplain_view_con">
					<li><c:if test="${ !empty review.review_original_filename }">
							<img src="resources/images/${ review.review_rename_filename }">
							<br>
							<br>
						</c:if> <c:if test="${ empty review.review_original_filename }"></c:if>
						<h4>${ review.review_content }</h4></li>
				</div>

				<div class="reviewprevnext">
					<div class="reviewprevlist">
						<c:if test="${ !empty prevReview }">
							<c:url var="urp" value="rdetail.do">
								<c:param name="review_no" value="${ prevReview.review_no }" />
								<c:param name="page" value="${ currentPage }" />
							</c:url>
							<a href="${ urp }" id="link2"><strong>이전글</strong></a>
							<p>
						</c:if>
						<c:if test="${ empty prevReview }">
							이전글이 존재하지 않습니다							
							</c:if>
						</p>
					</div>

					<div class="reviewnextlist">
						<c:if test="${ !empty nextReview }">
							<c:url var="urn" value="rdetail.do">
								<c:param name="review_no" value="${ nextReview.review_no }" />
								<c:param name="page" value="${ currentPage }" />
							</c:url>
							<a href="${ urn }" id="link"><strong>다음글</strong></a>
							<p>
						</c:if>
						<c:if test="${ empty nextReview }">
								다음글이 존재하지 않습니다
								</c:if>
						</p>
					</div>
				</div>


				<c:url var="url" value="rlist.do">
					<c:param name="page" value="${ currentPage }" />
				</c:url>

				<c:url var="rdel" value="rdelete.do">
					<c:param name="review_no" value="${ review.review_no }" />
					<%-- <c:param name="review_level" value="${ review.review_level }" /> --%>
				</c:url>

				<c:url var="rup" value="reviewUpdateForm.do">
					<c:param name="review_no" value="${ review.review_no }" />
					<c:param name="page" value="${ currentPage }" />
				</c:url>


				<div class="reviewlist_util reviewplain_view_btn">
					<button onclick="javascript:location.href=' ${ url }'"
						class="jmboard_btn reviewbtn_black" style="margin-right: 5px;">목록</button>
					
					<button id="update" onclick="javascript:location.href=' ${ rup }'"
						class="jmboard_btn reviewbtn_common">수정</button>
					 <a href=" ${ rdel }" id="delete"
						class="jmboard_btn reviewbtn_white">삭제</a>
				</div>
				<script>
					$(function() {
						$('#delete')
								.click(
										function() {
											if (alert("삭제하시겠습니까?")) {
												location.href = "rdelete.do?review_no=${ review.review_no }";
											}
										});
					});

					$(function() {
						$('#update')
								.click(
										function() {
											if (alert("수정하시겠습니까?")) {
												location.href = "rupdate.do?review_no=${ review.review_no }";
											}
										});
					});
				</script>


				<script>
					function recommentupdate(index, recomment_no) {

						// 댓글 수정 버튼
						if (confirm("수정하시겠습니까?")) {
							console.log("dididididi");
							
							var urecomment_content = $("#txtupdate_"+ index).val(); 
							/* alert("recomment_content ${ requestScope.review.review_no }${ requestScope.currentPage }");   */
							location.href="reupdate.do?recomment_no="+recomment_no + "&review_no=${ requestScope.review.review_no }&page=${ requestScope.currentPage }&recomment_content=" + urecomment_content;
							
						} // if
					}

					function recommentdelete(recomment_no, review_no) {
						if (confirm(recomment_no + " 번 댓글 삭제하시겠습니까?")) {
								location.href="redelete.do?recomment_no="+recomment_no + "&review_no="+review_no + "&page=${ requestScope.currentPage }";
								
							
						} // if
						
					}
				</script>

				<c:if test="${ loginMember.id != null }">
					<h2>
						<strong class="recomment_title">COMMENT</strong>
					</h2>
					<textarea style="width: 900px; float: left; margin-right: 5px;"
						rows="3" cols="30" id="recomment_content" name="recomment_content"
						onfocus="this.value='';"></textarea>
					<button type="button" id="btncomment"
						class="jmboard_btn reviewbtn_common" align="left">등록</button>
				</c:if>
				<br style="clear: both;">
				<br>
				
				<c:if test="${ listsize >0}">
				<div style=" margin: 0 auto;" id="rlistheader" class="com_list">
					<div class="reviewlist_cmt">
						<table id="relist"  cellspacing="0" style="margin: 0 auto;">
							<tr class="top">
								<th width="600">내용</th>
								<th width="100">작성자</th>
								<th width="150">날짜</th>
								<th width="250">&nbsp;</th>
							</tr>
							
							<c:forEach items="${ list }" var="recomment" varStatus="status">
								<tr class="list">
								<th width="600"><textarea id="txtupdate_${ status.index }" rows="50" style="width: 100%;">${ recomment.recomment_content }</textarea></th>
								<th width="100">${ recomment.recomment_writer }</th>
								<th width="150">${ recomment.recomment_date }</th>
								<th width="250">
								<input type="button" id="btnupdate_${ status.index }" class="jmboard_btn reviewbtn_common" 
								value="수정" 
								onclick="recommentupdate(${ status.index },${ recomment.recomment_no });return false;">&nbsp
								
								<input type="button"  id="btndelete_<input type="button" id="btnupdate_${ status.index }" 
								class=jmboard_btn reviewbtn_common" value="삭제"
								onclick="recommentdelete(${ recomment.recomment_no }, ${ review.review_no });return false;">
								</th>
								</tr>
							</c:forEach>
						</table> 
						
						
					</div>
				</div>
				</c:if>
				
	</section>
	<br>
	<br>
	<br>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>