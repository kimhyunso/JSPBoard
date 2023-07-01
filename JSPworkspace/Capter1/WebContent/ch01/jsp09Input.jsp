<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 지시자 -->

<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>jsp09</title>

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
		<h2>사용자 정보 입력</h2>
	</header>

	<div class="form-group">
		<form role="form" class="inline-form" method="post" action="jsp10.jsp">
			<div class="row">
				<label for="text">이름</label>
				<input type="text" class="form-control" name="name" placeholder="입력하세요">
			</div>
			
			<div class="row">
				<label for="text">나이</label>
				<input type="text" class="form-control" name="age" placeholder="입력하세요">
			</div>
			
			<div class="row">
				<label for="text">비밀번호</label>
				<input type="password" class="form-control" name="pass" placeholder="입력하세요">
			</div>
			
			<div class="row">
				<label for="text">종류</label>
				<select class="form-control" name="type">
					<option value='1'>공지</option>
					<option value='2'>정보</option>
					<option value='3'>질문</option>
					<option value='4'>답변</option>
				</select>
			</div>
			
			<div class="row">
				<textarea class="form-control" rows=10 placeholder="내용을 입력하세요" name="memo"></textarea>
			</div>
			
			<div class="row">
				<button type="submit" class="btn btn-default btn-primary">확인</button>
			</div>
			
		</form>
	</div>
</div>

<script src="./js/bootstrap.min.js"></script>
	
</body>
</html>