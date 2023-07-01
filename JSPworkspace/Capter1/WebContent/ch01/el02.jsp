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
    <title>el02.jsp </title>

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

	기존 방식 : 합 = <%=request.getAttribute("resultSum") %> <br>
	EL 방식 합 : ${resultSum } <br>
	EL 방식에 연산 : ${resultSum + 1000 } <br>

	원래 우선순위 page > request > session > application 순서<br>
	${page.name } ${request.name } 
	${sessionScope.name } ${application.name }

	
	<a href='appSet.jsp'>이전 페이지 이동</a>
	
	
	
	
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>