<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
 <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>JSP 공부하기</title>

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
		<h2>Bootstrap Tag List</h2>
	</header>

	<div class="form-group">
		<form role="form" method="post" action="calculate">
			<label for="text">num1</label>
			<input type="text" class="form-control" name="num1" placeholder="입력하세요">
			
			<label for="text">num2</label>
			<input type="text" class="form-control" name="num2" placeholder="입력하세요">
			
			<button type="submit" class="btn btn-default btn-primary">계산하기</button>
		</form>
	</div>
</div>
    <script src="./js/bootstrap.min.js"></script>
</body>
</html>