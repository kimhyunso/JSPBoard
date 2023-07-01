<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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
    <title>WYSISWYG </title>

    <!-- Bootstrap -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <link href="./css/custom2.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

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
		<h2 class="text-primary">WYSISWYG</h2>
	</header>
	
	<script type="text/javascript">
		function bold() {
			var memo = document.getElementById('memo');
			var content = document.getElementById('content');
			document.execCommand('bold');
			
			memo.innerHTML = content.innerHTML;
		}
	</script>
	
	<form action="">
		<div class="row">
			<button type="button" class="btn btn-default" onclick="bold();">
				<span class="glyphicon glyphicon-bold"></span>
			</button>
			
			, U,
			<button type="button" class="btn btn-default">
			 <span class="glyphicon glyphicon-italic"></span>
			</button>
		</div>
		
		<div class="row" id="content" contenteditable="true" style="height:200px;">안녕하세요 홍길동입니다. 홍길동이누굴까요? English Test 1234567</div>
		
		<div class="row hidden">
			<textarea rows="15" id="memo" name="memo" class="form-control"></textarea>
		</div>
		
	</form>
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>