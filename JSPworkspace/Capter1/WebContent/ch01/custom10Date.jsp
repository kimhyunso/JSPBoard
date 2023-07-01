<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="date" value="<%=new Date() %>"></c:set>

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
    <title>custom03Catch.jsp </title>

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

	<p>
		format : 형식 맞추기(날짜, 숫자)<br>
		
	</p>
	
	<h3 class="text-success">Date Format</h3>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th>대상</th>
				<th>예제</th>
			</tr>		
		</thead>
		
		<tr>
			<td>오늘날짜</td>
			<td><fmt:formatDate value="${date }"/></td>
		</tr>
		
		<tr>
			<td>현재시간</td>		
			<td><fmt:formatDate value="${date }" type="time"/></td>
		</tr>
		
		<tr>
			<td>both</td>
			<td><fmt:formatDate value="${date }" type="both"/></td>
		</tr>
		
		<tr>
			<td>both, short</td>		
			<td><fmt:formatDate value="${date }" type="both" dateStyle="short"/></td>
		</tr>
		
		<tr>
			<td>both, long</td>		
			<td><fmt:formatDate value="${date }" type="both" dateStyle="long"/></td>
		</tr>
		
		<tr>
			<td>both, full</td>		
			<td><fmt:formatDate value="${date }" type="both" dateStyle="full"/></td>
		</tr>
		
		<tr>
			<td>yyyy-MM-ddd</td>		
			<td><fmt:formatDate value="${date }" type="time" pattern="yyyy-MM-dd"/></td>
		</tr>
		
		<tr>
			<td>yyyy/MM/dd</td>		
			<td><fmt:formatDate value="${date }" type="time" pattern="yyyy/MM/dd"/></td>
		</tr>
		
		<tr>
			<td>yyyy-MM-dd : hh:mm:ss</td>		
			<td><fmt:formatDate value="${date }" type="time" pattern="yyyy-MM-dd : HH:mm:ss"/></td>
		</tr>
		
		<tr>
			<td>요일</td>		
			<td><fmt:formatDate value="${date }" type="time" pattern="E"/></td>
		</tr>
		
		
	</table>
</body>
</html>