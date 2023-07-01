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
		파라미터값을 확인<br>
		num1 = ${param.num1 }<br>
		num2 = ${param.num2 }<br>
		custom03IF.jsp?num1=33&num2=44<br>
		
		<c:if test="${param.num1 ge param.num2 }">
			큰 값은${param.num1}이다 <br>
		</c:if>
		
		<c:if test="${param.num1 lt param.num2 }">
			큰 값은 ${param.num2 }이다 <br>
		</c:if>
		
		num1 이 홀수인지 짝수인지 출력하는 프로그램으로 만들어라.<br>
		입력한 33은 홀수입니다.<br>
		else 가 없다.<br><br>
		<c:if test="${empty param.num1 or empty param.num2 }">
			파라미터가 비어있습니다.<br>
		</c:if>
		
		
		<c:if test="${not empty param.num1 and not empty param.num2 }">
			<c:if test="${param.num1 mod 2 eq 0}">
				입력한 ${param.num1 }은 짝수 이다. <br>
			</c:if>
			<c:if test="${param.num1 mod 2 ne 0}">
				입력한 ${param.num1 }은 홀수 이다.<br>
			</c:if>
		</c:if>
		
		<!--
		<c:if test="${param.num1 ne NULL}">
			<c:if test="${param.num1 mod 2 eq 0}">
				입력한 ${param.num1 }은 짝수 이다. <br>
			</c:if>
		
			<c:if test="${param.num1 mod 2 ne 0}">
				입력한 ${param.num1 }은 홀수 이다.<br>
			</c:if>
		</c:if>
		
		<c:if test="${param.num1 eq NULL }">
			파라미터가 없습니다. <br>
		</c:if>
		-->
		
		지금까지의 과정을 num1 과 num2가 있을 때 수행하고, 없으면 파라미터가 없습니다.
	</p>
	
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>