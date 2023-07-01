<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    <title>ID 조회</title>

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
  
  <style>
  
  	.rowLine{
  		padding-top:10px;
  		padding-bottom:10px;
  	}
  	
  	.ellipsis{
		white-space:nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
  	}
  	
  	.myBadge{
  		background-color: #ff0000;
  	}
  	
  	.myCheckbox {
    	width:20px; height:20px;
    }
  	
  </style>
  
  </head>
<body>
<div class="container">

	<div class="row rowLine">
		<div class="col-md-12"><h3 class="text-primary"><span class="glyphicon glyphicon-search"></span> <label>아이디 조회</label></h3></div>
	</div>
	
	<form method="post" action="checkID.jsp">
		<div class="row">
			<div class="col-md-9 col-xs-9 col-sm-9"><input type="text" name="id" class="form-control" value="${param.id }" placeholder="검색할 아이디" required></div>
			<div class="col-md-3 col-xs-3 col-sm-3"><button class="btn btn-primary"><span class="glyphicon glyphicon-search"></span> 검색</button></div>		
		</div>
	</form>
	
	<br><br>
	
	<script>
	
		function useThisId(){
			opener.document.joinForm.id.value='${param.id}';
			window.close();
		}
	
	</script>
	
	
	<c:if test="${not empty param.id }">
		<sql:query var="rs" dataSource="jdbc/Capter1">
			select * from member_table where id = '${param.id }'
		</sql:query>
		
		<c:forEach var="row" items="${rs.rows }">
			<c:set var="result" value="이미 사용중입니다."/>
		</c:forEach>
		
		<c:if test="${empty result }">
			<div class="row rowLine">
				<div class="col-md-3 col-sm-3 col-xs-3">
					조회 결과
				</div>
				<div class="col-md-5 col-sm-5 col-xs-5">
					사용 가능
				</div>
				
				<div class="col-md-4 col-sm-4 col-xs-4">
					<button class="btn btn-primary" type="button" onClick="useThisId();">${param.id } 사용하기</button>
				</div>
			</div>
				
		</c:if>
		
		<c:if test="${not empty result }">
			<div class="row rowLine">
				<div class="col-md-3 col-sm-3 col-xs-3">
					조회 결과
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9">
					<button class="btn btn-danger" type="button">${param.id }이미 사용중인 아이디입니다.</button>
				</div>
			</div>
		</c:if>
		
	</c:if>
	
</div> <!-- container 끝 -->

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>