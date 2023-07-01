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
    <title>el06result.jsp </title>

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
		<h2>Expression Language(표현언어, EL)</h2>
	</header>

	<p>
		입력 문자 1 = ${param.num1 }, 2 = ${param.num2 }<br>
		합 = ${param.num1 + param.num2 } <br>
		차 = ${param.num1 - param.num2 } <br>
		mod = ${param.num1 % param.num2 } <br>
		div = ${param.num1 div param.num2 }<br>
		
		큰값 = ${param.num1 gt param.num2 ? param.num1 : param.num2 }<br>
		같은가 = ${param.num1 eq param.num2 }<br>
		다른가 = ${param.num1 ne param.num2 }<br>
		
		비었는가? ${empty param.num1}<br>
		비지 않았는가? ${not empty param.num1}<br>
	</p>

	<br><br>	 	
	<a href='el05operator.jsp'>이전 페이지 이동</a>
	
	
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>