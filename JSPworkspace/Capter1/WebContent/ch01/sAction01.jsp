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
		<h2>Standard Action(표준 액션)</h2>
	</header>
	
	<p>
		saction01.jsp 파일입니다.<br>
		
		<!-- 
			forward는 가면 제어권이 넘어간다.
			가면 안온다.
			
			include는 갔다가 제어권이 다시 내게로 넘어온다.
			가면 돌아온다.
		 -->
		
		<!--  
		<jsp:include page="el03Input.jsp"></jsp:include>	
		-->	
		
		<jsp:forward page="el03Input.jsp"></jsp:forward>
		
		saction01.jsp의 마지막 부분입니다.<br>
	</p>
	
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>