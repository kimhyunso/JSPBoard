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
    <title>el04print.jsp </title>

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

	제목(이전방식) <%=request.getParameter("title") %><br>
	이름(이전방식) <%=request.getParameter("name") %><br><br>
	
	<h2>EL 방식으로 확인하기</h2>
	제목 1 : ${param.title }<br>
	이름 : ${param.name }<br>
	주소 : ${param.address }<br>
	전화 : ${param.mobile } <br>
	연령 : ${param.age }<br>
	메모 : ${param.memo }<br>
	
	
	<br><br>
	 	
	<a href='el03input.jsp'>이전 페이지 이동</a>
	
	
	
	
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>