<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<script src="resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

//쿠키설정    
function setCookie( name, value, expiredays )
{
var todayDate = new Date();
todayDate.setDate( todayDate.getDate() + expiredays );
document.cookie = name + '=' + escape( value ) + '; path=/; expires=' + todayDate.toGMTString() + ';'
}


//쿠키 불러오기
function getCookie(name) 
{ 
    var obj = name + "="; 
    var x = 0; 
    while ( x <= document.cookie.length ) 
    { 
        var y = (x+obj.length); 
        if ( document.cookie.substring( x, y ) == obj ) 
        { 
            if ((endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
                endOfCookie = document.cookie.length;
            return unescape( document.cookie.substring( y, endOfCookie ) ); 
        } 
        x = document.cookie.indexOf( " ", x ) + 1; 
        if ( x == 0 ) 
            break; 
    } 
    return ""; 
}
    

//닫기 버튼 클릭시
function closeWin(key)
{
    if($("#todaycloseyn").prop("checked"))
    {
        setCookie('divpop'+key, 'Y' , 1 );
    }
    $("#divpop"+key+"").hide();
}

$(function(){    
    if(getCookie("divpop1") !="Y"){
        $("#divpop1").show();
    }
});

// 슬라이드팝업
$(document).ready(function(){
    
    var popup = new Swiper('.popup', {
       loop:true,
       speed : 600,
       autoplay : {
          delay : 3000,
          disableOnInteraction : false,
       },
       });
 })

</script>

<style>
      
   .new_pop{z-index:99999; position:absolute; top:8%; left:10%; margin:0 0 0 -100px; width:320px;display:none}
   .new_pop .bottom{ overflow:hidden; padding:0 0 0 10px; height:40px; background:#333;}
   .new_pop .bottom label{ display:block; float:left; line-height:40px; font-size:14px; font-weight:inherit; color:#FFF;}
   .new_pop .bottom label input{ display:block; float:left; margin:10px 5px 0 0; width:20px; height:20px;}
   .new_pop .bottom p{ float:right; padding:0 10px; border-left:1px solid #666; text-align:center; line-height:40px; font-size:14px; color:#FFF;}
      </style>

</head>

<body>

<form name="notice_form">

<div id="divpop1" class="new_pop">    

    <div class="swiper-container popup">
            <ul class="swiper-wrapper">
            	<c:forEach items="${ requestScope.plist }" var="p">
                <li class="swiper-slide"><a href="nlist.do?page=1"><img src="resources/pupfiles/${ p.popup_refile }" alt="팝업이미지"></a></li>
            	</c:forEach>
            </ul>
        </div>

      <div class="bottom">

         <label><input type='checkbox' name='chkbox' id='todaycloseyn' value='Y'>24시간동안 열지 않음</label>  

         <a href='#' onclick="javascript:closeWin(1);"><p class="cp">닫기</p></a>

     </div>

</div>

</form>

</body>

</html>