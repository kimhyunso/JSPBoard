<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>예외처리</title>

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
		<h2>파일 업로드</h2>
	</header>

	<div class="form-group">
		<form  role="form" class="inline-form" enctype="multipart/form-data" method="post" action="jsp16.jsp">
		<div class="container">
			<div class="row">		
				<label for="text">첨부파일</label>
				<input type="file" class="form-control" name="upfile" placeholder="입력하세요">
			</div>
			
			<div class="row">
				<button type="submit" class="btn btn-default btn-primary">확인</button>
			</div>
		</div>
			
			
		</form>
	</div>
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>