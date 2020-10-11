<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<html>
<head>
    <title>MNR CLINIC</title>
<style type="text/css">    
/* 모달 윈도우 디자인 */
alert {
  position:fixed;
  display:block;
  width:300px;
  height:150px;
  top:50%;
  left:50%;
  margin-top:-75px;
  margin-left:-150px;
  background:#d9e5e9;
  border:1px solid #386980;
  overflow:hidden;  
  }
 </style>  
</head>
<body>
<script>
    alert('${message}');
    location.href='<c:out value="${pageContext.request.contextPath}"/>${url}';

</script>
</body>
</html>
