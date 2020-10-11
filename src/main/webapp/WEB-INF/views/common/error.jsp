<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MNR CLINIC</title>
<c:import url="/WEB-INF/views/common/meta.jsp" />
</head>
<style>
.er_wrap {padding: 250px 0 100px;border-bottom: 1px solid #ccc;text-align: center;}
.er_wrap a {background:#095989;color:#fff;padding: 5px 10px;}
</style>
<body>
<c:import url="/WEB-INF/views/common/header.jsp" />
<div class="er_wrap">
	<h1>에러 페이지</h1>
	<% if(exception != null){ //다른 jsp 페이지에서 발생한 에러일 때  %>
	<h3>jsp 페이지 오류 발생 : <%= exception.getMessage() %></h3>
	<% }else{ //서블릿에서 포워딩한 오류 메세지일 때 %>
	<h3>Servlet 메세지 : <%= request.getAttribute("message") %></h3>
	<% } %>
	<br>
	<a href="${ pageContext.servletContext.contextPath }/main.do">시작페이지로 이동</a>
</div>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>