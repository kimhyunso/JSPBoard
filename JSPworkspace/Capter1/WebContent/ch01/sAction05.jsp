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
    <title>sAction05.jsp </title>

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
		<h2>자바 설정 후 포워드 결과 확인</h2>
	</header>
	
	<p>
		<jsp:useBean class="kr.co.itbank.network.Car" id="TaxiInfo" scope="request"/>
		Taxi 정보 <br>
		속도 : <jsp:getProperty property="speed" name="TaxiInfo" /><br>
		색상 : <jsp:getProperty property="color" name="TaxiInfo" /><br>
	</p>
	
	<br><br>
	<br><br>
	
	<p>
		<jsp:useBean class="kr.co.itbank.network.Car" id="BusInfo" scope="request"/>
		Bus 정보 <br>
		속도 : <jsp:getProperty property="speed" name="BusInfo" /><br>
		색상 : <jsp:getProperty property="color" name="BusInfo" /><br>
	</p>
	
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>