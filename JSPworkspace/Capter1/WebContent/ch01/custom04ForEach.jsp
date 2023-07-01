<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>custom03IF.jsp </title>

    <!-- Bootstrap -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <link href="./css/custom2.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
<body>

<div class="container">

	<header>
		<h2>JSTL Custom Action</h2>
	</header>
	
	<p>
		forEach (자바 for)<br><br>
		
		left = 5, right = 7 5단의  5 * 7까지 계산하기<br>
		만약에 left와 right가 없으면 에러 메세지 보내주기<br>
		
		<c:if test="${empty param.left or empty param.right }">
			Error : parameter is empty
		</c:if>
		
		<c:if test="${not empty param.left and not empty param.right }">
			<c:forEach var="cnt" begin="1" end="${param.right }" step="1" >
				${param.left } * ${cnt } = ${param.left * cnt } <br>
			</c:forEach>
		</c:if>
		
		<!--
		<c:forEach var="cnt" begin="1" end="100" step="5">
			<font size="${cnt }px">Font Size ${cnt }</font> <br>
		</c:forEach>
		-->
	</p>
	
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>