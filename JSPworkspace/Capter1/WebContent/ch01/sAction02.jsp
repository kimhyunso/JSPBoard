<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
    <title>sAction01.jsp </title>

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
		<h2>자바 프로퍼티 설정 및 가져오기</h2>
	</header>
	
	<!-- 객체 선언과 getter/setter -->
	
	<p>
		<jsp:useBean class="kr.co.itbank.network.Car" id="texi"/>
		<jsp:setProperty property="speed" name="texi" value="77"/>
		<jsp:setProperty property="color" name="texi" value="RED"/>
		
		<jsp:useBean class="kr.co.itbank.network.Car" id="bus"/>
		<jsp:setProperty property="speed" name="bus" value="33"/>
		<jsp:setProperty property="color" name="bus" value="빨강"/>
	</p>
	
	<h3>속성값 확인</h3>
	taxi 정보 <br>
	속도 : <jsp:getProperty property="speed" name="texi"/><br>
	색상 : <jsp:getProperty property="color" name="bus"/><br>
	
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>