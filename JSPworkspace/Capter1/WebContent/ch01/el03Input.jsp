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
    <title>el03input.jsp </title>

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

	<form class="form-horizontal" role="form" method="post" action="el04Print.jsp">
		<div class="form-group">
			<label for="title" class="col-md-2 visible-md visible-lg text-right">제목</label>
			<div class="col-md-10">
				<input type="text" name="title" class="form-control" placeholder="(필수)제목을 입력하세요">
			</div>
		</div>
		
		<div class="form-group">
			<label for="name" class="col-md-2 visible-md visible-lg text-right">이름</label>
			<div class="col-md-10">
				<input type="text" name="name" class="form-control" placeholder="(필수)이름을 입력하세요">
			</div>
		</div>
		
		<div class="form-group">
			<label for="address" class="col-md-2 visible-md visible-lg text-right">주소</label>
			<div class="col-md-8">
				<input type="text" name="address" class="form-control" placeholder="(필수)주소를 입력하세요">
				
			</div>
			<div class="col-md-2 text-right">
				<button type="button" class="btn btn-primary">검색</button>
			</div>
		</div>
		
		<div class="form-group">
			<label for="mobile" class="col-md-2 visible-md visible-lg text-right">휴대폰</label>
			<div class="col-md-10">
				<input type="tel" name="mobile" class="form-control" placeholder="(필수)010-0000-0000">
			</div>
		</div>
		
		<div class="form-group">
			<label for="연령" class="col-md-2 visible-md visible-lg text-right">연령</label>
			<div class="col-md-10">
				<select name="age" class="form-control" >
					<option value="0">=== 연령 선택 ===</option>
					<option value="10">10대</option>
					<option value="20">20대</option>
					<option value="30">30대</option>
				</select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="memo" class="col-md-2 visible-md visible-lg text-right">내용</label>
			<div class="col-md-10">
				<textarea name="memo" rows=10 class="form-control" placeholder="내용을 입력하세요"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-md-12 text-right">
				<button type="submit" class="btn btn-success">등록하기</button>
			</div>
		</div>
	
	
	</form>
	
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>