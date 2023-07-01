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
    <title>로그 상세보기</title>

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

<sql:query var="rs" dataSource="jdbc/Capter1">
	select * from log where idx = '${param.idx }'
</sql:query>

<div class="container">
	<div class="row rowLine">
		<div class="col-md-5 col-xs-5 col-sm-5">제목</div>
		<div class="col-md-2 col-xs-2 col-sm-2 ellipsis">이름</div>
		<div class="col-md-2 col-xs-2 col-sm-2">시간</div>
		<div class="col-md-2 col-xs-2 col-sm-2">IP</div>
	</div>
	
	<c:forEach var="logInfo" items="${rs.rows }">
		<div class="row rowLine">
			<div class="col-md-5 col-xs-5 col-sm-5 ellipsis">${logInfo.title }</div>
			<div class="col-md-2 col-xs-2 col-sm-2 ellipsis">${logInfo.name }</div>
			<div class="col-md-2 col-xs-2 col-sm-2">
				<c:if test="${fn:contains(logInfo.time, today) }">
					${fn:substring(logInfo.time, 11, 16) }
				</c:if>
				<c:if test="${fn:contains(logInfo.time, today) eq false }">
					${fn:substring(logInfo.time, 0, 10) }
				</c:if>
			</div>
			<div class="col-md-2 col-xs-2 col-sm-2">${logInfo.ip }</div>
		</div>
	</c:forEach>
	
	<div class="row rowLine">
		<div class="col-md-12 text-center" style="margin-top:300px;">
			<button class="btn btn-info btn-lg" onClick="window.close();"><span class="glyphicon glyphicon-ok"></span> 확인</button>
		</div>
	</div>
	
	
</div>

</body>
</html>