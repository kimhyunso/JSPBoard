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
    <title>el05operator.jsp </title>

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
		EL에 사용되는 연산자 <br>
		산술연산자 : +, -, * , /, %, div , mod <br>
		비교연산자 : >, < , >=, <= , ==, !=, gt, lt, ge, le, eq, ne<br>
		논리연산자 : &&, ||, !, and, or, not <br>
		조건연산자 : ? 참일때 : 거짓일때 <br>
		엠프티연산자 : empty <br>
		대괄호, 마침표 연산자<br>
		괄호 : 연산자의 우선순위를 바꿀 때 사용<br>
	</p>
	
	<p>
	<form class="form-horizontal" role="form" method="post" action="el06Result.jsp">
		<div class="form-group">
			<label for="num1" class="col-md-2 visible-md visible-lg text-right">숫자1</label>
			<div class="col-md-10">
				<input type="number" name="num1" class="form-control" placeholder="(필수)숫자를 입력하세요">
			</div>
		</div>
		
		<div class="form-group">
			<label for="num2" class="col-md-2 visible-md visible-lg text-right">숫자2</label>
			<div class="col-md-10">
				<input type="number" name="num2" class="form-control" placeholder="(필수)숫자를 입력하세요">
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-md-12 text-right">
				<button type="submit" class="btn btn-success">계산 실행</button>
			</div>
		</div>
	</form>
	</p>

	<br><br>	 	
	<a href='el03input.jsp'>이전 페이지 이동</a>
	
	
	
	
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>