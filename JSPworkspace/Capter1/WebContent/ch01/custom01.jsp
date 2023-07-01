<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="num1" value="11"></c:set>
<c:set var="num2" value="7"></c:set>
<c:set var="result" value="${num1+num1}" ></c:set>

<c:set var="MODEL" value="노트북컴퓨터" scope="request"/>
<c:set var="CODE" value="PC001" scope="request"/>
<c:set var="PRICE" value="12345" />

<jsp:forward page="custom02.jsp"></jsp:forward>

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
    <title>custom01.jsp </title>

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
		두 수 : ${num1 }, ${num2 }<br> 
		합 : ${result } <br>
		합2 : ${num1 +num2 }<br>
		${num1 } * ${num2 } = ${num1 * num2 }<br>
		${num1 } / ${num2 } = ${num1 div num2 }<br>
		${num1 > num2 ? num1 : num2 } <br> 
	</p>
	
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>