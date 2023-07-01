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
    <title>custom03Catch.jsp </title>

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
		catch (try ~ catch)<br>
		num1, num2 <br>
		<c:if test="${empty param.num1 or empty param.num2 }">
			Usage : custom07Catch?num1=5&num2=7
		</c:if>		
		
		<c:if test="${not empty param.num1 and not empty param.num2 }">
			num1 = ${param.num1 }, num2 = ${param.num2 }<br>
			<c:catch var="e">
				${param.num1 } / ${param.num2 } = ${param.num1 / param.num2 }<br>
				<%
					int result = 4/0;
				%>
			
			</c:catch>
			
			<c:if test="${not empty e }">
				에러 발생 원인 : ${e.message }
			</c:if>
			
		</c:if>
		
	</p>
	
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>