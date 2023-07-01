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
    <title>MySQL</title>

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
	<form action="form" role="form" method="post" action="">
		<div class="row songLine">
			<div class="col-md-2 col-xs-2 col-sm-2">학과</div>
			<div class="col-md-10 col-xs-10 col-sm-10"><input type="text" class="form-control" placeholder="소속 학과 입력"></div>
		</div>
	</form>
	
	<form role="form" method="post" action="mysqlInsert.jsp">
		<div class="row songLine">
			<div class="col-md-2 hidden-xs hidden-sm">학과</div>
			<div class="col-md-10">
			<div class="input-group">
				<span class="input-group-addon">
					<span class="glyphicon glyphicon-education"></span>
				</span>
				<input type="text" name="major" class="form-control" placeholder="소속 학과 입력"></div>
			</div>
		</div>
	
	<div class="row songLine">
		<div class="col-md-2 hidden-xs hidden-sm">이름</div>
		<div class="col-md-10">
		<div class="input-group">
			<span class="input-group-addon">
				<span class="glyphicon glyphicon-user"></span>
			</span>
			<input type="text" name="name" class="form-control" placeholder="실명 입력"></div>
		</div>
	</div>
	
	
	<div class="row songLine">
		<div class="col-md-2 hidden-xs hidden-sm">나이</div>
		<div class="col-md-10">
		
		<div class="input-group">
			<span class="input-group-addon">
				<span>age</span>
			</span>
			<input type="text" name="age" class="form-control" placeholder="나이 입력"></div>
		</div>
		
	</div>
	
	<div class="row">&nbsp;</div>
	
	<div class="row text-center">
		<button type="submit" class="btn btn-success">
		<span class="glyphicon glyphicon-floppy-saved"> 등록</span>
		</button>
	</div>
	
	</form>
	listSize = ${listSize } <br>
	
	<div class="row songLine">
		<div class="col-md-1 hidden-xs hidden-sm">순서</div>
			<div class="col-md-3 col-xs-4 col-sm-4">학과</div>
			<div class="col-md-3 col-xs-4 col-sm-4">이름</div>
			<div class="col-md-2 hidden-xs hidden-sm">나이</div>
			<div class="col-md-3 col-xs-4 col-sm-4">
		</div>
	</div>
	
	<c:if test="${listSize ge 1 }">
		<script type="text/javascript">
			function confirmDelete(pidx){
				if(confirm('정말 삭제하시겠습니까?')){
					location.href='mysqlDelete.jsp?idx='+pidx;					
				}
			}		
		</script>
	
		<c:forEach var="cnt" begin="0" end="${listSize-1 }">
			<div class="row songLine">
				<div class="col-md-1 hidden-xs hidden-sm">${listIdx[cnt] }</div>
				<div class="col-md-3 col-xs-4 col-sm-4">${listMajor[cnt] }</div>
				<div class="col-md-3 col-xs-4 col-sm-4">${listName[cnt] }</div>
				<div class="col-md-2 hidden-xs hidden-sm">${listAge[cnt] }</div>
				<div class="col-md-3 col-xs-4 col-sm-4">
					<!-- span 영역을 지정함 -->
					<button type="button" class="btn btn-primary" onclick="location.href='mysqlGetData.jsp?idx=${listIdx[cnt]}'">
						<span class="glyphicon glyphicon-refresh"> 변경</span>
					</button>
					<button type="button" class="btn btn-danger" onclick="confirmDelete(${listIdx[cnt]});">
						<span class="glyphicon glyphicon-remove"> 삭제</span>
					</button>
				</div>
			</div>		
		</c:forEach>
	</c:if>
	
</div>
	
</body>
</html>