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
<c:import url="/WEB-INF/views/common/meta.jsp" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src='https://www.google.com/recaptcha/api.js'></script>
<script src="resources/ckeditor/ckeditor.js"></script>

<script>

// 리캡챠 ajax
 function qnawrite(){
	var flag = true;
    $.ajax({
    url: 'VerifyRecaptcha.do',
    type: 'post',
    async: false,
    data: {
      recaptcha: $("#g-recaptcha-response").val()
      },
      success: function(data) {
         switch (data) {
            case 0:
               alert("문의글 등록이 완료 되었습니다.");
               flag=true;
               break
 
            case 1:
               alert("자동 입력 방지봇을 확인 한 뒤 진행 해 주세요.");
               flag=false;	
               break
 
            default:
               alert("자동 입력 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
               flag=false;	
                            
     		}
      	 }
     });
    return flag;
}
</script>

<script type="text/javascript">
//유효성검사 정규식
function checkz() {
  var name= RegExp(/^[가-힣]+$/);
  var pw= RegExp(/^[0-9]{4,8}$/);
  var phone = RegExp(/^\d{3}-\d{3,4}-\d{4}$/);
  var title = $("#title").val().replace(/\s|/gi,'');
  var contents = $("#contents").val().replace(/\s|/gi,'');
  
//이름 유효성
  if (!name.test($("#name").val())) {
    alert("형식에 맞춰서 이름을 입력해 주세요");
    $("#name").val("");
    $("#name").focus();
    return false;
  }
  
//비밀번호
  if(!pw.test($("#pw").val())) {
  alert("형식에 맞춰서 비밀번호를 입력해 주세요");
  $("#pw").val("");
  $("#pw").focus();
  return false;
  }
  
//전화번호
  if(!phone.test($("#phone").val())){
	  alert("형식에 맞춰서 전화번호를 입력해 주세요");
	  $("#phone").val("");
	  $("#phone").focus();
	  return false;
  }
  
//제목란 유효성 검사
//공백이 있다면 안됨.
if(title==""){
  alert("제목을 입력해주세요");
  $("#title").val("");
  $("#title").focus();
  return false;
}   
  
//내용란 유효성 검사
//공백이 있다면 안됨.
if(contents==""){
  alert("내용을 입력해주세요");
  $("#contents").val("");
  $("#contents").focus();
  return false;
} 

return qnawrite();
}
</script>

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
		<form action="qinsert.do" method="post" enctype="multipart/form-data" class="write_form" onsubmit="return checkz();">
			
			<h2 class="red" align="center"><b>*</b>문의글 작성하기</h2>

			<div class="box">
				<p>이름 <b>*</b></p>
				<div class="input">
					<input type="text" name="qna_name" id="name" class="input1" maxlength="4" placeholder="한글 최대 4글자">
				</div>
			</div>

			<div class="box pw">
				<p>비밀번호 <b>*</b></p>
				<div class="input">
					<input type="password" name="qna_pwd" id="pw" class="input1" maxlength="8" placeholder="숫자 4~8자리">
					<span class="red" style="display:block">※ 내용 확인 및 글 수정/삭제 시 필요합니다.</span>
				</div>	
			</div>

			
			<div class="box">
				<p>연락처 <b>*</b></p>
				<div class="input">
					<input type="text" name="qna_phone" class="input1" id="phone" maxlength="13" placeholder="(ex) 010-1234-5678">
					
				</div>
			</div>
			
			<div class="box">
				<p>문의종류 <b>*</b></p>
				<div class="input">
					<select name="qna_kinds" class="input1" id="item" style="display: inline-block;">
							<option value="일반문의">문의종류를 선택해 주십시오 (미선택시 일반문의)</option>
							<option value="상담예약">상담예약</option>
							<option value="레이저문의">레이저문의</option>
							<option value="보톡스문의">보톡스문의</option>
							<option value="필러문의">필러문의</option>
							<option value="리프팅문의">리프팅문의</option>
							<option value="피부케어">피부케어</option>
					</select>
					<div class="item_box" style="display: none;">
						
					</div>
				</div>
			</div>

			<div class="box">
				<p>제목 <b>*</b></p>
				<div class="input">
					<input type="text" name="qna_title" id="title" class="input1" placeholder="제목" >
				</div>
			</div>
			

			<div class="box contents">
				<p>내용 <b>*</b></p>
				<div class="input">
				<textarea rows="5" cols="50" id="contents" name="qna_content" placeholder="내용을 입력 하세요."></textarea>
				</div>
			</div>
			
			<div class="box">
				<p>파일선택 </p>
				<div class="input">
				<input type="file" name="ofile">		
				</div>
			</div>
		<!-- //write_form -->

		<div class="write_btn_box">
		<div class="g-recaptcha" data-sitekey="6LeFfs0ZAAAAAG_lROezDJSy6EcsPvZ3G3Yl6u2K"></div>
			<input type="submit" id="writeBtn" class="jmboard_btn btn_common" value="등록하기">
			<input type="button" value="목록" onclick="javascript:history.go(-1); return false;" id="cancelBtn" class="jmboard_btn btn_white">
		</div>
	</form>
</div>
</section>
	<script>
         CKEDITOR.replace("qna_content", { 
            height:"400"
         });
    </script>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>