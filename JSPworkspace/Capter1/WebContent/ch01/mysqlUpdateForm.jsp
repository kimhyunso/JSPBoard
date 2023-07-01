<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <title>MySQL Update</title>

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
<style>
	.songLine{
		border-bottom:1px solid #AAAAAA;
	}
</style>

<div class="container">
	<header>
		<h2 class="text-primary">MySql List</h2>
	</header>
	
	<!-- form 태그는 브라우저 마다 간격이 틀림 -->
	<form role="form" method="post" action="mysqlInsert.jsp">
	
		<input type="hidden" name="idx" value="${IDX }">
	
		<div class="row songLine">
			<div class="col-md-2 hidden-xs hidden-sm">학과</div>
			<div class="col-md-10">
				<div class="input-group">
					<span class="input-group-addon">
						<span class="glyphicon glyphicon-education"></span>
					</span>
					<input type="text" name="major" class="form-control" placeholder="소속 학과 입력" value="${MAJOR }">
				</div>
			</div>
		</div>
	
	<div class="row songLine">
		<div class="col-md-2 hidden-xs hidden-sm">이름</div>
		<div class="col-md-10">
			<div class="input-group">
				<span class="input-group-addon">
					<span class="glyphicon glyphicon-user"></span>
				</span>
				<input type="text" name="name" class="form-control" placeholder="실명 입력" value="${NAME }">
			</div>
		</div>
	</div>
	
	<div class="row songLine">
		<div class="col-md-2 hidden-xs hidden-sm">나이</div>
		<div class="col-md-10">
			<div class="input-group">
				<span class="input-group-addon">
					<span>age</span>
				</span>
				<input type="text" name="age" class="form-control" placeholder="나이 입력" value="${AGE }">
			</div>
		</div>
	</div>
	
	<div class="row">&nbsp;</div>
	
	<div class="row text-center">
		<button type="submit" class="btn btn-danger">
			<span class="glyphicon glyphicon-refresh"> 변경</span>
		</button>
		
		<button type="button" class="btn btn-primary">
			<span class="glyphicon glyphicon-list-alt"> 목록</span>			
		</button>
	</div>
	
	</form>
	
</div>
	
</body>
</html>